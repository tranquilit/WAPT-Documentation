.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
    :description: Packaging simple \*.msi packages
    :keywords: msi, WAPT, simple, documentation

.. _simple_msi_packaging:

Packaging simple \*.msi packages
================================

.. hint:: Prerequisites

    Pre-requisites: to build WAPT packages, :ref:`the WAPT development
    environment must be installed <envdev_setup>`;

.. hint::

    From WAPT version 1.3.12 and above, a new package template creation wizard
    is available to help you make basic packages. For more information
    on package creation using package wizard, please refer
    to the :ref:`documentation for creating packages from the WAPT console
    <creation_paquets_console>`.

* Download the TightVNC MSI installer

  * `download TightVNC MSI x64 <http://www.tightvnc.com/download/
    2.8.5/tightvnc-2.8.5-gpl-setup-64bit.msi>`_;

  * `download TightVNC MSI x86 <http://www.tightvnc.com/
    download/2.8.5/tightvnc-2.8.5-gpl-setup-32bit.msi>`_;

* look up documentation relating to silent flags;

  * `documentation TightVNC <http://www.tightvnc.com/doc/win/
    TightVNC_2.7_for_Windows_Installing_from_MSI_Packages.pdf>`_;

  .. code-block:: bash

    msiexec /i tightvnc-2.7.1-setup-64bit.msi /quiet /norestart

  This command should install :program:`TightVNC` with its default parameters.
  However, MSI allows you to customize the behavior of the installed
  software with MSI properties. The global syntax is:

  .. code-block:: bash

    msiexec /i tightvnc-2.7.1-setup-64bit.msi /quiet /norestart PROPERTY1=value1 PROPERTY2=value2 PROPERTY3=value3

* launch a Windows Command Line utility :program:`cmd.exe`
  as :term:`Local Administrator`;

.. figure:: ./../package-exe/in-admin.png
  :align: center
  :alt: Windows Command Line utility launched as Local Administrator

  Windows Command Line utility launched as Local Administrator

* instantiate a package from the pre-defined MSI template;

.. code-block:: bash

  wapt-get make-template c:\download\file.msi <yourprefix>-tightvnc

Exemple with :program:`TightVNC`:

.. code-block:: bash

  wapt-get make-template C:\Users\User\Downloads\tightvnc-2.8.5-gpl-setup-64bit.msi tis-tightvnc

  Template created. You can build the WAPT package by launching
    C:\Program Files (x86)\wapt\wapt-get.exe build-package C:\waptdev\tis-tightvnc-wapt
  You can build and upload the WAPT package by launching
    C:\Program Files (x86)\wapt\wapt-get.exe build-upload C:\waptdev\tis-tightvnc-wapt

.. _customizing_your_packages:

Customizing the package
-----------------------

:program:`PyScripter` opens with the new project, ready to be
customized and built.

.. figure:: PyScripter_00.png
  :align: center
  :alt: PyScripter with TightVNC project opened

  PyScripter with TightVNC project opened

.. note::

  Using the automatic template has the following effects:

  * it creates a WAPT package folder in :file:`C:\\waptdev`;

  * it copies the MSI setup file in that directory;

  * it creates a generic :file:`setup.py` file;

  * it creates the :file:`control` file containing
    the WAPT package meta-informations;

  * it creates the PyScripter project file containing pre-configured WAPT
    related helpers;

.. hint::

  Then it's possible to:

  * check and complete :file:`control` file informations;

  * add additional files (x86 version of the installer,
    configuration files, etc);

  * customize setup instructions in :file:`setup.py`;

  * make changes to the :file:`control` file as necessary (:ref:`envdev_setup`);

.. literalinclude:: control

.. note::

    You may observe that a subversion (*-1*; dash+number one) has been added.
    It is the WAPT packaging version.

    This allows to preserve the software version when iteratively improving
    the WAPT package.

* check the *setup.py* file;

In the :file:`setup.py` file, you will have to check whether the *uninstall key*
automatically that has been filled matches the MSI and that
the silent arguments work correctly.

.. code-block:: python

  # -*- coding: utf-8 -*-
  from setuphelpers import *

  uninstallkey = ["{8B9896FC-B4F2-44CD-8B6E-78A0B1851B59}"]

  def install():
      print('installing tis-tightvnc')
      run(r'"tightvnc-2.8.5-gpl-setup-64bit.msi" /q /norestart')

.. note::

  Since WAPT version 1.3.12, :command:`install_msi_if_needed` is the function
  used by default when creating a package Template from a MSI.

   In this example, we will use the :command:`run` function to show
   the evolution of the package. The function :command:`install_msi_if_needed`
   is explained in :ref:`the documentation related to advanced packaging
   of MSI based WAPT packages <complex_msi_packaging>`.

* test installing the package on you development computer;

A major advantage of :program:`PyScripter` and WAPT is to be able to test WAPT
packages locally, to improve them quickly and iteratively.

.. figure:: PyScripter_01.png
  :align: center
  :alt: Test installing the package from you development computer

  Test installing the package from you development computer

.. tabularcolumns:: |\X{2}{12}|\X{5}{12}|\X{5}{12}|

=========================== ========= ==========================================
Settings                    Value     Description
=========================== ========= ==========================================
:command:`install`          Execute   Launch the software installation with
                                      its arguments from :file:`setup.py`.

:command:`install`          Debug     Launch the line by line debugger.

:command:`remove`           Execute   Launch the uninstallation.

:command:`-i build-upload`  Execute   Increment the WAPT packaging version,
                                      build the package and upload it
                                      on the WAPT repository.
=========================== ========= ==========================================

Build and upload the package
----------------------------

Once the project has been created, build the package without modifications
from the Windows command prompt.

.. code-block:: bash

  wapt-get build-upload -i c:\waptdev\tis-tightvnc-wapt

.. note::

  When executing that command, here is what is really happening:

  * the :file:`manifest.sha256` file containing the list of files included
    in the package is created;

  * it compresses the folder :file:`C:\\waptdev\tis-tightvnc-wapt`
    with a canonical name;

  * it adds the signature (requires the private key);

  * it loads the WAPT package onto the WAPT repository using HTTPS;

  * it recreates the :file:`https://srvwapt.mydomain.lan/wapt/Packages` index
    to take into account the new or updated package;

  The package is now ready to be deployed.

Example:

.. code-block:: bash

  wapt-get -i build-upload C:\waptdev\tis-tightvnc-wapt

  Building  C:\waptdev\tis-tightvnc-wapt
  Package tis-tightvnc (=2.8.5.0-1) content:
    setup.py
    tightvnc-2.8.5-gpl-setup-64bit.msi
    WAPT\control
    WAPT\wapt.psproj
  ...done. Package filename C:\waptdev\tis-tightvnc_2.8.5.0-1_all.wapt
  Signing C:\waptdev\tis-tightvnc_2.8.5.0-1_all.wapt

  7-Zip [64] 16.04 : Copyright (c) 1999-2016 Igor Pavlov : 2016-10-04

  Open archive: C:\waptdev\tis-tightvnc_2.8.5.0-1_all.wapt
  --
  Path = C:\waptdev\tis-tightvnc_2.8.5.0-1_all.wapt
  Type = zip
  Physical Size = 1756458

  Updating archive: C:\waptdev\tis-tightvnc_2.8.5.0-1_all.wapt

  Items to compress: 0

  Files read from disk: 0
  Archive size: 1755509 bytes (1715 KiB)
  Everything is Ok
  Package C:\waptdev\tis-tightvnc_2.8.5.0-1_all.wapt signed : signature :
  FVn2yx77TwUHaDauSPHxJZiPAyMQe4PqLF5n6wY9YPAwY4ijHe6NgDFrexXf8ZYbHAiNa5b8V/Qj
  wTVHiqpbXnZotiVIGrJDhgbaLwZ9CK6pfWiflC4126nx6PMF3T1i6w0R0NOE2wJpOSRYESk7lDUz
  9CPfzJCLcOXwh0F5eZc96wbkDkSbpn1f+x5tOlvyy/FW2m8RbZQhJcO21j9gGX7It0QNecaOxXgz
  qkZZKBDNASOBYAF22M1+zHb59DWQ63Q8yMj5t5szEUTkGtQNG6vZz3gb9Yraq361BIGaBDYUM31j
  ZgpaHvP0vdK3c1x1mhyhC7q6eZ/UCW5tETTCiA==

  Uploading files...
  WAPT Server user :admin
  WAPT Server password :
  Status : OK, tis-tightvnc_2.8.5.0-1_all.wapt uploaded, 1 packages analysed

It is also possible to execute :command:`build-upload` directly
from the :guilabel:`Run Configurations` panel in :program:`PyScripter`:

.. figure:: run-build.png
  :align: center
  :alt: Option "-i build-upload" of PyScripter project

  Option "-i build-upload" of PyScripter project
