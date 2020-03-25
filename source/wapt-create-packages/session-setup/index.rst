.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Creating a WAPT package from the WAPT console
  :keywords: session_setup, WAPT, customize, user context, desktop shortcuts,
             special arguments, configuration, configure, directory, database,
             documentation

Customizing the user environment
================================

*session_setup* principles
--------------------------

It is sometimes necessary to customize a software in user context
to set specific settings or to comply to the Organization's rules
and preferences:

* creating user desktop shortcut with specific arguments;

* making changes to user Windows registry keys;

* making changes to files, to browser settings of the user;

* configuring shortcuts to the Organization's set of templates
  for Documents, Spreadsheets or Presentations in Office Suites
  to encourage or insure that editorial and graphical guidelines are followed;

* setting up the user's email or instant messaging from the Organization's
  main user data repository (LDAP directory, database, etc);

* customizing an office suite or business software based on the Organization's
  main user data repository (LDAP directory, database, etc);

The :command:`session_setup` function benefits from the power of python
to achieve a high level of automation.

Principles of *session_setup*
-----------------------------

The WAPT :command:`session_setup` function executes at every user startup,
launching that command:

.. code-block:: bash

  C:\Program Files (x86)\wapt\wapt-get.exe session-setup ALL

Calling that function executes the :command:`session_setup` script defined
within each WAPT package installed on the computer.

The WAPT agent stores in its local database
(:file:`C:\\Program Files (x86)\\wapt\\waptdb.sqlite`) the instruction sets
of all WAPT packages.

.. attention::

  :command:`session_setup` is launched only **once per WAPT package version
  and per user**.

  The WAPT agent stores in is local :file:`%appdata%\\wapt\\waptsession.sqlite`
  database the instances of :command:`session_setup` that have been already
  been played.

  To launch a program at every startup, consider using a startup script located
  in **User Startup** (*startup(0)*) or **All Users Startup** (*startup(1)*),
  or via a :abbr:`GPO (Group Policy Object)`.

Output example of :code:`wapt-get session-setup ALL`:

.. note::

  the connected user's ``session_setup`` had already been launched.

.. code-block:: bash

  wapt-get session-setup ALL

  Configuring tis-7zip ... No session-setup. Done
  Configuring tis-ccleaner ... Already installed. Done
  Configuring tis-vlc ... No session-setup. Done
  Configuring tis-tightvnc ... No session-setup. Done
  Configuring tis-paint.net ... No session-setup. Done
  Configuring wsuser01.mydomain.lan ... No session-setup. Done

Using *session_setup*
---------------------

The :command`session_setup` scripts are located in the section
*def session_setup()* of the :file:`setup.py` file:

Example:

.. code-block:: python

  def session_setup():
     registry_setstring(HKEY_CURRENT_USER, "SOFTWARE\\Microsoft\\Windows Live\\Common",'TOUVersion','16.0.0.0', type=REG_SZ)

.. attention::

  With :command:`session_setup`, there is no possibility to call files
  contained inside the WAPT package.

  To call external files when uninstalling, copy and paste the needed files
  in an external folder during the package installation process
  (example: a sub-directory created in the User's own directory).
