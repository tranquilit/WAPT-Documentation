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
=================================

Introduction
--------------

If you are used to work with another :term:`IDE`, you can be relieved now as WAPT supports other editors.

Some editors are natively supported : 

* PyScripter
* VSCode
* VSCodium

Other editors can be selected and will be launched when you create a new template for a WAPT package from WAPT Console


Configure WAPT to use another IDE
-----------------------------------------

.. note::

    Using a supported IDE will launch the WAPT package project with a valid debug configuration


Using Microsoft Windows
+++++++++++++++++++++++++++++

To configure another editor for WAPT, you must modify :code:`editor_for_packages` in :code:`[global]` section of :file:`%LOCALAPPDATA%\\waptconsole\\waptconsole.ini`.

Possible values are :

=================================================== =====================================================================================================================================================
Editor name                                         editor_for_packages value
=================================================== =====================================================================================================================================================
PyScripter                                          None
Microsoft Visual Studio Code                        :file:`vscode` or :file:`code`
Microsoft Visual Studio Codium                      :file:`vscodium` or :file:`codium`
=================================================== =====================================================================================================================================================

Example config in :file:`waptconsole.ini` :

.. code::

   [global]
   ...
   editor_for_packages=vscode


Using Linux/Apple macOS
+++++++++++++++++++++++++++++++++

To configure another editor for WAPT, you must modify :code:`editor_for_packages` in :code:`[global]` section of :file:`/opt/wapt/wapt-get.ini`.

By default, if :code:`editor_for_packages` is empty, WAPT will try to launch (in that order) :

* vscodium
* vscode
* nano
* vim
* vi

Possible values are :

=================================================== =====================================================================================================================================================
Editor name                                         editor_for_packages value
=================================================== =====================================================================================================================================================
Microsoft Visual Studio Code                        :code:`vscode` or :code:`code`
Microsoft Visual Studio Codium                      :code:`vscodium` or :code:`codium`
Nano                                                :code:`nano`
Vim                                                 :code:`vim`
Vi                                                  :code:`vi`
=================================================== =====================================================================================================================================================

.. code::

   [global]
   ...
   editor_for_packages=vim


Configure WAPT to use a custom editor
---------------------------------------------------

Using Microsoft Windows
+++++++++++++++++++++++++++++++

Custom editors can be used, for example Notepad++ or PyCharm.

Custom editors example :

=================================================== =====================================================================================================================================================
Editor name                                         editor_for_packages value
=================================================== =====================================================================================================================================================
Notepad++                                           :code:`C:\Program Files\Notepad++\notepad++.exe {setup_filename}` 
PyCharm                                             :code:`C:\Program Files\JetBrains\PyCharm Community Edition 2019.3.2\bin\pycharm64.exe {wapt_sources_dir}`
=================================================== =====================================================================================================================================================


.. code::

   [global]
   ...
   editor_for_packages=C:\Program Files\Notepad++\notepad++.exe {setup_filename}


Using Linux/Apple macOS
++++++++++++++++++++++++++++++++

Custom editors can be used, for example PyCharm.

Custom editors example :

=================================================== =====================================================================================================================================================
Editor name                                         editor_for_packages value
=================================================== =====================================================================================================================================================
PyCharm                                             :code:`/opt/pycharm/bin/pycharm_x64 {wapt_sources_dir}`
=================================================== =====================================================================================================================================================

.. code::

   [global]
   ...
   editor_for_packages=/opt/pycharm/bin/pycharm_x64 {wapt_sources_dir}


Custom arguments
++++++++++++++++++++++++++

Arguments can be passed in the :code:`editor_for_packages` command :

=================================================== =====================================================================================================================================================
Argument                                            Description
=================================================== =====================================================================================================================================================
:code:`{setup_filename}`                            Launches custom editor and edit WAPT package setup.py file
:code:`{control_filename}`                          Launches custom editor and edit WAPT package control file
:code:`{wapt_sources_dir}`                          Launches custom editor and opens WAPT package folder
:code:`{wapt_base_dir}`                             Launches custom editor and opens WAPT install folder
=================================================== =====================================================================================================================================================