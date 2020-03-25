.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Configuring the CentOS / RedHat server
  :keywords: CentOS7, WAPT, installer, documentation

.. _install_base_centos:

Configuring the CentOS/ RedHat server
+++++++++++++++++++++++++++++++++++++

In order to install a fresh CentOS7 machine (virtual or physical)
without graphical interface (choose **minimal** installation),
please refer to official `CentOS documentation <https://www.centos.org/docs/>`_.
This documentation is also valid for Redhat7 initial installation.

.. _installation_centos_manuelle:

Configuring network parameters
""""""""""""""""""""""""""""""

.. include:: ../../wapt-common-resources/linux-server-naming.rst

Configuring the name of WAPT Server
"""""""""""""""""""""""""""""""""""

.. hint::

  The short name of the WAPT Server must not be longer than 15 characters
  (the limit is due to sAMAccountName restriction in Active Directory).

The name of the WAPT Server must be a :abbr:`FQDN (Fully Qualified Domain Name)`,
that is to say it has both the server name and the DNS suffix.

* modify the :file:`/etc/hostname` file and write the :term:`FQDN` of the server;

.. code-block:: bash

  # /etc/hostname du waptserver
  srvwapt.mydomain.lan

* configure the :file:`/etc/hosts` file, be sure to put both
  the :term:`FQDN` and the short name of the server;

.. code-block:: bash

  # /etc/hosts du waptserver
  127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
  ::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
  10.0.0.10   srvwapt.mydomain.lan srvwapt

.. hint::

  * on the line defining the DNS server IP address, be sure to have the IP
    of the server (not 127.0.0.1), then the :term:`FQDN`, then the short name;

  * do not change the line with :file:`localhost`;

Configuring the IP address of the WAPT Server
"""""""""""""""""""""""""""""""""""""""""""""

* modify the :file:`/etc/sysconfig/network-scripts/ifcfg-eth0` file
  and define a static IP address. The name of the file can be different,
  like :file:`ifcfg-ens0` for example;

.. code-block:: bash

  # /etc/sysconfig/network-scripts/ifcfg-eth0 du serveur wapt
  TYPE="Ethernet"
  BOOTPROTO="static"
  NAME="eth0"
  ONBOOT="yes"
  IPADDR=10.0.0.10
  NETMASK=255.255.255.0
  GATEWAY=10.0.0.254
  DNS1=10.0.0.1
  DNS2=10.0.0.2

* apply the network configuration by rebooting the machine
  with a :code:`reboot`;

  .. code-block:: bash

    reboot

* if it has not already been done, :ref:`create the DNS entries
  for the WAPT Server <srv_dns>` in the :term:`Organization` Active Directory;

* after reboot, configure the system language in English in order to have
  non-localized logs for easier searching of common errors;

.. code-block:: bash

  localectl set-locale LANG=en_US.utf8
  localectl status

* check that the machine clock is on time (with NTP installed),
  and that SELinux and the firewall are enabled;

  .. code-block:: bash

    yum list installed | grep ntp
    service ntpd status
    date
    sestatus
    systemctl status firewalld

.. hint::

  If the NTP package is not installed.

  .. code-block:: bash

    yum install ntp
    systemctl enable ntpd.service
    systemctl start ntpd

* update CentOS7 and set up the :abbr:`EPEL (Extra Packages
  for Enterprise Linux)` repository;

.. code-block:: bash

  yum update
  yum install epel-release wget sudo

You may now go on to the next step and :ref:`install WAPT on your
CentOS/ RedHat <install_wapt_centos>`.
