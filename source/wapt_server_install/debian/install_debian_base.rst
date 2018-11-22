.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Setting up the GNU/Linux Debian server
  :keywords: Debian, WAPT, installer, documentation

.. _install_base_debian:

Setting up the GNU/Linux Debian server
++++++++++++++++++++++++++++++++++++++

In order to install a fresh Debian Linux 9 *Stretch* (physical or virtual)
without graphical interface, please refer to the
`Debian GNU/Linux Installation Guide <https://www.debian.org/releases/stretch/amd64/>`_.

.. _installation_debian_manuelle:

Configuring network parameters
""""""""""""""""""""""""""""""

.. include:: ../../wapt_common_resources/linux_server_naming.rst

Configuring the name of WAPT Server
"""""""""""""""""""""""""""""""""""

.. hint::

  The short name of the WAPT Server must not be longer
  than 15 characters (the limit is due to sAMAccountName restriction
  in Active Directory).

The name of the WAPT Server must be a :abbr:`FQDN (Fully Qualified Domain Name)`,
that is to say it has both the server name and the DNS suffix.

* modify the :file:`/etc/hostname` file and write the :term:`FQDN` of the server;

.. code-block:: bash

  # /etc/hostname du waptserver
  srvwapt.mydomain.lan

* configure the :file:`/etc/hosts` file, be sure to put both the :term:`FQDN`
  and the short name of the server;

.. code-block:: bash

  # /etc/hosts du waptserver
  127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
  ::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
  10.0.0.10   srvwapt.mydomain.lan     srvwapt

.. hint::

  * on the line defining the DNS server IP address, be sure to have the IP
    of the server (not 127.0.0.1), then the :term:`FQDN`, then the short name;

  * do not change the line with :file:`localhost`;

Configuring the IP address of the WAPT Server
"""""""""""""""""""""""""""""""""""""""""""""

* configure the IP address of the WAPT Server
  in the :file:`/etc/network/interfaces`;

.. code-block:: bash

  # /etc/network/interfaces du serveur wapt
  auto eth0
  iface eth0 inet static
    address 10.0.0.10
    netmask 255.255.255.0
    gateway 10.0.0.254

* apply the network configuration by rebooting the machine
  with a :code:`reboot`;

* if it has not already be done, create the DNS entry for the WAPT Server
  in the :term:`Organization`'s Active Directory;

* :ref:`srv_dns`

* after reboot, configure the system language in English in order to have
  non-localized logs for easier searching of common errors;

.. code-block:: bash

  apt-get install locales-all
  localectl set-locale LANG=en_US.UTF-8
  localectl status

* check that the machine clock is on time (with NTP installed);

.. code-block:: bash

  dpkg -l | grep ntp
  service ntp status
  date

.. hint::

  If the NTP package is not installed.

  .. code-block:: bash

    apt install ntp
    systemctl enable ntp
    systemctl start ntp

* update and upgrade your Debian;

  .. code-block:: bash

    apt-get update
    apt-get upgrade

* install systemd;

  .. code-block:: bash

    apt-get install systemd

* install certificates;

  .. code-block:: bash

     apt-get install ca-certificates

* restart server;

  .. code-block:: bash

     reboot

You may no go on to the next step and :ref:`install WAPT on your Debian
<install_wapt_debian>`.
