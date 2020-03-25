.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Performing minor updates on a CentOS/ RedHat based WAPT Server
  :keywords: CentOS, RedHat, WAPT, documentation, examples, update, updating

.. _wapt_minor_upgrade_centos:

Performing minor updates on a CentOS/ RedHat based WAPT Server
--------------------------------------------------------------

.. attention::

  Ports 80 and 443 are used by the WAPT Server and must be available.

* first of all, update the CentOS/ RedHat underlying distribution:

  .. code-block:: bash

    yum update

WAPT Enterprise
+++++++++++++++

Modify the repository address then launch the upgrade.

.. hint::

   To access WAPT Enterprise ressources, you must use the username and password
   provided by our sales department.

   Replace **user** and **password** in the **baseurl** parameter
   to access WAPT Enterprise repository.

.. code-block:: bash

  cat > /etc/yum.repos.d/wapt.repo <<EOF
  [wapt]
  name=WAPT Enterprise Server Repo
  baseurl=https://user:password@srvwapt-pro.tranquil.it/entreprise/centos7/wapt-1.8/
  enabled=1
  gpgcheck=1
  EOF

  wget -q -O /tmp/tranquil_it.gpg "https://wapt.tranquil.it/centos7/RPM-GPG-KEY-TISWAPT-7"; rpm --import /tmp/tranquil_it.gpg
  yum install epel-release
  yum install cabextract
  yum install postgresql96-server postgresql96-contrib tis-waptserver tis-waptsetup

WAPT Community
++++++++++++++

* modify the repository address then launch the upgrade:

.. code-block:: bash

  cat > /etc/yum.repos.d/wapt.repo <<EOF
  [wapt]
  name=WAPT Server Repo
  baseurl=https://wapt.tranquil.it/centos7/wapt-1.8/
  enabled=1
  gpgcheck=1
  EOF

  wget -q -O /tmp/tranquil_it.gpg "https://wapt.tranquil.it/centos7/RPM-GPG-KEY-TISWAPT-7"; rpm --import /tmp/tranquil_it.gpg
  yum install postgresql96-server postgresql96-contrib tis-waptserver tis-waptsetup

Post-configuration
++++++++++++++++++

* launch the post-configuration step:

  .. note::

    * we advise that you launch the post-configuration steps after each server
      upgrade so that the server uses the latest configuration format;

    * it is not required to reset a password for the WAPT console during
      the post-configuration step;

    * if you have personalized the configuration of :program:`Nginx`,
      do not answer :guilabel:`Yes` when the post-configuration asks you
      to configure :program:`Nginx`;

  .. attention::

    * with WAPT 1.8 post-configuration, WAPT WUA packages will be moved
      from their current storage location
      to the waptwua root folder (:file:`/var/www/waptwua`).

    * if repository replication has been set, all KB/CAB packages
      will be re-synchronized on remote repositories.

  .. code-block:: bash

    /opt/wapt/waptserver/scripts/postconf.sh

* start the WAPT Server:

  .. code-block:: bash

    systemctl start waptserver

* upgrade the WAPT console by following the same set of steps
  as :ref:`installing the WAPT console <installing_the_WAPT_console>`;

* then :ref:`create the WAPT agent <create_WAPT_agent>`:

  You will have to keep the same prefix for your packages and change nothing
  in relation to the private key/ public certificate pair!

  This will generate a **waptupgrade** package in the private repository.

  .. note::

    There are two methods for deploying the updates:

    * using a :abbr:`GPO (Group Policy Object)` and :program:`waptdeploy`;

    * using a :program:`waptupgrade` package and deploy it using WAPT;

* update the WAPT agents:

  The steps to follow to update WAPT agents are the same as the ones
  to first install the WAPT agents.

  Download and install the latest version of the WAPT agent
  by visiting http://wapt.mydomain.lan/wapt/waptagent.exe.

  As mentioned above, this procedure may be made automatic with a GPO
  or a **waptupgrade** package.
