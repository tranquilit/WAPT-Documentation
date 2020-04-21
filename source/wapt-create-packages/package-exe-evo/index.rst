.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Packaging advanced .exe packages
  :keywords: exe, WAPT, advanced, complex, installing, installation,
             documentation

.. _complex_exe_packaging:

Packaging advanced .exe packages
================================

Improving the functionalities of packages
-----------------------------------------

Our package Mozilla Firefox ESR is functional but it requires some improvements.

* the package installs the software even if the software is already installed,
  it will overwrite older versions;

* the package does not check whether the software version is already installed;

* the package does not check whether the software version is already installed;

As with MSI installers, those problems are addressed using
the function :command:`install_exe_if_needed`.

Using *install_exe_if_needed*
+++++++++++++++++++++++++++++

The function is slightly the same as that used with MSI installers,
with some differences:

* the function requires to pass the silent flag as an argument;

* the function requires to pass the *uninstall key* as an argument;

We make changes to the Mozilla Firefox ESR setup accordingly.

.. code-block:: python
  :emphasize-lines: 4

  # -*- coding: utf-8 -*-
  from setuphelpers import *

  uninstallkey = []

  def install():
      print('installing tis-firefox-esr')
      install_exe_if_needed("Firefox Setup 45.5.0esr.exe",
                            silentflags="-ms",
                            key='Mozilla Firefox 45.4.0 ESR (x64 fr)'
                            min_version="45.5.0"
                            killbefore="firefox.exe")

.. table:: List of arguments available with *install_exe_if_needed*
  :widths: 30, 20, 50
  :align: center

  ======================= ========= ================================================
  Settings                Default   Description
                          value
  ======================= ========= ================================================
  ``exe``                  ..       name of the :mimetype:`.exe` file to execute.
  ``silentflags``          ..       silent parameters to pass as arguments
                                    to the installer.
  ``key``                  None     software *uninstall key*.
  ``min_version``          None     minimal version above which the software
                                    will update.
  ``killbefore``           [ ]      list of programs to kill before
                                    installing the package.
  ``accept_returncodes``   [0,3010] accepted codes other than 0 and 3010 returned
                                    by the function.
  ``timeout``              300      maximum installation wait time (in seconds).
  ``get_version``          None     value passed as parameter to control the version
                                    number instead of the value returned by the
                                    :command:`installed_softwares` function.
  ``remove_old_version``   False    automatically removes an older version of
                                    a software whose uninstallkey is identical
  ``force``                False    forces the installation of the software even
                                    though the same uninstallkey has been found
  ======================= ========= ================================================

As a consequence, the package will have a different behavior:

* Firefox will install only if it is not yet installed or
  if the installed version of Firefox is less than 45.5.0,
  unless the ``--force`` option is passed as argument
  when installing the package;

* on installing, the running :program:`firefox.exe` processes will be killed;

* the function will add by itself the *uninstall key*,
  so leave the *uninstall key* argument empty;

* when finishing the installation of the package, the function will check
  that the *uninstall key* is present on the machine and that the version
  of Firefox is greater than 45.5.0; if this not the case, the package
  will be flagged as **ERROR**;

Managing the de-installation of applications
--------------------------------------------

Special case of a non-silent uninstaller
++++++++++++++++++++++++++++++++++++++++

In that particular case, a package using :command:`install_exe_if_needed`
fills in the *uninstall key*, but the *uninstall key* points
to a non silent uninstaller.

We have to circumvent that problem by using a function that will remove
the *uninstall key* at the end of the installation.

.. code-block:: python

  :emphasize-lines: 13

  # -*- coding: utf-8 -*-
  from setuphelpers import *

  uninstallkey = []

  def install():
      print('installing tis-firefox-esr')
      install_exe_if_needed("Firefox Setup 45.5.0esr.exe",
                            silentflags="-ms",
                            key='Mozilla Firefox 45.4.0 ESR (x64 fr)',
                            min_version="45.5.0",
                            killbefore="firefox.exe")
      uninstallkey.remove('Mozilla Firefox 45.4.0 ESR (x64 fr)')

  def uninstall():
      print('uninstalling tis-firefox-esr')
      run(r'"C:\Program Files\Mozilla Firefox\uninstall\helper.exe" -ms')
