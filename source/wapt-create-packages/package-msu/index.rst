.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
    :description: Packaging Windows Update \*.msu packages
    :keywords: msu, WAPT, simple, documentation

.. _simple_msu_packaging:

Packaging Windows Update \*.msu packages  
=========================================

.. hint:: Prerequisites

    Pre-requisites: to build WAPT packages, :ref:`the WAPT development
    environment must be installed <envdev_setup>`;

Between Patch Tuesday releases, Microsoft may release additional KBs 
or critical ones that needs to be pushed to hosts quickly.

For that purpose, WAPT provides a package template for \*.msu files.

In that example, we use the KB4522355 downloaded
from Microsoft Catalog website.

* download the KB package from Microsoft Catalog website :

  * `download KB4522355 MSU <https://www.catalog.update.microsoft.com/Search.aspx?q=KB4522355>`_;


Creating a MSU package template from the WAPT console
-----------------------------------------------------

* create a WAPT package Template from the downloaded MSU file;

  In the WAPT console, click on :menuselection:`Tools -->
  Make package template from setup file`

  .. figure:: tools_make_package_template.png
    :align: center
    :alt: Pyscripter - WAPT console window for creating a package template

    Pyscripter - WAPT console window for creating a package template


* select the downloaded MSU package and fill in the required fields.

  .. figure:: package_wizard_msu.png
    :align: center
    :alt: Informations required for creating the package

    Informations required for creating the MSU package


* click on :guilabel:`Make and edit ....` (recommended) to launch package customization;

* WAPT package IDE is launched using source code from pre-defined MSU template.

* As usual with WAPT packages, test - build - upload and it's done.

Creating a MSU package template from command line
-------------------------------------------------

* launch a Windows Command Line utility :program:`cmd.exe`
  as :term:`Local Administrator`;

  .. figure:: ./../package-exe/in-admin.png
    :align: center
    :alt: Windows Command Line utility launched as Local Administrator

    Windows Command Line utility launched as Local Administrator

* instantiate a package from the pre-defined MSU template;

  .. code-block:: bash

    wapt-get make-template c:\download\file.msu <yourprefix>-kb4522355
  

* output example with :program:`KB4522355`:

  .. code-block:: bash

    C:\WINDOWS\system32>wapt-get make-template C:\windows10.0-kb4522355-x64_af588d16a8fbb572b70c3b3bb34edee42d6a460b.msu tis-kb4522355
    Using config file: C:\Users\user-adm\AppData\Local\waptconsole\waptconsole.ini

    Template created. You can build the WAPT package by launching
      C:\Program Files (x86)\wapt\wapt-get.exe build-package c:\waptdev\tis-kb4522355-wapt

    You can build and upload the WAPT package by launching
      C:\Program Files (x86)\wapt\wapt-get.exe build-upload c:\waptdev\tis-kb4522355-wapt


* WAPT package IDE is launched, here is an example source code from pre-defined MSU template

  .. code-block:: python
    
    # -*- coding: utf-8 -*-
    from setuphelpers import *
    import re

    uninstallkey = []

    def is_kb_installed(hotfixid):
        installed_update = installed_windows_updates()
        if [kb for kb in installed_update if kb['HotFixID' ].upper() == hotfixid.upper()]:
            return True
        return False

    def waiting_for_reboot():
        # Query WUAU from the registry
        if reg_key_exists(HKEY_LOCAL_MACHINE,r"SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired") or \
            reg_key_exists(HKEY_LOCAL_MACHINE,r"SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending") or \
            reg_key_exists(HKEY_LOCAL_MACHINE,r'SOFTWARE\Microsoft\Updates\UpdateExeVolatile'):
            return True
        return False

    def install():
        kb_files = [
            'windows10.0-kb4522355-x64_af588d16a8fbb572b70c3b3bb34edee42d6a460b.msu',
            ]
        with EnsureWUAUServRunning():
          for kb_file in kb_files:
              kb_guess = re.findall(r'^.*-(KB.*)-',kb_file)
              if not kb_guess or not is_kb_installed(kb_guess[0]):
                  print('Installing {}'.format(kb_file))
                  run('wusa.exe "{}" /quiet /norestart'.format(kb_file),accept_returncodes=[0,3010,2359302,-2145124329],timeout=3600)
              else:
                  print('{} already installed'.format(kb_file))

          if waiting_for_reboot():
              print('A reboot is needed !')




   