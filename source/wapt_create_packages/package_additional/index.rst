.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Additional features
  :keywords: Personalizing, WAPT, user context, portable application,
             portable app, example, session_setup, Setuphelpers,
             restricted user, documentation

Additional features
===================

Customizing the user environment
--------------------------------

One of the main advantages of WAPT is the silent installation and uninstallation
of software, **even when restricted users are connected**.

The WAPT agent runs with Windows SYSTEM rights, it allow to define
global settings in system context and customized settings in restricted
user mode.

User settings customization relies on the ``session_setup`` function defined
in WAPT library :term:`Setuphelpers`.

Working principle
+++++++++++++++++

User mode customization operates as follows:

* the instructions are defined in :command:`session_setup()` function
  of :file:`setup.py` file;

* when the package is deployed on the machine, instructions are stored
  in the local database of the WAPT agent;

* when the user connects to her computer, :command:`session_setup`
  customizations are executed in the limit of one execution per user
  and per WAPT package version;

.. hint::

  ``session_setup`` customization will occur only once per user per package;
  a shortcut created in that context is created only once
  and not at every startup. To execute a task at each startup, it is preferable
  to define a Windows scheduled task to be launched by a local :term:`GPO` or
  by a startup script.

Example: create a personalized desktop shortcut
+++++++++++++++++++++++++++++++++++++++++++++++

One of the possibilities offered by :term:`SetupHelpers` is adding personalized
shortcuts on user desktops, instead of a desktop shortcut common to all users.

For that purpose, we will use the :command:`create_user_desktop_shortcut()`
function to create shortcuts containing the username and passing a website
as an argument to Firefox.

.. code-block:: python
  :emphasize-lines: 14-17

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

  def session_setup():
    create_user_desktop_shortcut("Mozilla Firefox de %s" % get_current_user(),
                                 r'C:\Program Files\Mozilla Firefox\firefox.exe',
                                 arguments="-url https://tranquil.it")

Deploying a portable software with WAPT
---------------------------------------

A good example of a WAPT package is a self-contained/ *portable*
software package:

* create the folder for the software in :file:`C:\Program Files (x86)`;

* copy the software in that folder;

* create the shortcut to the application;

* manage the uninstallation process for the application;

* close the application if it's running;

Example with ADWCleaner
+++++++++++++++++++++++

* create a group package and modify the :file:`control` file
  to transform it to a software package;

.. code-block:: bash

  wapt-get make-group-template tis-adwcleaner

.. code-block:: bash
  :emphasize-lines: 4

  package           : tis-adwcleaner
  version           : 6.041-1
  architecture      : all
  section           : base
  priority          : standard
  maintainer        : Tranquil-IT Systems
  description       : ADW Cleaner

The file :file:`C:\waptdev\tis-adwcleaner-wapt` is created.

* download and copy/ paste :program:`adwcleaner.exe` binary
  in :file:`C:\waptdev\tis-adwcleaner-wapt` directory;

* open and make desired changes to
  :file:`C:\waptdev\tis-adwcleaner-wapt\setup.py` installation file;

.. code-block:: python

  # -*- coding: utf-8 -*-
  from setuphelpers import *

  uninstallkey = []

  targetdir = makepath(programfiles32,'adwcleaner')
  exename = 'adwcleaner_6.041.exe'

  def install():
    mkdirs(targetdir)
    filecopyto(exename,targetdir)
    create_programs_menu_shortcut('ADWCleaner',target=makepath(targetdir,exename))
    # control est un objet PackageEntry correspondant au paquet en cours d'installation
    register_windows_uninstall(control)

  def uninstall():
    killalltasks(exename)
    remove_programs_menu_shortcut('ADWCleaner')
    if isdir(targetdir):
        remove_tree(targetdir)
    unregister_uninstall('tis-adwcleaner')
