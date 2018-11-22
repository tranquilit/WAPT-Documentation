.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
    :description: Upgrading WAPT from 1.3 to 1.6 on CentOS/ RedHat
    :keywords: WAPT, 1.3, 1.6, CentOS, RedHat, upgrade, upgrading, documentation

.. _upgrade_1.3_1.6_centos:

Upgrading WAPT from 1.3 to 1.6 on CentOS/ RedHat
================================================

.. note::

  We make the assumption that your WAPT Server is installed on a basic
  minimal install of CentOS7 (x64). If this is not the case, you may follow
  the documentation to :ref:`upgrade your base server <upgrade_host_server>`.

  This procedure aims to explain the migration of WAPT 1.3 to 1.6, only.

  The main differences between these two versions of WAPT are:

  .. tabularcolumns:: |\X{2}{12}|\X{4}{12}|\X{4}{12}|

  =============== ================== ===========================================
  Element         WAPT 1.3           WAPT 1.6
  =============== ================== ===========================================
  Database        :program:`MongoDB` :program:`PostgreSQL`

  Web server      :program:`Apache2` :program:`Nginx`

  WAPT agent      agent listening on agent initiating and maintaining a
                  port 8088          websocket with the server

  Signature       sha1 hashes        *Code Signing* certificate is required,
                                     :file:`control` file attributes are signed
                                     with sha256 hashes.
  =============== ================== ===========================================

  These changes require to follow scrupulously several operations
  for a smooth upgrade.

Uninstalling WAPT 1.3 from the CentOS/ RedHat server
""""""""""""""""""""""""""""""""""""""""""""""""""""

.. code-block:: bash

  yum remove tis-waptrepo tis-waptsetup tis-waptserver
  systemctl stop apache2
  systemctl disable apache2

Configuring the CentOS/ RedHat server
"""""""""""""""""""""""""""""""""""""

.. code-block:: bash

  localectl set-locale LANG=en_US.utf8
  localectl status
  yum update
  yum install epel-release wget sudo

Updating the CentOS / RedHat server
"""""""""""""""""""""""""""""""""""

.. code-block:: bash

  cat > /etc/yum.repos.d/wapt.repo <<
  [wapt]
  name=WAPT Server Repo
  baseurl=https://wapt.tranquil.it/centos7/wapt-1.6/
  enabled=1
  gpgcheck=0
  EOL

  yum install postgresql96-server postgresql96-contrib

Installing WAPT 1.6 on the CentOS / RedHat server
"""""""""""""""""""""""""""""""""""""""""""""""""

.. code-block:: bash

    yum install tis-waptserver
    sudo /usr/pgsql-9.6/bin/postgresql96-setup initdb
    sudo systemctl enable postgresql-9.6 waptserver nginx
    sudo systemctl start postgresql-9.6 nginx

.. note::

  The installation may ask you for the Kerberos realm. You may ignore it
  by pressing :guilabel:`Enter` to go on to the next step.

Launching the post-configuration script
"""""""""""""""""""""""""""""""""""""""

.. note::

  * we advise that you launch the post-configuration steps after each
    server upgrade so that the server uses the latest configuration format;

  * it is not required to reset a password for the WAPT console during the
    post-configuration step;

.. code-block:: bash

  /opt/wapt/waptserver/scripts/postconf.sh

The post-configuration step will offer you to change the password or to move
to the next step, you may choose to change the password if desired.

The post-configuration step will then detect that the current version is 1.3
and it will try to launch the process of migrating the MongoDB database
to PostgreSQL. Validate this step.

The post-configuration step will next offer you to configure
the :program:`Nginx` web server. Validate this step.

Starting up WAPT on the CentOS/ RedHat server
"""""""""""""""""""""""""""""""""""""""""""""

.. code-block:: bash

 systemctl enable waptserver
 systemctl start waptserver

Cleaning up the CentOS/ RedHat server
"""""""""""""""""""""""""""""""""""""

At the end of the migration process, it is necessary to clean the WAPT Server.

WAPT will use from now on :program:`Nginx` as its web server and
:program:`PostgreSQL` as its database server.

.. code-block:: bash

  yum remove apache2 mongodb

Installing the new WAPT console
"""""""""""""""""""""""""""""""

* download :program:`waptsetup`:
  https://srvwapt.mydomain.lan/wapt/waptsetup-tis.exe;

* start the installation; the configuration of the WAPT repository
  and server URLs has not changed;

* open the :program:`waptconsole` by selecting
  :file:`C:\Program Files (x86)\wapt\waptconsole.exe` (default location)
  or :file:`C:\wapt\waptconsole.exe` (older WAPT versions);

* check that the WAPT Server works correctly by clicking on the
  :guilabel:`wrench icons` and the button :guilabel:`Verify`!

You may now go to the next step to :ref:`generate the necessary
keys <key-regenerate>`.
