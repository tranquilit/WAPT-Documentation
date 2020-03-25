
.. _syncthing_usage:

(Deprecated) Introducing Syncthing
----------------------------------

.. hint::

  WAPT repositories synchronization is now native in WAPT Enterprise.

  You can find the new documentation here: :ref:`replication_usage`.

Syncthing is a multi-OS open source peer to peer synchronization utility.

It allows to synchronize folders on several machines while guaranteeing
the security, the authenticity and the integrity of the files.

The official Syncthing documentation is available
`online <https://docs.syncthing.net/>`_.

Implementing the replication
++++++++++++++++++++++++++++

.. hint::

  The following documentation is applicable to Linux Debian and CentOS/ RedHat
  based WAPT Servers and remote repositories.

Setting up the remote WAPT repository
+++++++++++++++++++++++++++++++++++++

Debian Linux
""""""""""""

.. code-block:: bash

  echo  "deb  http://wapt.tranquil.it/debian/  ./  "  > /etc/apt/sources.list.d/wapt.list
  apt-get update
  apt-get upgrade
  apt-get install tis-waptrepo

CentOS/ RedHat Linux
""""""""""""""""""""

The remote WAPT repository is set up, we now must implement
the Syncthing replication.

Configuring the Syncthing service
"""""""""""""""""""""""""""""""""

.. code-block:: bash

  a2enmod ssl
  a2ensite default-ssl.conf

* modify the :program:`Apache` configuration files to define the correct roots
  of the *VirtualHosts*:

.. code-block:: bash

  /etc/apache2/sites-available/default-ssl.conf
  /etc/apache2/sites-available/000-default.conf

* change the value of *DocumentRoot* in each configuration file:

.. code-block:: bash

  - DocumentRoot /var/www/html
  + DocumentRoot /var/www

* finally, restart the :program:`Apache` web service
  to apply the new configuration:

.. code-block:: bash

  /etc/init.d/apache2 restart

.. note::

  It is advisable to specify valid SSL certificates in the Apache configuration
  of remote repositories.

* empty the content of the folders :file:`/var/www/wapt`
  and :file:`/var/www/wapt-host`; Syncthing will fill again these folders
  with data from the main repository.

.. code-block:: bash

  rm -rf /var/www/wapt/*
  rm -rf /var/www/wapt-host/*

Installing Syncthing on main and remote WAPT repositories
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. note::

  This procedure is to be applied on the main repository
  and on the remote repositories.

.. literalinclude:: syncthing_install
  :language: bash

Configuring Syncthing
"""""""""""""""""""""

Operations to follow:

  * add the Syncthing service to :program:`systemd`;

  * change the listening port to **0.0.0.0**;

  * create an administrator account and enter a strong password;

  * activate the HTTPS protocole for the web access;

* create the definition file for the :program:`waptsync` service by editing
  :file:`/etc/systemd/system/waptsync.service`:

  .. code-block:: ini

    [Unit]
    Description=WAPT respository sync with syncthing
    Documentation=http://docs.syncthing.net/
    After=network.target
    ;Wants=syncthing-inotify@.service

    [Service]
    User=wapt
    ExecStart=/usr/bin/syncthing -logflags=0 -home=/opt/wapt/.config/syncthing/ -no-restart
    Restart=on-failure
    SuccessExitStatus=3 4
    RestartForceExitStatus=3 4

    [Install]
    WantedBy=multi-user.target

* create the tree structure required for the :program:`waptsync`
  service to start:

.. code-block:: bash

  mkdir /opt/wapt/.config/
  mkdir /opt/wapt/.config/syncthing/

* change the owner of the files:

.. code-block:: bash

  chown -R wapt:www-data /opt/wapt/.config/

* activate the :program:`waptsync` service and start it.
  The configuration files will appear in the
  :file:`/opt/wapt/.config/syncthing/` folder:

.. code-block:: bash

  systemctl enable waptsync
  systemctl start waptsync
  systemctl stop waptsync

* change the listening port in the
  :file:`/opt/wapt/.config/syncthing/config.xml` file:

.. code-block:: xml

  <gui enabled="true" tls="true" debugging="false">
      <address>0.0.0.0:8384</address>
      <apikey>4jvEiL24UbFddsdsAQxqsfixNaLt</apikey>
      <theme>default</theme>
  </gui>

* start the :program:`waptsync` service:

.. code-block:: bash

  systemctl start waptsync

Configuring Syncthing's web service
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Syncthing's web interface is now accessible by visiting http://<server_ip>:8384.

Operations to follow:

  * change the host name of the remote repository;

  * add a *GUI authorized user*;

  * add the password for the *GUI authorized user*;

  * check the box :guilabel:`Use HTTPS for the GUI`;

  * click on :guilabel:`Save`;

* connect with SSH on the WAPT Server and restart the Syncthing service:

.. code-block:: bash

  systemctl restart waptsync

Syncthing's web interface is now only accessible with HTTPS
on https://<server_ip>:8384.

* in the list of shared folders, remove the default folder:
  :menuselection:`Modify --> Remove`;

* configure the replication:

  .. include:: syncthing-share-setup.rst

* secure the replication:

By default, the following parameters are active in Syncthing:

.. tabularcolumns:: |\X{4}{12}|\X{8}{12}|

========================= ======================================================
Options                   Definition
========================= ======================================================
Activate the :term:`NAT`  Use a UPnP port mapping for incoming synchronization
                          connections.

Local discovery           Syncthing will then broadcast to announce itself
                          to other Syncthings.

Global discovery          Syncthing registers on an external cloud service
                          and can use this cloud based service to search
                          other Syncthing devices.
Possible relay            The use of relays allows to use external servers
                          to relay the communications. The relay is activated
                          by default but it will be used only if two devices
                          can not communicate directly between themselves.
========================= ======================================================

This operating mode simplifies the global setup but it is not the most advisable
method in relation to security.

  * uncheck all boxes in network configuration;

  * define the listening port (by default port 22000);

  * replace *default* by *tcp://0.0.0.0:22000*;

Then go on the web interface of the remote repositories,
click on :guilabel:`Change` and fill in the IP address of the remote repository:

  * replace *dynamic* by *tcp://<remote_repo_ip_address>:22000*;

This configuration is useful for limiting inbound connections
to the Syncthing service.

Configuring the WAPT agents
"""""""""""""""""""""""""""

WAPT clients on remote sites must now be configured to look for updates from
their closest available repositories.

Two solutions exist:

* use automatic detection via :term:`DNS` :term:`SRV` fields;

* change manually or via a WAPT package the parameter *repo_url*
  in the WAPT agent's :file:`wapt-get.ini` file;

Configuration example of the WAPT agent - filled in local repository:

.. code-block:: ini

  [global]
  waptupdate_task_period=120
  waptserver=https://srvwapt.mydomain.lan
  repo_url=https://localrepo.domain.lan/wapt/
  use_hostpackages=1

Example of a WAPT package designed to remotely change the *repo_url*
in :file:`wapt-get.ini`:

.. code-block:: python

  # -*- coding: utf-8 -*-
  from setuphelpers import *

  uninstallkey = []

  def install():
    print('Modifier la configuration agent pour le site de Colmar')
    inifile_writestring(WAPT.config_filename,'global','repo_url',
                      'https://wapt.city02.mydomain.lan/wapt/')
