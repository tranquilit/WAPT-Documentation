.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Upgrading the WAPT Server in version 1.3 to a more
                recent x64 Linux distribution
  :keywords: upgrade, WAPT, 1.3.13, x64, Linux, Debian, CentOS, RedHat,
             documentation

.. _upgrade_host_server:

Upgrading the WAPT Server in version 1.3 to a more recent x64 Linux distribution
================================================================================

Under Linux, you may save your MongoDB inventory with the command
:code:`mongodump --db wapt --archive=/root/wapt.dump`.

.. code-block:: bash

  mongodump

.. hint::

  if the :command:`mongodump` command is not available, you may install
  the utility with :code:`apt-get install mongo-tools`.

Launching :command:`mongodump` creates a :file:`dump` file, save it.

You must also save your WAPT base and host packages. They are stored in
:file:`/var/www/wapt/` and :file:`/var/www/wapt-host/`.

When you will install your new x64 based WAPT Server, you will have to reinstall
WAPT 1.3.13 before upgrading to 1.6:

https://www.wapt.fr/en/doc-1.3/Installation/waptserver/linux/index.html

You will now restore the WAPT base and host packages previously
saved in :file:`/var/www/wapt/` and :file:`/var/www/wapt-host/` of your new
x64 based WAPT Server.

To restore the MongDB dump file, you may execute the command
:code:`mongorestore /root/dump`.

You may now follow the classic procedure to upgrade from 1.3.13 to 1.6:

* for :ref:`Debian Linux <upgrade_1.3_1.6_debian>`;

* for :ref:`CentOS/ RedHat <upgrade_1.3_1.6_centos>`;
