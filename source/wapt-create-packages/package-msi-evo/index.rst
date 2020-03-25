.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Packaging advanced \*.msi package
  :keywords: msi, WAPT, advanced, complex, installation, installing,
             documentation

.. _complex_msi_packaging:

Advanced \*.msi package
=======================

Improving your MSI based package
--------------------------------

The installation/ updating of the :program:`TightVNC` package chosen
as an example in the previous part of the documentation requires to close
all instances of :program:`TightVNC` for the software to upgrade.

Manual method: killalltasks
+++++++++++++++++++++++++++

A simple method is to kill all existing processes of :program:`TightVNC`
before launching the installation of the *tis-tightvnc* package.

.. code-block:: python

  # -*- coding: utf-8 -*-
  from setuphelpers import *

  uninstallkey = ["{8B9896FC-B4F2-44CD-8B6E-78A0B1851B59}"]

  def install():
      print('installing tis-tightvnc')
      killalltasks("vncviewer.exe")
      run(r'"tightvnc-2.8.5-gpl-setup-64bit.msi" /q /norestart')

Elegant method: install_msi_if_needed
+++++++++++++++++++++++++++++++++++++

.. code-block:: python

  # -*- coding: utf-8 -*-
  from setuphelpers import *

  uninstallkey = []

  def install():
      print('installing tis-tightvnc')
      install_msi_if_needed('tightvnc-2.8.5-setup-64bit.msi')

* the Setuphelpers library provides a function called
  :command:`install_msi_if_needed` that addresses all the described problems
  in only one line of code;

* the function will also test whether a version of the software
  is already installed on the machine using the *uninstall key*;

* if the *uninstall key* is already present, the new version of the software
  will be installed only if the installed version is older;

* after the installation, the function will finally test that the *uninstall key*
  is present and its version, to ascertain that all went well;

.. table:: List of arguments available with *install_exe_if_needed*
  :widths: 30, 20, 50
  :align: center

  ========================= ========= ==========================================
  Settings                  Default     Description
                            value
  ========================= ========= ==========================================
  ``msi``                             name of the MSI file to execute.
  ``min_version``           None      minimal version above which the software
                                      will update.
  ``killbefore``            []        list of programs to kill before installing
                                      the package.
  ``accept_returncodes``    [0,3010]  accepted codes other than 0 and 3010
                                      returned by the function.
  ``timeout``               300       maximum installation wait time
                                      (in seconds).
  ``properties``            {}        additional properties to pass as arguments
                                      to MSI setup file.
  ``get_version``           None      value passed as parameter to control
                                      the version number instead of the value
                                      returned by the *installed_softwares*
                                      function
  ``remove_old_version``    False     automatically removes an older version
                                      of a software whose *uninstall key*
                                      is identical
  ``force``                 False     forces the installation of the software
                                      even though the same *uninstall key*
                                      has been found
  ========================= ========= ==========================================

.. note::

  The :command:`install_msi_if_needed` method searches for an *uninstall key*
  in the MSI file properties, it is not necessary to fill it manually
  in the :file:`setup.py` file.

Launch the installation and watch for what's happening in the WAPT console
when the software is already installed.

.. code-block:: bash

  wapt-get -ldebug install C:\waptdev\tis-tightvnc-wapt
  Installing WAPT file C:\waptdev\tis-tightvnc-wapt
  installing tis-tightvnc
  installing x64 version
  MSI tightvnc-2.8.5-gpl-setup-64bit.msi already installed. Skipping msiexec

  Results:

  === install packages ===
  C:\waptdev\tis-tightvnc-wapt   | tis-tightvnc (2.8.5.0-1)

Handling x32 and x64 architectures
++++++++++++++++++++++++++++++++++

To handle different processor architectures,
use the function :command:`iswin64()`.

.. code-block:: python

  # -*- coding: utf-8 -*-
  from setuphelpers import *

  uninstallkey = []

  def install():
      print(u'Installation en cours de TightVNC')
      if iswin64():
          print('installation version 64 bits')
          install_msi_if_needed('tightvnc-2.8.5-setup-64bit.msi')
      else:
          print('installation version 32 bits')
          install_msi_if_needed('tightvnc-2.8.5-setup-32bit.msi')
      print(u'Installation terminée.')

Passing additional arguments
++++++++++++++++++++++++++++

To pass additional arguments, store them in a *dict*.

.. code-block:: python

  # -*- coding: utf-8 -*-
  from setuphelpers import *

  uninstallkey = []

  properties = {
      'SERVER_REGISTER_AS_SERVICE':0,
      'SERVER_ADD_FIREWALL_EXCEPTION':0,
      }

  def install():
    print(u'Installation en cours de TightVNC')
    if iswin64():
      print('installation version 64 bits')
      install_msi_if_needed('tightvnc-2.8.5-setup-64bit.msi', properties =
                                                              properties)
    else:
      print('installation version 32 bits')
      install_msi_if_needed('tightvnc-2.8.5-setup-32bit.msi', properties =
                                                              properties)
    print(u'Installation terminée.')
