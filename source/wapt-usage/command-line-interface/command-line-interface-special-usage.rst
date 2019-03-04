.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Using special Command Lines with WAPT
  :keywords: command line, WAPT, CLI, register, download, download-upgrade,
             show, list, upgradedb, setup-tasks, enable-tasks, disable-tasks,
             add-upgrade-shutdown, remove-upgrade-shutdown, inventory,
             update-status, setlocalpassword, reset-uuid, generate-uuid,
             get-server-certificate, enable-check-certificate, session-setup,
             documentation

.. _wapt_cli_special_commands:

Using special Command Lines with WAPT
-------------------------------------

wapt-get register
+++++++++++++++++

The :code:`wapt-get register <description>` command reports the computer
hardware and software inventory to the WAPT inventory server.

.. hint::

  You can pass a description as an argument to the :command:`register`,
  that description will be displayed in the WAPT console in the column
  :guilabel:`description`.

  You may benefit from WAPT to improve your IT management by affecting
  a username or a computer serial as descriptions for your hosts.

The command :code:`wapt-get register "John Doe PC` returns nothing;

wapt-get download
+++++++++++++++++

The :code:`wapt-get download <package name>` command downloads the WAPT package
to the local cache located at :file:`C:\\Program Files\wapt\cache`.

The command :code:`wapt-get download tis-7zip` returns:

.. code-block:: bash

  Downloading packages tis-7zip (=16.4-8)

  Downloaded packages :
    C:\Program Files (x86)\wapt\cache\tis-7zip_16.4-8_all_all.wapt

wapt-get download-upgrade
+++++++++++++++++++++++++

The:code:`wapt-get download-upgrade`command downloads packages to be upgraded to
the local WAPT cache :file:`C:\\Program Files (x86)\wapt\cache`.

The command :code:`wapt-get download-upgrade` returns:

.. code-block:: bash

  === downloaded packages ===
  C:\Program Files (x86)\wapt\cache\tis-firebird_2.5.5.26952-1_all.wapt

wapt-get show
+++++++++++++

The :code:`wapt-get show <package name>`  command displays informations stored
in the :file:`Packages` index file.

If several versions of a package are available on the repository, every version
of the package will be displayed.

The command :code:`wapt-get show tis-firebird` returns:

.. code-block:: bash

  Display package control data for tis-firebird

  package           : tis-firebird
  version           : 2.5.5.26952-1
  architecture      : all
  section           : base
  priority          : optional
  maintainer        : Hubert TOUVET
  description       : Firebird database SQL superserver with admin tools (Firebird Project)
  filename          : tis-firebird_2.5.5.26952-1_all.wapt
  size              : 7012970
  repo_url          : https://srvwapt.mydomain.lan/wapt
  md5sum            : 6f6d70630674f5d58a5259b1e6752221
  repo              : global

wapt-get list
+++++++++++++

The :code:`wapt-get list` command lists WAPT packages that are installed
on the computer.

The command :code:`wapt-get list` returns:

.. tabularcolumns:: |\X{2}{12}|\X{2}{12}|\X{2}{12}|\X{2}{12}|\X{4}{12}|

==================== =========== ======== ================ ====================================
package              version     install  install_date     description
                                 status
==================== =========== ======== ================ ====================================
tis-7zip             16.4-8      OK       2016-12-01T17:43 7-zip compression
                                                           and archiving software
                                                           for x86 and x64

tis-brackets         1.8-1       OK       2016-12-01T17:44 Brackets is a lightweight
                                                           opensource text editor
                                                           developed by Adobe

tis-ccleaner         5.23.5808-0 OK       2016-12-01T18:55 the right choice utility
                                                           to quickly clean up,
                                                           repair and optimize Windows

tis-rsat-win7x64     2           OK       2016-12-02T10:46 package for MS RSAT Remote
                                                           server admin windows6.1-kb958830-x64
                                                           pour Win7 SP1

tis-rsat-x64         1           OK       2016-12-02T10:51 package for MS RSAT Remote
                                                           server admin windows6.1-kb958830-x64
                                                           pour Win7 SP1

tis-dotnetfx4.6      4.6.2-1     OK       2016-12-09T16:05 dot net FX 4.6.2 Framework CLient.
                                                           replace 4/4.5/4.5.1/4.5.2/4.6/4.6.1

tis-paint.net        4.0.12-3    OK       2016-12-09T16:08 Paint.NET Setup 32/64

tis-vlc              2.2.4-2     OK       2016-12-21T16:41 VLC media player

tis-mumble           1.2.8-1     OK       2016-12-21T16:42 automatic package for
                                                           Mumble 1.2.8 (Thorvald Natvig)

machine.mydomain.lan 3           OK       2016-12-21T16:42 None
==================== =========== ======== ================ ====================================

wapt-get upgradedb
++++++++++++++++++

The :code:`wapt-get upgradedb` command upgrades the local WAPT database schema
if necessary.

The command :code:`wapt-get upgradedb` returns:

.. code-block:: bash

  WARNING upgrade db aborted : current structure version 20161109 is newer or equal to requested structure version 20161109
  No database upgrade required, current 20161109, required 20161109

wapt-get setup-tasks - wapt-get enable-tasks - wapt-get disable-tasks
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

The :code:`wapt-get setup-tasks` command adds :command:`update`
and :command:`upgrade` scheduled tasks to local host.

.. hint::

  This function is useful when it is desirable not to use the WAPT service,
  otherwise :program:`waptservice` will take care of it.

To make it work, the following arguments must be configured
in :file:`wapt-get.ini`:

* *waptupdate_task_maxruntime*;

* *waptupgrade_task_maxruntime*;

* *waptupdate_task_period*;

* *waptupgrade_task_period*;

Then:

* the :code:`wapt-get enable-tasks` command will enable scheduled tasks;

* the  :code:`wapt-get disable-tasks` command will disable scheduled tasks;

wapt-get add-upgrade-shutdown - wapt-get remove-upgrade-shutdown
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

* the :code:`wapt-get add-upgrade-shutdown` command
  adds a :program:`waptexit` local security policy object,
  enabling the execution of :program:`waptexit` at system shutdown;

* the :code:`wapt-get remove-upgrade-shutdown` command
  removes the :program:`waptexit` local security policy object,
  disabling the execution of :program:`waptexit` during system shutdown;

wapt-get inventory
++++++++++++++++++

The :code:`wapt-get inventory` command displays all local inventory
information in JSON format.

The command :code:`wapt-get inventory` returns:

.. code-block:: bash

  {
    "wapt": {
      "setuphelpers-version": "1.3.8",
      "waptserver": {
        "dnsdomain": "mydomain.lan",
        "proxies": {
          "http": null,
          "https": null
        },
        "server_url": "https://srvwapt.mydomain.lan"
  },
  ...

wapt-get update-status
++++++++++++++++++++++

The command :code:`wapt-get update-status` resends local status to the WAPT
inventory server.

.. note::

  If a hardware component has changed on the computer,
  :command:`update-status` would not report that information back to the WAPT
  inventory server.

  To do so, the command to be used is :command:`inventory`.

The command :code:`wapt-get update-status` returns:

.. code-block:: bash

  Inventory correctly sent to server https://srvwapt.mydomain.lan.

wapt-get setlocalpassword
+++++++++++++++++++++++++

The :code:`wapt-get setlocalpassword` command allows to define
a local password for WAPT package installations.

The command :code:`wapt-get setlocalpassword` returns:

.. code-block:: bash

  Local password:
  Confirm password:
  Local auth password set successfully

wapt-get reset-uuid
+++++++++++++++++++

The :code:`wapt-get reset-uuid` command retrieves the host :term:`UUID`
from BIOS and resends it to the WAPT inventory server.

The command :code:`wapt-get wapt-get reset-uuid` returns:

.. code-block:: bash

  New UUID: B0F23D44-86CB-CEFE-A8D6-FB8E3343FE7F

wapt-get generate-uuid
++++++++++++++++++++++

The :code:`wapt-get generate-uuid` command creates a new host :term:`UUID`
and resends it to the WAPT inventory server.

.. hint::

  Some batches of computers have their BIOS with identical :term:`UUID`.
  It is a BIOS manufacturer setting problem because no two :term:`UUID`
  should be the same.

  The command :command:`generate-uuid` exist to solve that problem.

The command :code:`wapt-get generate-uuid` returns:

.. code-block:: bash

  New UUID: 6640f174-de90-4b00-86f7-d7834ceb45bc

wapt-get get-server-certificate
+++++++++++++++++++++++++++++++

The :code:`wapt-get get-server-certificate` command downloads the SSL
certificate from the WAPT Server to use HTTPS to communicate
with the WAPT Server.

The downloaded certificate is stored in
:file:`C:\\Program Files(x86)\\wapt\ssl\\server`.

The command :code:`wapt-get get-server-certificate` returns:

.. code-block:: bash

  Server certificate written to C:\Program Files (x86)\wapt\ssl\server\srvwapt.mydomain.lan.crt

wapt-get enable-check-certificate
+++++++++++++++++++++++++++++++++

The :code:`wapt-get enable-check-certificate` command downloads the SSL
certificate from the WAPT Server and enables secured communication
with the server.

The command :code:`wapt-get enable-check-certificate` returns:

.. code-block:: bash

  Server certificate written to C:\Program Files (x86)\wapt\ssl\server\srvwapt.mydomain.lan.crt
  wapt config file updated

wapt-get session-setup
++++++++++++++++++++++

The :code:`wapt-get session-setup` command launches user level customizations
of installed WAPT packages.

.. hint::

  The :command:`session-setup` instruction sets are defined in WAPT package's
  :file:`setup.py` file.

  Every instruction set is stored in a SQLite local database.

  The command :command:`session-setup` is launched at every startup,
  the user environment customization script is executed only once per user
  per package version.

.. note::

  The argument *ALL* will launch :command:`session-setup` for all installed WAPT
  packages.

The command :code:`wapt-get session-setup ALL` returns:

.. code-block:: bash

  Configuring tis-7zip ... No session-setup. Done
  Configuring tis-ccleaner ... Already installed. Done
  Configuring tis-vlc ... No session-setup. Done
  Configuring mdl-tightvnc ... No session-setup. Done
  Configuring tis-brackets ... No session-setup. Done
  Configuring mdl-firefox-esr ... No session-setup. Done
  Configuring tis-rsat-x64 ... No session-setup. Done
  Configuring tis-dotnetfx4.6 ... No session-setup. Done
  Configuring tis-rsat-win7x64 ... No session-setup. Done
  Configuring tis-mumble ... No session-setup. Done
  Configuring tis-paint.net ... No session-setup. Done
  Configuring wsagauvrit.domain.lan ... No session-setup. Done
