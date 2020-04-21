.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Using organizational unit packages in WAPT
  :keywords: WAPT, console, organizational, unit, OU, UO, Active Directory

.. _wapt_reporting:

.. versionadded:: 1.7 Enterprise

Using organizational unit packages in WAPT
===========================================

.. hint::

  Feature only available with WAPT **Enterprise**.


Working principle
-----------------

WAPT Enterprise offers organizational unit packages functionnality.

It automates software installations based on your Active Directory infrastructure.

WAPT agent is aware of its Active Directory sorting, thereby knows the hierarchy of
organizational units, for example:

.. code-block:: bash

  DC=ad,DC=domain,DC=lan
  OU=Paris,DC=ad,DC=domain,DC=lan
  OU=computers,OU=Paris,DC=ad,DC=domain,DC=lan
  OU=service1,OU=computers,OU=Paris,DC=ad,DC=domain,DC=lan

If an organizational unit package is defined on each level, WAPT agent
will download them automatically by inheritance and apply each level
and their dependencies.

Filters and actions available with Organizational Units
-------------------------------------------------------

.. figure:: wapt_console-access-to-organisational-unit-menu.png
  :align: center
  :alt: WAPT console showing options applicable to OU

  WAPT console showing options applicable to OU

.. hint::

  You can see in the picture that **update** and **upgrade** actions can be performed
  through this menu, thus selecting hosts by their organizational unit.

In the **Enterprise** version, you may filter how hosts are displayed based
on the Active Directory :abbr:`OU (Organizational Units)` they belong to.

The checkbox :guilabel:`Include hosts in subfolders` allows to display hosts
in subfolders.

Creating organizational unit packages in WAPT console
-----------------------------------------------------

You can create *unit* packages by :menuselection:`Right clicking
on an OU --> Create or edit the unit package`.

.. figure:: wapt_console-unit-create-package-1.png
  :align: center
  :alt: Right-click on OU to create unit package

  Right-click on OU to create unit package.

A window opens and you are prompted to choose which packages
must be in **unit** bundle.

.. figure:: wapt_console-unit-create-package-2.png
  :align: center
  :alt: Adding packages to unit bundle

  Adding package to unit bundle.

Save the package and it will be uploaded to the WAPT server.


Faking organizational unit for WORKGROUP hosts
-----------------------------------------------------

It can happend that some specific hosts cannot be joined to Active Directory.

With that specificity, they doesn't show up in your Active Directory organizational units in WAPT Console.

To circumvent that, WAPT allow you to specify a fake organizational unit in WAPT agent configuration.

The benefits of it are :

* Better management of these specific hosts
* Out-of-Domain / Workgroup hosts now showing up in AD tree view
* Organizational Units Packages are usable on those hosts

To setup a fake organisational unit on hosts, create an empty WAPT package

.. code-block:: bash

  wapt-get make-template demo-configure-fake-ou


Then use the following code :

.. code-block:: python

  # -*- coding: utf-8 -*-
  from setuphelpers import *

  uninstallkey = []

  def install():

    print('Setting Fake Organizational Unit')
    fake_ou = "OU=TOTO,OU=TEST,DC=DEMO,DC=LAN"
    inifile_writestring(WAPT.config_filename,'global','host_organizational_unit_dn',fake_ou)

The ``host_organizational_unit_dn`` must be like so in ``wapt-get.ini`` :

.. code-block:: ini

  [global]
  host_organizational_unit_dn="OU=TOTO,OU=TEST,DC=DEMO,DC=LAN"
