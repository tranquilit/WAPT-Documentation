.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
   :description: Upgrading the WAPT Server
   :keywords: WAPT, upgrade, upgrading, documentation

.. raw:: html

    <style> .red {color:red} </style>
    <style> .green {color:green} </style>

.. role:: red

.. role:: green

.. _upgrade-wapt:

Upgrading the WAPT Server
=========================

.. hint::

   If your WAPT Server is a virtual machine, take a snapshot of the VM.
   This way, you'll be able to go back easily in the rare case that
   the update fails.

Before upgrading WAPT Server, please refer to the following upgrading compatibility chart :

================ ================ ================ ================ ================
\                To WAPT 1.5      To WAPT 1.6      To WAPT 1.7      To WAPT 1.8      
================ ================ ================ ================ ================
From WAPT 1.3    :green:`Yes`     :green:`Yes`     :red:`No`        :red:`No`
From WAPT 1.5    -                :green:`Yes`     :green:`Yes`     :red:`No`
From WAPT 1.6    -                -                :green:`Yes`     :red:`No`
From WAPT 1.7    -                -                -                :green:`Yes`
================ ================ ================ ================ ================


Upgrading WAPT from 1.6/1.7 to 1.8
----------------------------------

The upgrade process follows the process for a minor update:

* :ref:`minor update for Debian <wapt_minor_upgrade_debian>`;

* :ref:`minor update for CentOS <wapt_minor_upgrade_centos>`;

* :ref:`minor update for Windows <wapt_minor_upgrade_windows>`;

.. attention::

  * Debian Jessie is now deprecated. **WAPT 1.8 will not work
    with old Debian version**;

  * consider migrating your existing WAPT installation
    to Debian Buster or CentOS7 : :ref:`upgrade-waptserver-os`;

Upgrading WAPT from 1.5 to 1.6
------------------------------

The upgrade process follows the process for a minor update.

.. note::

  * if you are in Debian Stretch, it is recommended to upgrade
    to Debian Buster 64 bits : :ref:`upgrade-waptserver-os`;

  * this is **MANDATORY** for the **Enterprise** version with Windows Update support;

  * when upgrading to Debian10, the PostgreSQL database
    must be upgraded;

Upgrading WAPT from 1.3 to 1.6
------------------------------

The upgrade from 1.3 to 1.6 is a major upgrade.

.. toctree::
  :maxdepth: 1

  changes-1.3-1.5.rst
  migration13-16/index.rst

Minor Upgrades
--------------

This procedures concerns the classic method for upgrading the WAPT Server
for minor versions, for exemple from 1.7.4 to 1.8.

The migration process includes:

* the upgrading of the WAPT Server;

* the upgrading of the WAPT console;

* the upgrading of the WAPT agent;

* the updating of the deployment GPO;

.. note::

  For upgrading from 1.3 to 1.6, please refer to
  :ref:`upgrading from 1.3 to 1.6 <upgrade_1.3_1.6>`.

.. toctree::
   :maxdepth: 2

   waptserver-update-debian.rst
   waptserver-update-centos.rst
   waptserver-update-windows.rst
   waptserver-upgrade-os.rst