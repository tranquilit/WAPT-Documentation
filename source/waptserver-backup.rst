.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
    :description: Backing up the WAPT Server
    :keywords: backup, restore, server, WAPT, PostgreSQL, pg_dumpall,
               FastCopy, WinSCP, documentation

Backing up the WAPT Server
==========================

Backing up the WAPT Server on Linux
-----------------------------------

.. attention::

  This procedure is valid for WAPT 1.5 and above.

* stop WAPT related services on the server;

.. code-block:: bash

  systemctl stop nginx
  systemctl stop waptserver
  systemctl stop wapttasks

* backup these directories using a backup tool (ex: :program:`rsync`,
  :program:`WInSCP`, etc..);

.. code-block:: bash

  /var/www/wapt/
  /var/www/wapt-host/
  /var/www/waptwua/
  /opt/wapt/conf/
  /opt/wapt/waptserver/ssl/

* backup the PostgreSQL database using the :program:`pg_dumpall` utility
  (adapt filename with your requirements);

.. code-block:: bash

  sudo -u postgres pg_dumpall > /tmp/backup_wapt_$(date +%Y%m%d).sql

* restart WAPT related services on the server;

.. code-block:: bash

  systemctl start wapttasks
  systemctl start waptserver
  systemctl start nginx

Restoring the WAPT Server on Linux
----------------------------------

In case of a complete crash, restart a standard WAPT Server installation
on a Linux server.

* stop WAPT related services on the server;

.. code-block:: bash

  systemctl stop nginx
  systemctl stop waptserver
  systemctl stop wapttasks

* restore the following directories:

.. code-block:: bash

  /var/www/wapt/
  /var/www/wapt-host/
  /var/www/waptwua/
  /opt/wapt/conf/
  /opt/wapt/waptserver/ssl/

* restore the database (adapt the name of your file).
  The first command **deletes** the WAPT database (if it exists).
  Make sure that your dump file is correct before deleting!

.. code-block:: bash

  sudo -u postgres psql -c "drop database wapt"
  sudo -u postgres psql < /tmp/backup_wapt_20180301.sql

* apply ownership rights to the restored folders:

.. code-block:: bash

  chown -R wapt:www-data /var/www/wapt/
  chown -R wapt:www-data /var/www/wapt-host/
  chown -R wapt:www-data /var/www/waptwua/
  chown -R wapt /opt/wapt/conf/
  chown -R wapt /opt/wapt/waptserver/ssl/

* scan package repositories;

.. code-block:: bash

  wapt-scanpackages /var/www/wapt/

* restart WAPT related services on the server;

.. code-block:: bash

  systemctl start wapttasks
  systemctl start waptserver
  systemctl start nginx

Backing up the WAPT Server on Windows
-------------------------------------


* backup the WAPT repository folder :file:`C:\\wapt\\waptserver\\repository` and :file:`C:\wapt` and :file:`C:\wapt\waptserver\nginx\ssl`
  on a remote backup destination;

Backup PostgreSQL Database with pg_dump.exe :

.. code-block:: bash

  "C:\wapt\waptserver\pgsql-9.6\bin\pg_dumpall.exe" -U postgres -f C:\backup_wapt.sql

* restart WAPT related services on the server;


  
Restoring the WAPT Server on Windows
------------------------------------

* restore the following directories :file:`C:\\wapt\\waptserver\\repository` and :file:`C:\wapt` and :file:`C:\wapt\waptserver\nginx\ssl`

* Apply the total right to the folder :file:`C:\\wapt\\waptserver\\repository` for the "Network Service" group

Restore PostgreSQL Database with pg_restore.exe :

.. code-block:: bash

  "C:\wapt\waptserver\pgsql-9.6\bin\psql.exe" -f c:\backup_wapt.sql -U postgres

