.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
    :description: Upgrading WAPT from 1.3 to 1.6 on Debian
    :keywords: WAPT, 1.3, 1.6, Debian, upgrade, upgrading, documentation

.. _upgrade_1.3_1.6_debian:

Upgrading WAPT from 1.3 to 1.6 on Debian
========================================

Preamble
""""""""

.. note::

  We make the assumption that your WAPT Server is installed on a basic minimal
  install of Debian9 (x64). If this is not the case, you may follow
  the documentation to :ref:`upgrade your base server <upgrade_host_server>`.

  This procedure aims to explain the migration of WAPT 1.3 to 1.6, only.

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

Install systemd and ca-certificates
"""""""""""""""""""""""""""""""""""

* install systemd

.. code-block:: bash

    apt-get install systemd

* install ca-certificates:

.. code-block:: bash

    apt-get install ca-certificates

* restart the WAPT service:

.. code-block:: bash

   reboot

Uninstalling WAPT 1.3 from the Debian server
""""""""""""""""""""""""""""""""""""""""""""

.. code-block:: bash

  apt-get remove tis-waptrepo tis-waptsetup tis-waptserver
  systemctl stop apache2
  systemctl disable apache2

Setting up the GNU/ Linux Debian server
"""""""""""""""""""""""""""""""""""""""

.. code-block:: bash

    apt-get update && apt-get upgrade
    apt-get install apt-transport-https lsb-release
    wget -O - https://wapt.tranquil.it/debian/tiswapt-pub.gpg  | apt-key add -
    echo  "deb  https://wapt.tranquil.it/debian/wapt-1.6/ $(lsb_release -c -s) main"  > /etc/apt/sources.list.d/wapt.list
    apt-get update

Installing WAPT 1.6 on the Debian server
""""""""""""""""""""""""""""""""""""""""

.. code-block:: bash

   apt-get install tis-waptserver tis-waptsetup

.. note::

    The installation may ask you for the Kerberos realm. You may ignore
    it by pressing :guilabel:`Enter` to go on to the next step.

Launching the post-configuration script
"""""""""""""""""""""""""""""""""""""""

.. note::

  * we advise that you launch the post-configuration steps after each
    server upgrade so that the server uses the latest configuration format;

  * it is not required to reset a password for the WAPT console during the
    post-configuration step;

.. code-block:: bash

  /opt/wapt/waptserver/scripts/postconf.sh

The post-configuration step will offer you to change the password or to move to
the next step, you may choose to change the password if desired.

The post-configuration step will then detect that the current version is 1.3
and it will try to launch the process of migrating the MongoDB database
to PostgreSQL.

The post-configuration step will next offer you to configure the
:program:`Nginx` web server. Validate this step.

Starting up WAPT on the Debian server
"""""""""""""""""""""""""""""""""""""

.. code-block:: bash

  systemctl enable waptserver
  systemctl start waptserver

Cleaning up the Debian server
"""""""""""""""""""""""""""""

At the end of the migration process, it is necessary to clean the WAPT Server.

WAPT will use from now on :program:`Nginx` as its web server and
:program:`PostgreSQL` as its database server.

.. code-block:: bash

  apt-get remove apache2 mongodb
  apt-get autoremove
  apt-get clean

Installing the new WAPT console
"""""""""""""""""""""""""""""""

* download :program:`waptsetup`:
  https://srvwapt.mydomain.lan/wapt/waptsetup-tis.exe;

* start the installation; the configuration of the WAPT repository
  and server URLs has not changed;

* open the :program:`waptconsole` by selecting
  :file:`C:\\Program Files (x86)\\wapt\\waptconsole.exe` (default location)
  or :file:`C:\\wapt\\waptconsole.exe` (older WAPT versions);

* check that the WAPT Server works correctly by clicking on the
  :guilabel:`wrench icons` and the button :guilabel:`Verify`!

You may now go to the next step to :ref:`generate the necessary
keys <key-regenerate>`.
