.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Simple examples of commonly used functions
  :keywords: Tests, WAPT, user context, file and directory manipulation,
             examples, registry key, SetupHelpers, documentation

Simple examples of commonly used functions
==========================================

Presentation of several functions implemented in :term:`Setuphelpers`
and frequently used to develop WAPT packages.

Testing and manipulating folders and files
------------------------------------------

Creating a path recursively
+++++++++++++++++++++++++++

Command...

.. code-block:: python

  makepath(programfiles,'Mozilla','Firefox')

... makes the path variable for :file:`C:\\Program Files (x86)\\Mozilla\\Firefox`.

.. hint::

  For more informations or to learn more on arguments on that function,
  please visit official Setuphelpers reference documentation:

  https://www.wapt.fr/en/api-doc-1.5/source/setuphelpers.html?highlight=get_file_properties#setuphelpers.properties

Creating and destroying directories
+++++++++++++++++++++++++++++++++++

Command...

.. code-block:: python

  mkdirs('C:\\test')

... creates the directory :file:`C:\\test`.

.. hint::

  For more informations or to learn more on arguments on that function,
  please visit official Setuphelpers reference documentation:

  https://www.wapt.fr/en/api-doc-1.5/source/setuphelpers.html?highlight=get_file_properties#setuphelpers.properties

Commande :command:`remove_tree` ...

.. code-block:: python

  remove_tree(r'C:\tmp\target')

... destroys the directory :file:`C:\\tmp\\target`.

.. hint::

  For more informations or to learn more on arguments on that function,
  please visit official Setuphelpers reference documentation:

  https://www.wapt.fr/en/api-doc-1.5/source/setuphelpers.html?highlight=remove_tree#setuphelpers.remove_treee

Checking if a path is a file or a folder
++++++++++++++++++++++++++++++++++++++++

Command :command:`isdir` ...

.. code-block:: python

  isdir(makepath(programfiles32,'software')):
      print('The directory exists')

... checks if :file:`C:\\Program Files (x86)\\software` is a directory.

.. hint::

  For more informations or to learn more on arguments on that function,
  please visit official Setuphelpers reference documentation:

  https://www.wapt.fr/en/api-doc-1.5/source/setuphelpers.html?highlight=get_file_properties#setuphelpers.propertiesr

Command...

.. code-block:: python

  isfile(makepath(programfiles32,'software','file')):
      print('file exist')

... checks if :file:`C:\\Program Files (x86)\\software\\file` is a file.

.. hint::

  For more informations or to learn more on arguments on that function,*
  please visit official Setuphelpers reference documentation:

  https://www.wapt.fr/en/api-doc-1.5/source/setuphelpers.html?highlight=get_file_properties#setuphelpers.properties

Check if a directory is empty
+++++++++++++++++++++++++++++

Command...

.. code-block:: python

  dir_is_empty(makepath(programfiles32,'software')):
      print('dir is empty')

... checks that directory :file:`C:\\Program Files (x86)\\software` is empty.

.. hint::

  For more informations or to learn more on arguments on that function,
  please visit official Setuphelpers reference documentation:

  https://www.wapt.fr/en/api-doc-1.5/source/setuphelpers.html?highlight=get_file_properties#setuphelpers.properties

Copying a file
++++++++++++++

Command...

.. code-block:: python

  filecopyto('file.txt',makepath(programfiles32,'software'))

... copies :file:`file.txt` into the :file:`C:\\Program Files (x86)\\software`
directory.

.. hint::

  For more informations or to learn more on arguments on that function,
  please visit official Setuphelpers reference documentation:

  https://www.wapt.fr/en/api-doc-1.5/source/setuphelpers.html?highlight=get_file_properties#setuphelpers.properties

Copying a directory
+++++++++++++++++++

Command...

.. code-block:: python

  copytree2('sources','C:\\projet')

... copies the :file:`sources` folder into
the :file:`C:\\projet` directory.

.. hint::

  For more informations or to learn more on arguments on that function,
  please visit official Setuphelpers reference documentation:

  https://www.wapt.fr/en/api-doc-1.5/source/setuphelpers.html?highlight=get_file_properties#setuphelpers.properties

Retrieving the version of a file
++++++++++++++++++++++++++++++++

Command...

.. code-block:: python

  get_file_properties(makepath(programfiles32,'InfraRecorder','infrarecorder.exe'))['ProductVersion']

... shows package properties.

.. hint::

  For more informations or to learn more on arguments on that function,
  please visit official Setuphelpers reference documentation:

  https://www.wapt.fr/en/api-doc-1.5/source/setuphelpers.html?highlight=get_file_properties#setuphelpers.properties

Manipulating registry keys
--------------------------

Checking the existence of a registry key
++++++++++++++++++++++++++++++++++++++++

Command...

.. code-block:: python

  if registry_readstring(HKEY_LOCAL_MACHINE, "SOFTWARE\\Google\\Update\\Clients\\{8A69D345-D564-463c-AFF1-A69D9E530F96}", 'pv') :
      print('key exist')

... checks if registry key *{8A69D345-D564-463c-AFF1-A69D9E530F96}* exists
in registry path :file:`SOFTWARE\\Google\\Update\\Clients`
of *HKEY_LOCAL_MACHINE*.

.. hint::

  For more informations or to learn more on arguments on that function,
  please visit official Setuphelpers reference documentation:

  https://www.wapt.fr/en/api-doc-1.5/source/setuphelpers.html?highlight=registry_readstring#setuphelpers.registry_readstring

Showing the value of a registry key
+++++++++++++++++++++++++++++++++++

Command...

.. code-block:: python

  print(registry_readstring(HKEY_LOCAL_MACHINE, r'SOFTWARE\Google\Update\Clients\{8A69D345-D564-463c-AFF1-A69D9E530F96}', 'pv'))

... reads the value *{8A69D345-D564-463c-AFF1-A69D9E530F96}* stored in
the registry path :file:`SOFTWARE\\Google\\Update\\Clients`
of *HKEY_LOCAL_MACHINE*.

.. hint::

  For more informations or to learn more on arguments on that function,
  please visit official Setuphelpers reference documentation:

  https://www.wapt.fr/en/api-doc-1.5/source/setuphelpers.html?highlight=registry_readstring#setuphelpers.registry_readstring

Modifying the value of a registry key
+++++++++++++++++++++++++++++++++++++

Command...

.. code-block:: python

  registry_setstring(HKEY_CURRENT_USER, "SOFTWARE\\Microsoft\\Windows Live\\Common",'TOUVersion','16.0.0.0', type=REG_SZ)

... modifies the value of the registry key *TOUVersion* stored in the
registry path :file:`SOFTWARE\\Microsoft\\Windows Live` of *HKEY_CURRENT_USER*.

.. hint::

  For more informations or to learn more on arguments on that function,
  please visit official Setuphelpers reference documentation:

  https://www.wapt.fr/en/api-doc-1.5/source/setuphelpers.html?highlight=registry_setstring#setuphelpers.registry_setstring

Creating and destroying shortcuts
---------------------------------

create_desktop_shortcut/ remove_desktop_shortcut
++++++++++++++++++++++++++++++++++++++++++++++++

Command...

.. code-block:: python

  create_desktop_shortcut(r'WAPT Console Management',target=r'C:\Program Files (x86)\wapt\waptconsole.exe')

... creates the shortcut *WAPT Console Management* into :file:`C:\\Users\\Public`
directory pointing to :file:`C:\\Program Files (x86)\\wapt\\waptconsole.exe`;
the shortcut is available for all users.

.. hint::

  For more informations or to learn more on arguments on that function,
  please visit official Setuphelpers reference documentation:

  https://www.wapt.fr/en/api-doc-1.5/source/setuphelpers.html?highlight=create_desktop_shortcut#setuphelpers.create_desktop_shortcut

Command...

.. code-block:: python

  remove_desktop_shortcut('WAPT Console Management')

... deletes the *WAPT Console Management* shortcut from the folder
:file:`C:\\Users\\Public`; the shortcut is deleted for all users.

.. hint::

  For more informations or to learn more on arguments on that function,
  please visit official Setuphelpers reference documentation:

  https://www.wapt.fr/en/api-doc-1.5/source/setuphelpers.html?highlight=remove_desktop_shortcut#setuphelpers.remove_desktop_shortcut

create_user_desktop_shortcut/ remove_user_desktop_shortcut
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

.. hint::

  These functions are used in session_setup context

Command...

.. code-block:: python

  create_user_desktop_shortcut(r'WAPT Console Management',target=r'C:\Program Files (x86)\wapt\waptconsole.exe')

... creates the shortcut *WAPT Console Management* on user desktop
pointing to :file:`C:\\Program Files (x86)\\wapt\\waptconsole.exe`.

.. hint::

  For more informations or to learn more on arguments on that function,
  please visit official Setuphelpers reference documentation:

  https://www.wapt.fr/en/api-doc-1.5/source/setuphelpers.html?highlight=create_user_desktop_shortcut#setuphelpers.create_user_desktop_shortcut

Command...

Removing a shortcut for the current user

.. code-block:: python

  remove_user_desktop_shortcut('WAPT Console Management')

... deletes the *WAPT Console Management* shortcut from
the logged in user's desktop.

.. hint::

  For more informations or to learn more on arguments on that function,
  please visit official Setuphelpers reference documentation:

  https://www.wapt.fr/en/api-doc-1.5/source/setuphelpers.html?highlight=remove_user_desktop_shortcut#setuphelpers.remove_user_desktop_shortcut

Windows environment/ Software/ Services
---------------------------------------

windows_version
+++++++++++++++

.. code-block:: python

  windows_version()<Version('6.2.0'):

... checks that the Windows version is stricly inferior to *6.2.0*.

.. hint::

  For more informations or to learn more on arguments on that function,
  please visit official Setuphelpers reference documentation:

  https://www.wapt.fr/en/api-doc-1.5/source/setuphelpers.html?highlight=windows_version#setuphelpers.windows_version

  Visit also `Microsoft Windows version number <https://msdn.microsoft.com/fr-fr/library/windows/desktop/ms7248322>`_.

iswin64
+++++++

Command...

.. code-block:: python

  if iswin64() :
      print('Pc x64')
  else:
      print('Pc not x64')

... checks that the system architecture is 64bits.

.. hint::

  For more informations or to learn more on arguments on that function,
  please visit official Setuphelpers reference documentation:

  https://www.wapt.fr/en/api-doc-1.5/source/setuphelpers.html?highlight=get_file_properties#setuphelpers.properties

programfiles/ programfiles32/ programfiles64
++++++++++++++++++++++++++++++++++++++++++++

Return different *ProgramFiles* locations

Command...

.. code-block:: python

  print(programfiles64())

... returns native Program Files directory, eg. :file:`C:\\Program Files (x86)`
on either win64 or win32 architecture.

.. code-block:: python

  print(programfiles())

... returns path of the 32bit Program Files directory,
eg. :file:`Programs Files (x86)` on win64 architecture,
and :file:`Programs Files` on win32 architecture.

.. code-block:: python

  print(programfiles32())

user_appdata/ user_local_appdata
++++++++++++++++++++++++++++++++

.. hint::

  These functions are used with :command:`session_setup`

Command...

.. code-block:: python

  print(user_appdata())

... returns roaming *AppData* profile path
of logged on user (:file:`C:\\Users\\username\\AppData\\Roaming`).

.. hint::

  For more informations or to learn more on arguments on that function,
  please visit official Setuphelpers reference documentation:

  https://www.wapt.fr/en/api-doc-1.5/source/setuphelpers.html?highlight=get_file_properties#setuphelpers.propertiesser_appdata

Command...

.. code-block:: python

  print(user_local_appdata())

... returns the local *AppData* profile path
of the logged on user (:file:`C:\\Users\\username\\AppData\\Local`).

.. hint::

  For more informations or to learn more on arguments on that function,
  please visit official Setuphelpers reference documentation:

  https://www.wapt.fr/en/api-doc-1.5/source/setuphelpers.html?highlight=user_appdata#setuphelpers.user_appdatalocal_appdata

disable_file_system_redirection
+++++++++++++++++++++++++++++++

Command...

.. code-block:: python

  with disable_file_system_redirection():
      filecopyto('file.txt',system32())

.. hint::

  For more informations or to learn more on arguments on that function,
  please visit official Setuphelpers reference documentation:

  https://www.wapt.fr/en/api-doc-1.5/source/setuphelpers.html?highlight=user_local_appdata#setuphelpers.user_local_appdatable_file_system_redirection

Disable wow3264 redirection in the current context

get_computername/ get_current_user
++++++++++++++++++++++++++++++++++

Command...

.. code-block:: python

  print(get_current_user())

... shows the currently logged on username

.. hint::

  For more informations or to learn more on arguments on that function,
  please visit official Setuphelpers reference documentation:

  https://www.wapt.fr/en/api-doc-1.5/source/setuphelpers.html?highlight=get_file_properties#setuphelpers.properties

.. code-block:: python

  print(get_computername())

... shows the name of the computer

.. hint::

  For more informations or to learn more on arguments on that function,
  please visit official Setuphelpers reference documentation:

  https://www.wapt.fr/en/api-doc-1.5/source/setuphelpers.html?highlight=get_file_properties#setuphelpers.properties

Command...

.. code-block:: python

  get_domain_fromregistry()

... returns the :abbr:`FQDN (Fully Qualified Domain Name)` of the computer.

.. hint::

  For more informations or to learn more on arguments on that function,
  please visit official Setuphelpers reference documentation:

  https://www.wapt.fr/en/api-doc-1.5/source/setuphelpers.html?highlight=get_computername#setuphelpers.get_computernamein_fromregistry

installed_softwares/ uninstall_cmd
----------------------------------

installed_softwares
+++++++++++++++++++

Command...

.. code-block:: python

  installed_softwares('winscp')

... returns the list of installed software on the computer
from registry in an array.

.. code-block:: python

  [{'install_location': u'C:\\Program Files\\WinSCP\\', 'version': u'5.9.2', 'name': u'WinSCP 5.9.2', 'key': u'winscp3_is1', 'uninstall_string': u'"C:\\Program Files\\WinSCP\\unins000.exe"', 'publisher': u'Martin Prikryl', 'install_date': u'20161102', 'system_component': 0}]

.. hint::

  For more informations or to learn more on arguments on that function,
  please visit official Setuphelpers reference documentation:

  https://www.wapt.fr/en/api-doc-1.5/source/setuphelpers.html?highlight=get_domain_fromregistry#setuphelpers.get_domain_fromregistry

uninstalll_cmd
++++++++++++++

Command...

.. code-block:: python

  uninstall_cmd('winscp3_is1')

... returns the silent uninstall command.

.. code-block:: console

  "C:\Program Files\WinSCP\unins000.exe" /SILENT

.. hint::

  For more informations or to learn more on arguments on that function,
  please visit official Setuphelpers reference documentation:

  https://www.wapt.fr/en/api-doc-1.5/source/setuphelpers.html?highlight=get_file_properties#setuphelpers.properties

uninstalling software
+++++++++++++++++++++
Command...

.. code-block:: python

  for soft in installed_softwares('winscp3'):
      if Version(soft['version']) < Version('5.0.2'):
          run(WAPT.uninstall_cmd(soft['key']))

* for each item of the list return by *installed_softwares*
  containing keyword *winscp*;

* if the version is lower than 5.0.2;

* then uninstall using the *uninstall_cmd* and specifying
  the corresponding *uninstallkey*;

.. hint::

  For more informations or to learn more on arguments on that function,
  please visit official Setuphelpers reference documentation:

  https://dev.tranquil.it/sphinxdocs/source/setuphelpers.html?highlight=uninstall_cmd#setuphelpers.uninstall_cmd

killalltasks
++++++++++++

Command...

.. code-block:: python

  killalltasks('firefox')

... kills the process named *Firefox*.

.. hint::

  For more informations or to learn more on arguments on that function,
  please visit official Setuphelpers reference documentation:

  https://www.wapt.fr/en/api-doc-1.5/source/setuphelpers.html?highlight=get_file_properties#setuphelpers.propertiesillalltasks

Using control file fields
+++++++++++++++++++++++++

Command...

.. code-block:: python

  def setup():
      print(control['version'])

... shows the *version* value from the :file:`control` file.

Command...

.. code-block:: python

  def setup():
      print(control['version'].split('-',1)[0])

... shows the software version number without the WAPT version number
from the :file:`control` file.

Calling WAPT actions in a WAPT package
--------------------------------------

Installing a package
++++++++++++++++++++

Command...

.. code-block:: python

  WAPT.install('tis-scratch')

... installs *tis-scratch* on the computer.

Removing a package
++++++++++++++++++

Command...

.. code-block:: python

  WAPT.remove('tis-scratch')

... uninstalls *tis-scratch* from the computer.

Forgeting a package
+++++++++++++++++++

Command...

.. code-block:: python

  WAPT.forget_packages('tis-scratch')

... informs WAPT to forget *tis-scratch* on the selected computer.

.. hint::

  If the desired result is to remove *tis-scratch*, you should either reinstall
  the package (:code:`wapt-get install "tis-scratch"`) then remove it
  (:code:`wapt-get remove "tis-scratch"`), either removing it manually from
  the Control Panel menu :menuselection:`Add/ Remove Programs`.
