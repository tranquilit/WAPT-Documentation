.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
    :description: Installing the WAPT Server on CentOS / RedHat
    :keywords: Server, WAPT Centos, install, installation, RedHat, documentation

.. _install_wapt_centos:

Installing the WAPT Server on CentOS / RedHat
+++++++++++++++++++++++++++++++++++++++++++++

.. attention::

  The upgrade procedure is different from installation. For upgrade, please
  refer to :ref:`Upgrading the WAPT Server <upgrade-wapt>`.

Installing the WAPT Server runs a few steps:

* configuring the repositories;

* installing additional Linux packages;

* installing and provisioning the PostgreSQL database;

* post-configuring the WAPT Server;

Configuring RPM repositories and installing WAPT and PostgreSQL packages
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

The configuration of repositories for **WAPT Enterprise**
and **WAPT Community** Edition differs. **Make sure to choose the right one!**

During installation, you may be asked for the Kerberos realm. Just press
:kbd:`Enter` to skip this step.

.. important::

  **Follow this procedure for getting the right packages
  for the WAPT Enterprise** Edition.
  For WAPT Community Edition please refer to the next block.

    To access WAPT Enterprise ressources, you must use the username
    and password provided by our sales department.

    Replace **user** and **password** in the **baseurl** parameter
    to access WAPT Enterprise repository.

    .. code-block:: bash

      cat > /etc/yum.repos.d/wapt.repo <<EOF
      [wapt]
      name=WAPT Server Repo
      baseurl=https://user:password@srvwapt-pro.tranquil.it/entreprise/centos7/wapt-1.8/
      enabled=1
      gpgcheck=1
      EOF

.. important::

  **Follow this procedure for getting the right packages
  for the WAPT Community** Edition.
  For WAPT Enterprise Edition please refer to the previous block.

  .. code-block:: bash

    cat > /etc/yum.repos.d/wapt.repo <<EOF
    [wapt]
    name=WAPT Server Repo
    baseurl=https://wapt.tranquil.it/centos7/wapt-1.8/
    enabled=1
    gpgcheck=1
    EOF

Installing the WAPT Server packages
"""""""""""""""""""""""""""""""""""

.. code-block:: bash

  wget -q -O /tmp/tranquil_it.gpg "https://wapt.tranquil.it/centos7/RPM-GPG-KEY-TISWAPT-7"; rpm --import /tmp/tranquil_it.gpg
  yum install epel-release
  yum install postgresql96-server postgresql96-contrib tis-waptserver tis-waptsetup cabextract

Post-configuring
""""""""""""""""

* initialize the PostgreSQL database and activate the services:

  .. code-block:: bash

    sudo /usr/pgsql-9.6/bin/postgresql96-setup initdb
    sudo systemctl enable postgresql-9.6 waptserver nginx
    sudo systemctl start postgresql-9.6 nginx

.. attention::

  For post-configuration to work properly, you must first have properly
  configured the *hostname* of the WAPT server.
  To check, use the command :code:`echo $(hostname)` which must return
  the DNS address that will be used by WAPT agents on client computers.

.. hint::

  This post-configuration script must be run as **root**.

* run the script:

  .. code-block:: bash

        /opt/wapt/waptserver/scripts/postconf.sh

* click on :guilabel:`Yes` to run the postconf script:

  .. code-block:: bash

     do you want to launch post configuration tool?

            < yes >          < no >

* choose a password for the :term:`SuperAdmin` account of the WAPT server
  (minimum length is 10 characters);

  .. code-block:: bash

    Please enter the wapt server password (min. 10 characters)

    *****************

            < OK >          < Cancel >

* confirm the password;

  .. code-block:: bash

    Please enter the server password again:

    *****************

            < OK >          < Cancel >

* choose the authentication mode for the initial registering of the WAPT agents;

  * choice #1 allows to register computers without authentication
    (same method as WAPT 1.3). The WAPT server registers all computers that ask;

  * Choice #2 activates the initial registration based on Kerberos. (you can activate it later);

  * choice #3 does not activate the kerberos authentication mechanism for the
    initial registering of machines equipped with WAPT. The WAPT server will
    require a login and password for each machine registering with it;

  .. code-block:: bash

    WaptAgent Authentication type?

    -------------------------------------------------------------------------------------------------------------------------------------
    (*) 1 Allow unauthenticated registration, same behavior as wapt 1.3
    ( ) 2 Enable kerberos authentication required for machines registration. Registration will ask for password if kerberos not available
    ( ) 3 Disable Kerberos but registration require strong authentication
    -------------------------------------------------------------------------------------------------------------------------------------
                                                       < OK >          < Cancel >

* select :guilabel:`OK` to start WAPT Server;

  .. code-block:: bash

    Press OK to start waptserver

           < OK >

* select :guilabel:`Yes` to configure Nginx;

  .. code-block:: bash

     Do you want to configure nginx?

        < Yes >        < No >

* fill in the :term:`FQDN` of the WAPT server;

  .. code-block:: bash

     FQDN for the WAPT server (eg. wapt.acme.com)

     ---------------------------------------------
     wapt.mydomain.lan
     ---------------------------------------------

           < OK >          < Cancel >

* select :guilabel:`OK` and a self-signed certificate will be generated,
  this step may take a long time ...

  .. code-block:: bash

    Generating DH parameters, 2048 bit long safe prime, generator 2
    This is going to take a long time
    .......................................+...............................+...

Nginx is now configured, select :guilabel:`OK` to restart :program:`Nginx`:

.. code-block:: bash

   The Nginx config is done.
   We need to restart Nginx?

         < OK >

The post-configuration is now finished.

.. code-block:: bash

   Postconfiguration completed.
   Please connect to https://wapt.mydomain.lan/ to access the server.

                    < OK >

Listing of post-configuration script options:

.. list-table::
  :header-rows: 1
  :widths: 40 60

  * - Flag
    - Description
  * - ``--force-https``
    - Configures :program:`Nginx` so that *port 80 is permanently
      redirected to 443*

The WAPT Server is now ready.

You may go to the documentation on :ref:`installing
the WAPT console <installing_the_WAPT_console>`!!
