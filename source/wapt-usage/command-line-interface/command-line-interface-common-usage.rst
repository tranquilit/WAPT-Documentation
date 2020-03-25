.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Using the more common functions in WAPT with the command line
  :keywords: command line, WAPT, CLI, special commands, update, upgrade,
             search, install, remove, clean

.. _wapt_cli_common_commands:

Using the more common functions in WAPT with the command line
-------------------------------------------------------------

wapt-get update
+++++++++++++++

The :command:`update` command allow to update the list of available packages.

The local WAPT agent will download :file:`Packages` file from the private
repository and compare it to its local database.

* If new updates are available, the WAPT agent switches the packages
  status to **TO-UPGRADE**;

* If new software have been added on the repository, they become
  downloadable by the WAPT agent;

.. note::

  The :command:`update` command does not download packages, it only updates
  the local database of packages.

The command :code:`wapt-get update` returns:

.. code-block:: bash

  Update package list
  Total packages: 751
  Added packages:

  Removed packages:

  Upgradable packages:
  upgrade
  additional
  install
  remove
  Repositories URL:
  https://srvwapt.mydomain.lan/wapt
  https://srvwapt.mydomain.lan/wapt-host

wapt-get upgrade
++++++++++++++++

The command :command:`wapt-get upgrade` allows to launch the installation
of packages waiting to be upgraded or waiting to be installed.

The local WAPT agent downloads if necessary WAPT packages in its local
cache then installs them.

.. hint::

  It's strongly advised to launch a :command:`wapt-get update` command before
  launching a :command:`wapt-get upgrade` command;

  Without previously launching a :command:`update`,
  the WAPT agent will install nothing;

The command :code:`wapt-get upgrade` returns:

.. code-block:: bash

  Installing tis-mumble
  Shutting down Mumble
  installing Mumble 1.2.8
  Installing w7demo.domain.lan

  === install packages ===
  w7demo.domain.lan (=3) | w7demo.domain.lan (3)

  === additional packages ===
  tis-mumble                     | tis-mumble (1.2.8-1)

wapt-get search
+++++++++++++++

The :command:`search` command allows to search for one or more package
in the repositories.

The search command takes one argument to be looked up in package name
and description.

The command :code:`wapt-get search "Firefox"` returns:

.. tabularcolumns:: |\X{2}{12}|\X{2}{12}|\X{2}{12}|\X{4}{12}|\X{2}{12}|

=============== ============ ========= =========================================
Package name    Version      Plateform Description
=============== ============ ========= =========================================
tis-firefox     50.0.2-73    all       Mozilla Firefox Web Browser in French
tis-firefox-en  50.0.1-58    all       Mozilla Firefox Web Browser in English
tis-firefox-esr 45.6.0-4     all       Mozilla Firefox Web Browser ESR
tis-flashplayer 24.0.0.186-1 all       Adobe Flashplayer for Firefox
=============== ============ ========= =========================================

wapt-get install
++++++++++++++++

The :command:`install` command launches the installation of a package.

The command takes on argument. That argument is the package
name with the repository prefix.

To install Mozilla Firefox, the command is
:code:`wapt-get install <prefix>-firefox`.

.. note::

  If the package has not been downloaded to cache, :command:`install`
  will first download the package to cache, then it will install it.

.. attention::

  Installing a WAPT package with :command:`install` does not add the package
  as a dependency to the host.

  The package is installed on the machine, but if the computer is re-imaged,
  the package will not be reinstalled automatically.

The command :code:`wapt-get install tis-firefox` returns:

.. code-block:: bash

  installing WAPT packages tis-firefox
  Installing tis-firefox.local/wapt/tis-firefox_50.0.2-73_all.wapt: 44796043 / 44796043 (100%) (33651 KB/s)
  Firefox Setup 50.0.2.exe successfully installed.
  Disabling auto update
  Disabling profile migration from ie
  Override User UI

  === install packages ===
  tis-firefox                    | tis-firefox (50.0.2-73)

wapt-get remove
+++++++++++++++

The :command:`remove <package name>` command removes a package.

The command takes on argument. That argument is the package name with the
repository prefix.

To remove Mozilla Firefox, the command is
:command:`wapt-get remove <prefix>-firefox`.

.. attention::

  Removing a WAPT package with :command:`remove` does not remove
  the package dependency on the host.

  **The package will effectively be uninstalled from the machine,
  but it will automatically be reinstalled on the next :command:`upgrade`.**

  To completely remove a package from a host, do a :command:`remove`
  for the targeted package, then edit the host configuration via the WAPT
  console to remove the package dependency on the host.

The command :code:`wapt-get remove tis-firefox` returns:

.. code-block:: bash

  Removing tis-firefox ...

  === Removed packages ===
    tis-firefox

wapt-get clean
++++++++++++++

The :command:`clean` command removes packages from the
:file:`C:\\Program Files (x86)\\wapt\\cache` folder.

The :command:`clean` command is launched after each upgrade to save disk space.

The command :code:`wapt-get clean` returns:

.. code-block:: bash

  Removed files:
  C:\Program Files (x86)\wapt\cache\tis-mumble_1.2.8-1_all.wapt
  C:\Program Files (x86)\\wapt\cache\tis-vlc_2.2.4-2_all.wapt
