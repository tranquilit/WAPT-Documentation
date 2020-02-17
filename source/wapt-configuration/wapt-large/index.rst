.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
    :description: Configuring WAPTServer for large deployement
    :keywords: install, WAPT, documentation, optimization, large deployment

.. _configuring_WAPT_for_large_deployment:

Configuring WAPT Server for large deployment
============================================

The default operating system, Nginx and Postgresql configuration is adapted for
around 400 clients in WAPTServer. If you have more than 400 clients it is necessary to 
modify a few system level parameters along with database, nginx and waptserver python server.

In the future the postconf.sh script might take in charge this configuration 
depending on the expected number of client computer. 

With the following parameters one WAPT Server should scale up to around 5000 
concurent active client. You may have more clients in the database if they 
are not all up at the same time. If you have more than 5000 clients it is 
recommanded to have more than one WAPT Server. 

The limit in the number of end point clients is due to the bottleneck in the 
python code and the PostgreSQL backend. WAPT performance gets better with time and
in the future it might support a large base on a single server. However the Nginx
part scales very well and it can takes full advantage of a 10GiB connection for
large package deployement.

Configuration change for better performance
-------------------------------------------

.. note::

   The parameters that are modified below are linked together and should be done globally
   and not individually.

Configuring Nginx
+++++++++++++++++

In the :file:`/etc/nginx/nginx.conf` file, modify `worker_connections` parameter. 
The value should be around 2.5 time the number of WAPT clients (n connexions 
for websockets and n connections for packages downloads and inventory upload + 
some margin).

.. code-block:: bash 

   events {
       worker_connections 4096;
   }

Then upgrade the number of filedescriptor in the :file:`/etc/nginx/nginx.conf` file : 

.. code-block:: bash

   worker_rlimit_nofile 32768;

Configuring the Linux System
++++++++++++++++++++++++++++

Increase the number of filedescriptor. The systemd unit file asks for an increase
in allowed number of filedescriptor (LimitNOFILE=32768). We should have the same 
thing for Nginx. There are a few limits to modify.

First we modify system wide the number of filedescriptor allow for nginx and wapt.
Create the :file:`/etc/security/limits.d/wapt.conf` : 

.. code-block:: bash

   cat > /etc/security/limits.d/wapt.conf <<EOF 
   wapt         hard    nofile      32768
   wapt         soft    nofile      32768
   www-data     hard    nofile      32768
   www-data     soft    nofile      32768
   EOF

Nginx serves as a reverse proxy and makes quite a lot of connections. Each WAPT client
keeps a websocket connection up all the time in order to respond to actions from the WAPT Server.
Linux kernel has a protection against having too many TCP connections opened at the same time
and one may get `SYN flooding on port` message in the log. In order to avoid those message
it is necessary to modify the two following parameters. It must around 1.5 time the number
of WAPT client.

.. code-block:: bash

   cat > /etc/sysctl.d/wapt.conf <<EOF 
   net.ipv4.tcp_max_syn_backlog=4096
   net.core.somaxconn=4096
   EOF

   sysctl --system

Configuring PostgreSQL Database
+++++++++++++++++++++++++++++++

The higher number of client need a higher number of connections to the PostgreSQL 
database. In the :file:`postgresql.conf` file (
file:`/etc/postgresql/11/main/postgresql.conf` on debian 10 for example), you need to 
increase the following parameter at approximatly 1/4 the number of clients. 

.. code-block:: bash

   max_connections = 1000

Configuring the WAPTServer
++++++++++++++++++++++++++

Then modify the two following parameter in the :file:`/opt/wapt/conf/waptserver.ini` file.
`db_max_connections` should be equal to postgresql max_connections minus 10 (PostgreSQL needs
some connections for its housekeeping stuff). 

The `max_clients` parameters should be set around 1.2 times the number of clients.

.. code-block:: bash

   [options]
   ...
   max_clients = 4096
   db_max_connections =  990

Configuration for large package upload
--------------------------------------

Depending on the partitioning of your server you might have to be careful with the 
Nginx temporary file upload directory. Nginx acts as a reverse proxy for the WAPTServer
Python engine and its does a caching of packages upload when uploading a new package
from the console. 

The packages are store in the :file:`/var/lib/nginx/proxy` directory. You have to 
make sure that the parition hosting this directory is large enough.
You may change this directory location using the following Nginx configuration parameter.

.. code-block:: bash

   $client_body_temp_path
