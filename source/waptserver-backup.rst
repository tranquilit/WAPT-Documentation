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

  sudo -u postgres pg_dumpall   > /tmp/backup_wapt_$(date +%Y%m%d).sql

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

.. attention::

  Obsolete in WAPT 1.5

* stop WAPT related services on the server;

.. code-block:: bash

  net stop WAPTService
  net stop WAPTServer
  net stop WAPTApache

* backup the WAPT root folder :file:`C:\\Program Files (x86)\\wapt`
  on a remote backup destination;

    **Exemple**: backup on an external hard disk drive :file:`W:`

    We use :program:`FastCopy` software, available
    in the Tranquil IT WAPT store:

    - We advise you to use :program:`FastCopy` software, available
      on `Tranquil IT repository <https://store.wapt.fr/>`_:

    .. code-block:: bash

      FastCopy.exe /cmd=diff /error_stop=TRUE /force_close /acl=TRUE /verify=TRUE "C:\\Program Files (x86)\\wapt\\" /to="W:\\wapt"

    Using the GUI interface of :program:`FastCopy`, make sure to check
    the :guilabel:`ACL` checkbox.

* restart WAPT related services on the server;

.. code-block:: bash

  net start WAPTMongodb
  net start WAPTServer
  net start WAPTApache
  net start WAPTService

Restoring the WAPT Server on Windows
------------------------------------

* stop WAPT related services on the server;

.. code-block:: bash

  net stop WAPTService
  net stop WAPTServer
  net stop WAPTApache
  net stop WAPTMongodb

* restore the following directories:

.. code-block:: bash

  FastCopy.exe /cmd=diff /error_stop=TRUE /force_close /acl=TRUE /verify=TRUE "W:\\wapt" /to="C:\\Program Files (x86)\\wapt\\"

* restart WAPT related services on the server;

.. code-block:: bash

    net start WAPTMongodb
    net start WAPTServer
    net start WAPTApache
    net start WAPTService

* restore the following directories:

.. code-block:: bash

  FastCopy.exe /cmd=diff /error_stop=TRUE /force_close /acl=TRUE /verify=TRUE "W:\wapt" /to="C:\\Program Files\\wapt\\"
