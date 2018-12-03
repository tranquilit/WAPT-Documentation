.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Upgrading from WAPT 1.3 to 1.6
  :keywords: documentation, WAPT, 1.3, 1.6, migration, upgrade,upgrading, 1.3.13

.. _upgrade_1.3_1.6:

Upgrading from WAPT 1.3 to 1.6
------------------------------

Two methods are available:

* the :ref:`minimal upgrade <minimal_upgrade>` consists of just migrating
  the WAPT packages without the inventory. It is the simpler method;

* the :ref:`full upgrade <full_upgrade>` consists of migrating all data from
  the old WAPT Server;

.. attention::

  Whether option 1 or 2 is chosen, there are two prerequisites:

  * For the upgrade to work well, your Organization's WAPT **agents must all
    be in version 1.3.13 before upgrading** to 1.6. If not, the *waptupgrade*
    package will not work correctly. Otherwise, you may upgrade using GPOs;

  * **all** your machines to be upgraded must have the *waptupgrade*
    package installed;

.. hint::

  Tranquil IT offers fixed price contracts to help you upgrade from 1.3 to 1.6;
  you may contact us by calling +33(0)240 975 755.

.. _minimal_upgrade:

Minimal upgrade
+++++++++++++++

.. note::

  This procedure also allows you to easily migrate your WAPT Server
  from Windows to Linux and vice versa.

This procedure is the simplest.

The minimal upgrade consists of migrating only WAPT base and group packages.
Neither the inventory nor the host-packages will be kept.

* all informations stored in the WAPT database come from the WAPT agents,
  so no information will be lost;

* the inventory database will rebuild itself when the WAPT agent 1.6 equipped
  computers will re-register with the WAPT Server;

.. toctree::
  :maxdepth: 2

  migration-minima.rst

.. attention::

  * you will have to re-affect the packages to the hosts (no stress, it will
    not remove the software that are already installed);

      * you will just lose temporarily the list of your computers
        in the WAPT console;

      * this procedure does not allow to upgrade with the :program:`waptupgrade`
        package;

.. _full_upgrade:

Complete upgrade
++++++++++++++++

This procedure upgrades completely your Organization's WAPT setup from 1.3
to 1.6 because it will migrate the database and WAPT base, group and
host packages.

.. toctree::
  :maxdepth: 1

  migration-old-new-server.rst
  migration-1.6-debian.rst
  migration-1.6-centos.rst
  migration-1.6-windows.rst

Upgrading the WAPT console and the WAPT agents
++++++++++++++++++++++++++++++++++++++++++++++

.. toctree::
  :maxdepth: 1

  suite-upgrade.rst
