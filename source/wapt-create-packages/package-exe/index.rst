.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
    :description: Packaging simple .exe package
    :keywords: exe, WAPT, simple, documentation

.. _simple_exe_packaging:

Packaging simple .exe package
=============================

.. note:: Variation compared to MSI

  WAPT prefers MSI installers because most :mimetype:`.exe` are not standardized
  and silent arguments can be different from one piece of software to another.

.. hint::

  Since WAPT version 1.3.12, a new method for quickly building WAPT packages
  from the WAPT console has been made available.

  This part of the documentation is still actual, we recommend however
  that you use the WAPT console to instantiate your package templates,
  see :ref:`creation_paquets_console`.

* download the exe installer from a reliable source;

  Download the installer in exe format (for example: `Firefox ESR x64 <https://download.mozilla.org/?product=firefox-45.6.0esr-SSL&os=win64&langerr>`_):

* look up documentation relating to silent flags;

  * On the `Official Mozilla website <https://wiki.mozilla.org/Installer:Command_Line_Arguments>`_;

  * other methods for finding information on silent flags:

    * `WPKG packages repository <https://wpkg.org/Firefox#Firefox_19_-_45_.28For_current_versions_of_WPKG.29>`_;

    * `Chocolatey packages repository <https://chocolatey.org/packages/FirefoxESR>`_;

    * search on the Internet with the search terms: *Firefox silent install*;

Creating a base template from the .exe file
-------------------------------------------

* start up a Windows Command Line utility :program:`cmd.exe`
  as :term:`Local Administrator`;

.. figure:: in-admin.png
  :align: center
  :alt: Launching the Windows Command Line utility as Local Administrator

  Launching the Windows Command Line utility as Local Administrator

* create a WAPT package template;

  .. code-block:: bash

    wapt-get make-template <chemin_exe> <nom_du_paquet>

  Example with Mozilla Firefox ESR:

  .. code-block:: bash

    wapt-get make-template "Firefox Setup 52.6.0esr.exe" "tis-firefox-esr"

    Template created. You can build the WAPT package by launching
      C:\Program Files (x86)\wapt\wapt-get.exe build-package C:\waptdev\tis-firefox-esr-wapt
    You can build and upload the WAPT package by launching
      C:\Program Files (x86)\wapt\wapt-get.exe build-upload C:\waptdev\tis-firefox-esr-wapt

  PyScripter loads up and opens open the :mimetype:`.exe` package project.

  .. figure:: pyscripter_firefox_esr.png
    :align: center
    :alt: PyScripter opening with focus on the *control* file

    PyScripter opening with focus on the *control* file

* check the :file:`control` file content;

  Mozilla Firefox-ESR does not comply to industry standards and returns
  an erroneous version number (it appears to be the installer packaging
  software version number).

  Original *control* file

  .. literalinclude:: control_origin.txt
    :emphasize-lines: 2

  Modified *control* file

  .. literalinclude:: control_modified.txt
    :emphasize-lines: 2,6,7

  .. note::

    It is to be noted that a sub-version *-1* has been added.
    It is the packaging version of WAPT package.

    It allows the Package Developer to release several WAPT package versions
    of the same software.

* check the :file:`setup.py` file;

  WAPT has added a generic silent */VERYSILENT* flag that may or may not
  work with Mozilla Firefox ESR.

  In that case, we will replace the suggested silent flag with the one
  that we found in the Mozilla documentation.

* make changes to the code in the :file:`setup.py` file accordingly;

  .. code-block:: python

    :emphasize-lines: 8
    # -*- coding: utf-8 -*-
    from setuphelpers import *

    uninstallkey = []

    def install():
        print('installing tis-firefox-esr')
        run(r'"Firefox Setup 52.6.0esr.exe" -ms')

* save the package;

Managing the uninstallation
---------------------------

With an exe installer, the *uninstall key* is not available until the software
has been installed once.

The *uninstall key* is available in the Windows registry:

.. code-block:: bash

  HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall

* open a Windows Command Line :program:`cmd.exe` prompt;

* retrieve the software *uninstall key* with
  :code:`wapt-get list-registry firefox`

.. code-block:: bash

  UninstallKey                          Software                               Version            Uninstallstring
  ------------------------------------- -------------------------------------- ------------------ ------------------------------------------------------
  Mozilla Firefox 52.6.0 ESR (x64 fr)   Mozilla Firefox 52.6.0 ESR (x64 fr)    52.6.0             "C:\Program Files\Mozilla Firefox\uninstall\helper.exe"

* copy the *uninstall key* **UninstallKey**: *Mozilla Firefox
  45.4.0 ESR (x64 en)*;

* make changes to the :file:`setup.py` file with the correct *uninstall key*;

.. code-block:: python

  :emphasize-lines: 4

  # -*- coding: utf-8 -*-
  from setuphelpers import *

  uninstallkey = ['Mozilla Firefox 52.6.0 ESR (x64 fr)']

  def install():
      print('installing tis-firefox-esr')
      run(r'"Firefox Setup 52.6.0esr.exe" -ms')

.. note::

  The *UninstallKey* must be the exact same as the one listed with
  :command:`list-registry` command. The *UninstallKey* may be a GUID such as
  *95160000-0052-040C-0000-0000000FF1CE*, a GUID with bracketed characters,
  *{95160000-0052-040C-0000-0000000FF1CE}*, or simply a character string
  such as *Git_is1* or *Mozilla Firefox 52.6.0 ESR (x64 fr)*.

* relaunch the package setup to set the correct *uninstall key*
  in the local WAPT database;

* test uninstalling the package;

* launch a :guilabel:`remove` from PyScripter :guilabel:`Run Configurations`;

  .. image:: remove_package.png
    :align: center
    :alt: After uninstallation, the software is correctly removed

  After uninstallation, the software is correctly removed

  We can notice the correct uninstallation by launching again
  the :command:`wapt-get list-registry` command.

  .. code-block:: bash

    UninstallKey          Software          Version            Uninstallstring
    --------------------- ----------------- ------------------ ---------------
    --------------------- ----------------- ------------------ ---------------

Specific case of a non-silent uninstaller
+++++++++++++++++++++++++++++++++++++++++

It sometimes occurs that the software installs silently,
but does not uninstall silently.

In that precise case it is necessary to override the :command:`uninstall()`
function.

Example with Mozilla Firefox:

.. code-block:: python
  :emphasize-lines: 10-12

  # -*- coding: utf-8 -*-
  from setuphelpers import *

  uninstallkey = ['Mozilla Firefox 52.6.0 ESR (x64 fr)']

  def install():
      print('installing tis-firefox-esr')
      run(r'"Firefox Setup 52.6.0esr.exe" -ms')

  def uninstall():
      print('uninstalling tis-firefox-esr')
      run(r'"C:\Program Files\Mozilla Firefox\uninstall\helper.exe" -ms')

.. hint::

  In the :command:`uninstall()` function, it is not possible to call for files
  included inside the WAPT package. To call files from the package,
  it is necessary to copy/ paste the files in a temporary directory
  during package installation.

Build and upload the package
----------------------------

Once the installation and the de-installation are configured and tested
and the package is customized to your satisfaction, you may build and upload
your new WAPT package onto your WAPT repository.
