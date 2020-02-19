.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
   :description: Upgrading the Operating System
   :keywords: WAPT, upgrade, upgrading, documentation, os, operating system

.. raw:: html

    <style> .red {color:red} </style>
    <style> .green {color:green} </style>

.. role:: red

.. role:: green

.. _upgrade-waptserver-os:


Upgrading the Operating System
==============================

Upgrading Debian Linux
------------------------------

In order to upgrade your WAPT server from Stretch to Buster you have to follow the 
standard procedure for Debian. You first modify the apt source files :file:`/etc/apt/sources.list`
and :file:`/etc/apt/sources.list.d/wapt.list`, then start upgrade. 

By default the PostgreSQL is not upgraded to PostgreSQL 11. One needs to manually ask
for upgrade. After upgrade it is possible to remove old PostgreSQL 9 database.

.. code-block:: bash

  sed -i 's/stretch/buster/g'  /etc/apt/sources.list
  sed -i 's/stretch/buster/g'  /etc/apt/sources.list.d/wapt.list
  apt-get update
  apt-get update && apt-get dist-upgrade
  pg_upgradecluster
  apt-get remove 
  apt-get autoremove
  /opt/wapt/waptserver/scripts/postconf.sh

 
Upgrading CentOS
------------------------------

:todo: