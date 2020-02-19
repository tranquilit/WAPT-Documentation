.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Using another IDE for WAPT
  :keywords: IDE, PyScripter, VSCode, PyCharm, WAPT

Using another IDE for WAPT
==========================

Introduction
------------

If you are used to work with another :term:`IDE`,
you can be relieved now as WAPT supports other editors.

Some code editors are natively supported:

* PyScripter;

* VSCode;

* VSCodium;

Other editors can be selected and will be launched when you create
a new template for a WAPT package from WAPT Console.

Configuring WAPT to use another IDE
-----------------------------------

.. note::

    Using a supported IDE will launch the WAPT package project
    with a valid debug configuration.

Using Microsoft Windows
+++++++++++++++++++++++

To configure another editor for WAPT, you must modify the ``editor_for_packages``
attribute in the ``[global]`` section of your WAPT console's
:file:`%LOCALAPPDATA%\\waptconsole\\waptconsole.ini` configuration file.

Possible values are:

=============================== ==========================================
Editor name                     editor_for_packages value
=============================== ==========================================
PyScripter                      None
Microsoft Visual Studio Code    :program:`vscode` or :program:`code`
Microsoft Visual Studio Codium  :program:`vscodium` or :program:`codium`
=============================== ==========================================

Example config in :file:`waptconsole.ini`:

.. code-block:: ini

   [global]
   ...
   editor_for_packages=vscode

Using Linux/Apple macOS
+++++++++++++++++++++++

To configure another editor for WAPT, you must modify the ``editor_for_packages``
attribute in the ``[global]`` section of your WAPT console's
:file:`%LOCALAPPDATA%\\waptconsole\\waptconsole.ini` configuration file.

By default, if the ``editor_for_packages`` attribute is empty,
WAPT will try to launch (in that order):

* :program:`vscodium`;

* :program:`vscode`;

* :program:`nano`;

* :program:`vim`;

* :program:`vi`;

Possible values are :

=============================== =========================================
Editor name                     editor_for_packages value
=============================== =========================================
Microsoft Visual Studio Code    :program:`vscode` or :program:`code`
Microsoft Visual Studio Codium  :program:`vscodium` or :program:`codium`
Nano                            :program:`nano`
Vim                             :program:`vim`
Vi                              :program:`vi`
=============================== =========================================

.. code-block:: ini

   [global]
   ...
   editor_for_packages=vim

Configuring WAPT to use a custom editor
---------------------------------------

Using Microsoft Windows
+++++++++++++++++++++++

Custom editors can be used, for example :program:`Notepad++`
or :program:`PyCharm`.

Custom editors example:

============ ===========================================================================================================
Editor name  editor_for_packages value
============ ===========================================================================================================
Notepad++    :file:`C:\\Program Files\\Notepad++\\notepad++.exe {setup_filename}`
PyCharm      :file:`C:\\Program Files\\JetBrains\\PyCharm Community Edition 2019.3.2\\bin\\pycharm64.exe {wapt_sources_dir}`
============ ===========================================================================================================

.. code-block:: ini

   [global]
   ...
   editor_for_packages=C:\Program Files\Notepad++\notepad++.exe {setup_filename}

Using Linux/Apple macOS
+++++++++++++++++++++++

Custom editors can be used, for example :program:`PyCharm`.

Custom editors example:

============ ========================================================
Editor name  editor_for_packages value
============ ========================================================
PyCharm      :file:`/opt/pycharm/bin/pycharm_x64 {wapt_sources_dir}`
============ ========================================================

.. code-block:: ini

   [global]
   ...
   editor_for_packages=/opt/pycharm/bin/pycharm_x64 {wapt_sources_dir}

Custom arguments
++++++++++++++++

Arguments can be passed in the :code:`editor_for_packages` command:

========================== ==========================================================
Argument                   Description
========================== ==========================================================
:code:`{setup_filename}`   Launches custom editor and edit WAPT package setup.py file
:code:`{control_filename}` Launches custom editor and edit WAPT package control file
:code:`{wapt_sources_dir}` Launches custom editor and opens WAPT package folder
:code:`{wapt_base_dir}`    Launches custom editor and opens WAPT install folder
========================== ==========================================================
