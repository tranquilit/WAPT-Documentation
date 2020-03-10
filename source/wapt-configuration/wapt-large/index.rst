.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
    :description: Configuring WAPT Server for large deployments
    :keywords: install, WAPT, documentation, optimization, large deployment

.. _configuring_WAPT_for_large_deployment:

Configuring WAPT Server for large deployments
=============================================

The default operating system, Nginx and Postgresql settings are adapted for
around 400 WAPT agents. If you have more than 400 clients it is necessary to
modify a few system level parameters along with PostgreSQL database,
Nginx web and WAPT Server python server.

In the future the :code:`postconf.sh` script might take charge of
this configuration depending on the expected number of client computers

With the following parameters, one WAPT Server should scale up to around 5000
concurrent active clients. You may have more clients in the database if they
are not all running at the same time. If you have more than 5000 clients it is
recommended to have more than one WAPT Server.

The limit in the number of end point clients is due to the bottleneck in the
python code and the PostgreSQL backend.
WAPT performance gets better with time and in the future
WAPT Server might support a large base on a single server. However the Nginx
part scales very well and it can takes full advantage of a 10Gbps connection for
high load package deployments.

Configuration changes for better performance
--------------------------------------------

.. note::

  **The parameters to be modified below are linked together
  and should be modified globally and not individually**.

Configuring Nginx
+++++++++++++++++

In the :file:`/etc/nginx/nginx.conf` file, modify ``worker_connections``
parameter. The value should be around 2.5 times the number of WAPT clients
(n connections for websockets and n connections for package downloads
and inventory upload + some margin).

.. code-block:: bash

   events {
       worker_connections 4096;
   }

Then upgrade the number of *filedescriptors*
in the :file:`/etc/nginx/nginx.conf` file:

.. code-block:: bash

   worker_rlimit_nofile 32768;

Configuring the Linux System
++++++++++++++++++++++++++++

Increase the number of *filedescriptors*. The system unit file asks
for an increase in the allowed number of *filedescriptors* (LimitNOFILE=32768).
We should have the same thing for Nginx. There are a few limits to modify.

First we modify system wide the number of *filedescriptors* allowed
for Nginx and WAPT.

* create the :file:`/etc/security/limits.d/wapt.conf`:

  .. code-block:: bash

     cat > /etc/security/limits.d/wapt.conf <<EOF
     wapt         hard    nofile      32768
     wapt         soft    nofile      32768
     www-data     hard    nofile      32768
     www-data     soft    nofile      32768
     EOF

Nginx serves as a reverse proxy and makes quite a lot of connections.
Each WAPT client keeps a *websocket* connection up all the time in order
to respond to actions from the WAPT Server.

The Linux kernel has a protection against having too many TCP connections
opened at the same time and one may get the *SYN flooding on port* message
in the Nginx log. In order to avoid these messages, it is necessary to modify
the two following parameters. It must around 1.5 times the number of WAPT clients.

.. code-block:: bash

   cat > /etc/sysctl.d/wapt.conf <<EOF
   net.ipv4.tcp_max_syn_backlog=4096
   net.core.somaxconn=4096
   EOF

   sysctl --system

Configuring the PostgreSQL database
+++++++++++++++++++++++++++++++++++

A higher number of clients need a higher number of connections to the PostgreSQL
database. In the :file:`postgresql.conf`
file (file:`/etc/postgresql/11/main/postgresql.conf` on debian 10 for example),
you need to increase the following parameter to approximately 1/4
the number of active WAPT agents.

.. code-block:: bash

   max_connections = 1000

Configuring the WAPT Server
+++++++++++++++++++++++++++

In :file:`/opt/wapt/conf/waptserver.ini` file, ``db_max_connections``
should be equal to PostgreSQL ``max_connections`` minus 10 (PostgreSQL needs
to keep some connections for its housekeeping stuff). The ``max_clients``
parameter should be set around 1.2 times the number of WAPT agents:

.. code-block:: ini

   [options]
   ...
   max_clients = 4096
   db_max_connections =  990

Configuration for large package upload
--------------------------------------

Depending on the partitioning of your WAPT server you might have to be careful
with the Nginx temporary file upload directory. Nginx acts as a reverse proxy
for the WAPTServer Python engine and its does a caching of packages uploaded
when uploading a new package from the console.

The packages are stored in the :file:`/var/lib/nginx/proxy` directory.
You have to make sure that the partition hosting this directory is large enough.
You may change this directory location using the following Nginx
configuration parameter.

.. code-block:: ini

   $client_body_temp_path
