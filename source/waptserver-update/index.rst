.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
   :description: Upgrading the WAPT Server
   :keywords: WAPT, upgrade, upgrading, documentation

.. _upgrade-wapt:

Upgrading the WAPT Server
=========================

.. hint::

   If your WAPT Server is a virtual machine, take a snapshot of the VM.
   This way, you'll be able to go back easily in the rare case that
   the update fails.

Upgrading from 1.6 to 1.7
-------------------------

The upgrade process follows the process for a minor update.


Upgrading from 1.5 to 1.6
-------------------------

The upgrade process follows the process for a minor update.

If you are in Debian Jessie, it is recommended to upgrade to Debian Strech
64 bits.
This is mandatory for the **Enterprise** version with Windows Update support.
When upgrading to Debian9, the PostgreSQL database must be upgraded
from version 9.6.

Upgrading from 1.3 to 1.6
-------------------------

The upgrade from 1.3 to 1.6 is a major upgrade.

.. toctree::
  :maxdepth: 1

  changes-1.3-1.5.rst
  migration13-16/index.rst

Minor Upgrades
--------------

This procedures concerns the classic method for upgrading the WAPT Server
for minor versions, for exemple from 1.6.0 to 1.6.1.

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
