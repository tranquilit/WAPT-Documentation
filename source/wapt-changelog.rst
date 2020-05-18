.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
    :description: Changelog
    :keywords: WAPT, History, Genesis, changelog, documentation

Changelog
=========

WAPT-1.8.2 RC1 (2020-05-18)
---------------------------

.. warning::
   This is a Release Candidate version for testing and evaluation only and 
   should not be installed on production system.

This is mostly a bugfix release. Support for Linux client has greatly improved.

Notable enhancement:

* [IMP] improve support for WaptAgent on Linux (install agent + selfservice + waptexit + session-setup + messagebox user, OU handling, kerberos authentication, setuphelpers coverage)

* [IMP] add new supported platform. Now WAPT for linux supports (both for server and agent) :

    * Ubuntu 18.04  et 20.04

    * Debian 8, 9 et 10

    * Centos7 (CentOS 8 as a preview)

* [IMP] streamlining of development environement for packaging on Linux

* [FIX] better handling of websocket cleanup when a host is not properly registered. Should improve stability on large WAPT installation

* [IMP] selfservice can now be configured for external authentication for desktop that are not in a AD Domain

* [IMP] selfservice users can now authenticate on selfserver even when out of corporate network

Other enhancements:

* [IMP] remote repository: it is now possible to prevent a fallback

* [FIX] better handling of icons in selfservice

* [IMP] improve support for VSCode

* [FIX] better handling of ipv6 in console and inventory

* [IMP] wapt_admin_filter : local admin can be filtered out like normal user in selfservice

* [IMP] add a larger support for setuphelpers on Mac

* [FIX] waptserver logs are properly redirected to /var/log/waptserver.log

* [FIX] package caching : package are deleted after each succesfull installation (rather than at the end of the whole upgrade) to better keep local disk space

* [IMP] allow usage of url for changelog in control file

* [IMP] better support for Windows Update download directly from Microsoft if WAPTServer is not reachable

* [FIX] better handling of upgrade from waptcommunity to waptentreprise

* [IMP] improve local store skin and translation

* [FIX] bugfixes and minor gui improvements

Libraries

* [REF] lazarus : switch from Python4Lazarus to Python4Delphi

* [REF] replacement of python-ldap with ldap3

* [FIX] upgrade ujson on waptagent and waptserver on Linux

Removed featured

* autoconfiguration of repositories based on SRV DNS fields (it was not working anymore anyway)

WAPT-1.8.1-6758 (2020-03-06)
----------------------------
(hash bb93ce41)

On server:

* [REF] refactoring for postconf.py / remove old migration from MongoDB

* [REF] refactoring for winsetup.py / create now a dhparam for nginx on Windows

* [REF] refactoring for repositories: change repo_diff by remote_repo_diff /
  add param remote_repo_websockets (by default to True) on server

* [IMP] disable cache on nginx for Windows and Linux on wapt packages / exe

On agents:

* [REF] change param waptservice_admin_auth_allow by waptservice_admin_filter

* [REF] delete resync functions for remote repo

* [IMP] param local_repo_sync_task_period by default to "2h"

* [FIX] wapt-get / waptservice debug when download a package on linux
  when not sudo

* [FIX] fix for plist in macOS

* [IMP] can now have relative path for packages/directories in wapt-get

* [IMP] templates have by default setup_uninstall / update etc...

* [IMP] improvements with templates for vscode

On waptconsole:

* [IMP] add possibility of template packages for deb / rpm / pkg

* [FIX] Fix for msi, exe, etc in PackageWizard explorer

* [IMP] Can now choose editor_for_packages directly in waptconsole config

* [UPD] Some cosmetic / translations improvements for GUI to deploy waptagent

WAPT-1.8.1-6756 (2020-02-17)
----------------------------
(hash 43394f3b)

Bug fixes and small improvements

* [IMP] waptconsole: improve the refresh of hosts grid when a lot of hosts
  are selected (improved by a factor of around 5)

* [FIX] waptserver Database connections management: don't close DB on teardown
  as it should not occur, and seems to trigger some issue when triggering
  a lot of tasks on remote hosts (error db is closed)

* [FIX] waptconsole: Don't "force" install when triggering the upgrade
  on remote hosts, to avoid reinstalling softwares when alreadu up to date.

* [IMP] use ldap auth only if session and admin fail (avoid waiting for timeout
  when ldap is not available but one wants to login with plain admin user)

* [FIX] wapt-get upload: encode user and password in http_upload_package
  to allow non ascii in admin password

* [IMP] waptconsole: Disable auto search on keywords

* [IMP] use DMI 'System_Information.Serial_Number' inforamtion
  for serialnr Host field instead of 'Chassis_Information.Serial_Number'
  because System_Information is more often properly defined.

* [IMP] waptconsole: add 'uuid' in the list of searched fields
  when only 'host' is checked in filters

* [IMP] nginx config: disable caching.

* [IMP] fixes for vscode project template

WAPT-1.8.1-6742 (2020-02-12)
----------------------------
(hash 80dbdbe7)

Major changes:
++++++++++++++++++++++++++++

* waptconsole: Added a page to show packages install status summary (merge)
  of all selected hosts, grouped by package,version,install status,
  with count of hosts.

  Context menu allow to apply selectively the pending actions.
  On enterprise, one can apply safely the updates (only packages for which
  there is no running process on client side)

* Prevent users from saving a host package if targeted host(s) do not accept
  their personal certificate. (Checked on waptconsole when editing /
  mass updating host packages, and on server when uploding packages)

  The personal certificate file (.crt) must contain at first
  the personal certificate, followed by the issuer CA certificates,
  so that wapt can rebuild certificate chain and check intersection
  with host's trusted certificates.

Important note about SSL client side authentication
+++++++++++++++++++++++++++++++++++++++++++++++++++

In your nginx configuration, be sure to reset the headers
``X-Ssl-Authenticated`` and ``X-Ssl-Client-DN`` as waptserver *trusts*
these headers if ssl cient side auth is enabled in :file:`waptserver.ini`.

If SSL client side auth is setup these headers can be populated
by ``proxy_set_header`` with result of ``ssl_verify_client`` as explained
in ./wapt-security/security-configuration-certificate-authentication.html#enabling-client-side-certificate-authentication

Fixes and detailed changelog
++++++++++++++++++++++++++++

* Security fix: update waitress module to 1.4.3 (CVE-2020-5236)

* Security fix: blank ``X-Ssl*`` headers in default nginx templates

* Fix: regression: kerberos register_host did not work anymore

* On server, :file:'<repository root>/wapt/ssl' dir is moved automatically
  on winsetup / postconf to (per default) :file:'<repository root>/ssl',
  a :file:`/ssl` location is added.

  This :file:`/ssl` should be accessible from clients
  at the location specified by the server parameter ``clients_signing_crl_url``
  (in :file:`waptserver.ini`)

* Improved logs readability. Log count of used DB connections
  from pool on waptserver to troubleshoot DB connection issues.
  Log level can be specified by subcomponent with loglevel_waptcore,
  loglevel_waptserver, loglevel_waptserver.app, loglevel_waptws,
  loglevel_waptdb defined in :file:`waptserver.ini`.

* Reworked explicit DB Open/close on waptserver to not get
  a DB connection from pool if not useful. It prevents exhaustion
  of DB connections.

* waptwinsetup: don't create unused directories wapt-group and waptserver\log

* Added :mimetype:`msu` and :mimetype:`msix` extensions
  for Package wizard setup file dialog

* Fallback with os._exit(10) for waptservice restart.
  Added a handler in nssm configuration to honor the restart.

* Increased waitress threads to 10 on waptservice

* Lowered the default number of pooled DB connections (db_max_connections)
  to 90, to be lower than postgresql default of 100

* waptserver: allow kerberos or ssl auth check in waptserver
  only if enabled in :file:`waptserver.ini` config file.

* waptconsole: Allow update of host package only if user certificate
  is actually allowed on the host (based on last update of host status
  in database).

* waptconsole / build waptagent: checkbox to specify to include or not
  non certificate authority certificates in build. The normal setup would be
  to uncheck this, to not deploy non CA certificates, on wapt root CA.

* Imp: Add and option to disable automatic hiding of panels...

* Imp: Add explicit AllowUnauthenticatedRegistration task to waptserversetup windows

* waptsetup: Remove explicit VCRedistNeedsInstall task. Use /VCRedistInstall=(0/1)
  if you need to force install or force not install
  vcredist VC_2008_SP1_MFC_SEC_UPD_REDIST_X86

* Fix: :program:`wapt-get.exe`: use wapt-get.ini for :command:'scan-packages'
  and :command:'update-packages' wapt-get actions

* Fix: :command:`wapt-get`: auth asked when checking if server is available (ping)
  and client ssl auth is enabled

* Imp: WAPT client: if client ssl auth failed with http error 400,
  retry without ssl auth to be able to ask for new certificate signing

* waptserver register behaviour: Revert over rev 6641: sign host certificate
  if an authenticated user is provided or data is signed with a key which
  can be verified by existing certificate in database for this host uuid

* waptserver register behaviour: When receiving 401 from server when registering,
  retry registering without ssl auth.

* wapt client: Be sure to have proper host private key saved
  on disk when receiving signed certificate from server.

* waptconsole: Advanced Filters for selected host packages status.
  Filter on Install status and Section + keyword. Pending button
  to show only pending installations / removes

* wapt-get make-template / edit package: Add .vscode directory.
  Add template project for vscode

* waptconsole: Fix ssl auth for mass package dependencies / conflicts updates

* waptconsole: Fix import packages from external repos with ssl auth

* backports from master:

  - target OS in import packages

  - choose editor for packages in linux in cmdline

* backports from master:

  - refactoring for HostCapabilities.waptos

  - add new target_os unix for mac and linux

  - so target_os: windows, darwin (for mac), linux or unix

* Fix WAPT.wapt_base_dir

* Fix makepath in linux/macOS

* Some refactoring / fixes for setuphelpers

* Fix for rights_to_check in repo-sync client

* Fix for repo-sync

* Add two setuphelpers for linux: type_debian and type_redhat

  indent the local sync.json

* use get_os_version and windows_version_from_registry instead of windows_version

* use windows_version_registry for get_os_version on windows

* backport host_capabilities.os from master

* Fix for make-template for malformed .exe installer

* Add automatic maintenance of a CRL for clients auth certificates signed by server

   default CRL lifetime to 30 days

   check renewal of client cert CRL every hour

   add a parameter for the next update time of crl

   add ``clients_signing_crl_url``, ``clients_signing_crl_days``,
   ``known_certificates_folder`` waptserver parameters

   add a :file:`/ssl` location in nginx templates

   add crl_urls in client auth signed certificates

   add a scheduled task to renew server side crl

   add ``clients_signing_crl`` waptserver parameter to add client cert
   to server crl when host is unregistered.

   Add revoke_cert methode to SSLCRL class

   Add a authorityKeyIdentifier to the client auth CRL

* force restart if windows task is broken

* waptservice: use sys._exit(10) to ask nssm to restart service in case
  of unhandled exception in waptservice (loops..)

* wapt client: don't log / store into db Wapt.runstatus if not changed

* waptserver postconf: fix for rights on some wapt directories.

* Add mutual conflicts to deb/rpm packages for waptagent/waptserver
  to avoid simultaneous install.

WAPT-1.8.0-6641 (2020-01-24)
----------------------------
(hash 3dbb3de8)

Major changes
+++++++++++++

* Client Agent for Linux Debian 8,9,10, Linux Centos 7, Ubuntu 18, 19 and MacOS.
  the packages are named wapt-agent and available
  in https://wapt.tranquil.it/wapt/releases/latest/

* Repository access rules defined in waptconsole. Depending of client IP,
  site, computername, one can define which secondary reporitory URL to use
  (Enterprise).

  **As a consequence, the DNS query method (with SRV records)
  is no more supported for repositories**

* The package and signature process has been changed to be compatible with python3.
  Serialization of dict is now sorted by key alphabetically
  to be deterministic across python versions.
  WAPT agents prior to version 1.7.1 will not be able to use new packages.
  (see git hash SHA-1: f571e55594617b43ed83003faeef4911474a84db)

* A WAPT agent can now be declared as a secondary Remote repository.
  Integrated syncing with main server repository is handled automatically.
  (Enterprise)

* waptconsole can now run without elevated priviledges. The build of waptagent /
  waptupgrade package are done in a temporary location.
  **When editing a package from waptconsole, PyScripter should be launched
  with elevated priviledges.**

  Note that you could deploy the agent with GPO without actually
  rebuilding a waptagent. Command line options are available on stock
  waptsetup-tis.exe to configure repo url (``/repo_url=``),
  server url (``/wapt_server=``), server certificate bundle location
  (``/CopyServersTrustedCA=``), packages certificates checking
  (``/CopyPackagesTrustedCA=``), ``/use_random_uuid``, ``/StartPackages``,
  ``/append_host_profiles``, ``/DisableHiberBoot``, ``/waptaudit_task_period``.

  Some options are still missing and may be added in a future release.

* package filename now includes a hash of package content to make it easier
  to check if download is complete and if package has been scanned
  (improved speed for large number of packages)

* The WAPT admin password must be regenerated (with postconf)
  if it not pbkdf2 based. See in your :file:`waptserver.ini` file,
  ``wapt_password`` must start with **$pbkdf2-**

Fixes and detailed changelog
++++++++++++++++++++++++++++

* waptagent can optionnally be digitally signed, if MS :program:`signtool.exe`
  is present in <wapt>\utils\ and if there is a pkcs#12 p12 file with same name
  as personal certificate crt file, and encrypted with same password.

* wapt-get.py can be run on linux and macos in addition to windows.

* waptconsole host's packages status reporting: now displays current version
  with 'NEED-UPGRADE','NEED-REMOVE','ERROR' status and future version
  with 'NEED-INSTALL' status.

  The status is stored in server's DB ``HostPackagesStatus``
  so it can be queried for reporting.

* setuphelpers: there now different setuphelpers
  for each operating system family.

* waptconsole: Added an action to safely trigger upgrades on remote hosts
  only if associated processes (impacted_process control attribute)
  are not running, to avoid disturbing users. (Enterprise)

* wapt-get --service upgrade: Added handling of --force,
  --notify_server_on_start=0/1, notify_server_on_finish=0/1 switches.

* package signature's date is now taken in account when comparing packages.

* add 'host_ad_site' key in [global] in :file:`wapt-get.ini` to define
  a fake Active Directory site for the host.

* waptconsole / packages grid: if multiple packages are selected,
  the associated "show clients" grid shows packages status
  for all selected clients. (Enterprise)

* waptagent build: Added checkbox to enable repository rules lookup
  when installing agent. (Enterprise)

* waptconsole / import packages: Don't reimport existing dependencies.
  Checkbox to disable import of dependencies.

* wapt-scanpackages speed optimizations: Don't reextract certificates
  and icon for skipped package entries. use md5 from filename
  if supplied when scanning.

* waptexit: fix arguments to waptexit for ``only_if_not_process_running``
  and ``install_wua_updates`` (bool).

* waptagent / waptwua fix wapt wua enabled setting reset to False
  when upgrading with waptagent and enabled=don't touch.

* waptserver / waptwua repository: all cabs files are now
  in root directory instead of microsft original file tree.
  The files are moved when upgrading to 1.8.

* waptupgrade package: Increment build number if building
  a new waptagent of the same main wapt version.

* waptserver parameter trusted_signers_certificates_folder:
  Path to trusted signers certificate directory. If defined, only packages
  signed by this trusted CA are accepted on the server
  when uploading through server.

* waptserver parameter 'remote_repo_support': If true, a task is scheduled
  to scan repositories (wapt waptwua wapt-hosts) that creates
  a :file:`sync.json` file for remote secondary repositories.

* when buiding waptagent, don't include non CA packages certificates
  by default in waptagent. A checkbox is available to still enable
  non CA certificates to be scanned and added.

* when building waptagent, one can add or remove certificates
  in the grid with Ctrl+Del or drag and drop.

* waptconsole / host packages status grid: Fixed :kbd:`F5` refresh.

* waptconsole / build agent: Build an enterprise agent even
  if no valid licence. (Enterprise)

* fix ``forced_update_on`` control attribute: Don't take into account
  for ``next_update_on`` if in the past.

* waptconsole: Try to accept waptserver password with non ASCII characters.

* waptstarter: Remove socle from default host profile

* waptagent build: Rework of server certificate path relocation when building /
  installing

* Don't sign agent certificate if no valid human authentication
  (admin, passwd or ldap) or kerberos authentication has been provided.

  Be explicit on authentication methods

  Stores registration authentication method in db only
  if valid human authentication or kerberos authentication has been provided.

  When registering, be sure we trust a already signed certificate
  with CN matching the host.

  Stores the signed host certificate in server DB on proper registration.

* some syntax preparation work for future python3.

* some preparation work for detailed ACL handling. (Enterprise)

* don't enable client ssl auth by default in waptserver as nginx reverse
  proxy server is perhaps misconfigured.

Python libraries / modules updates
++++++++++++++++++++++++++++++++++

* use waitress for waptservice wsgi server instead of unmaintained Rocket

* Flask-SocketIO 3.0.1 -> 4.2.1

* MarkupSafe 1.0 -> 1.1.1

* python_ldap-2.4.44 -> python_ldap-3.2.0


WAPT-1.7.4-6237 (2019-11-18)
----------------------------

(hash 1c00cefd)

* waptserver: add fix to workaround flask-socketio bug https://github.com/miguelgrinberg/Flask-SocketIO/issues/1054 (AttributeError: 'Request' object has no attribute 'sid')

* waptserver: be sure db is closed before trying to open it (for dev mode)

* waptserver: add logs messages when an exception message is sent back to the user.


WAPT-1.7.4-6237 (2019-11-18)
----------------------------

(hash 1c00cefd)

* waptserver: add fix to workaround flask-socketio bug https://github.com/miguelgrinberg/Flask-SocketIO/issues/1054 (AttributeError: 'Request' object has no attribute 'sid')

* waptserver: be sure db is closed before trying to open it (for dev mode)

* waptserver: add logs messages when an exception message is sent back to the user.

WAPT-1.7.4-6234 (2019-11-14)
----------------------------

(hash ad237eee)

* waptserver: upgrade peewee DB python module to 3.11.2. explicit connection handling to DB to track potential limbo connections (which could lead to db pool exhaustion)

* waptwua: Trap exception when pushing WU to Windows cache to allow valid updates to be installed even if some could not be verified properly.


WAPT-1.7.4-6232 (2019-10-31)
----------------------------

(hash2090b0e6d52cecfb04f8fa4c279e7c0a0252d6e2

* wapt-get session-setupp: fix bad print in session_setup. regression introduced in b30b1b1a550a4 (1.7.4.6229)

WAPT-1.7.4-6230 (2019-10-23) (not released)
-------------------------------------------
(hash 391d382f)

* return server git hash version and edition in ping and usage_statistics

* be sure to have server_uuid on windows when during setup

* fix for .git partially included in built package manifest

WAPT-1.7.4-6229 (2019-10-23)
----------------------------

(hash b30b1b1a)

* [Fix] 100% cpu load on one core on waptserver even when Idle.

python-engineio upgrade to 3.10.0
python-socketio upgraded to 4.3.1

* [Imp] Don't try run session_setup on package whic don't have one defined.

Limit text output on console (slow)

WAPT-1.7.4-6223 (2019-10-15)
----------------------------

(hash 86ddeaa2d)

* [Fix] Newlines in packages installs logged output.

* [Fix] Allow nonascii utf8 encoded user and password for server basic auth

* [Upd] Waptconsole: Default package filtering to x64 and console locale to avoid mistakes when importing.

* [Imp] Waptconsole: increase default Port Socket listening test timeout (for rdp, remote service access etc..) to 3s instead of 200ms...

* [Imp] Waptconsole: Sort Org unit by description in treeview

  Right click change current row selection in Org Ou treeview

* [New] option to set waptservice_password=NOPASSWORD in waptstarter installer

* [Fix] grid sorting for package / version / size of packages

* [Fix] don't create waptconsole link for starter

* [New] wapt-scanpackages: add an option to update the local Packages DB table from Packages file index

* [Fix] Regression introduced in previous build: maturities 'PROD' and '' are equivalent when filtering allowed packages

* [Fix] Waptconsole: grid headers too small for highdpi.

* [Upd] waptupgrade package filename: keep old naming without 'all' arch (for backward compatibility)

* [Imp] waptservice_timeout = 20 seconds now

* [Fix] AD auth for waptconsole with non ascii chars

* [Imp] Missing french translations for columns in Import packages grid

* [Fix] Be sure to terminate output threads in waptwinutils.run

* [Imp] Avoid showOnTop flickering for VisLoading

* setuphelpers.run_powershell! add $ProgressPreference = "SilentlyContinue" prefix command

* waptservice: protect test of host_cert date if file is deleted outside of service scope

* Improve WaptBaseRepo class:

  packages cache handling when repo parameters (filters...) are changed

  allow direct setting of cabundle for WaptBaseRepo

  keep a fingerprint of input config parameters

* [Upd] Set a fallback calculated package_uuid value in database for compatbility with old package status reports


WAPT-1.7.4-6196 (2019-09-27)
----------------------------

(hash f9cb3ebd)

* Revert package naming of waptupgrade to previous one to ease upgrade from previous wapt.

* Increase waptservice_timeout to  20 seconds per default

* Fix for AD auth when there are non ascii chars (encoding)

* Missing french translations for columns in Import packages grid

* Set a fallback calculated package_uuid in database for old package without package_uuid attribute in db status report

* wapt-scanpackages: add an option to update the local Packages DB table from Packages file index

* add an option to filters maturities

WAPT-1.7.4-6192 (2019-09-17)
----------------------------

(hash 3e00ac6688)

* [Sec] Update python modules python-engineio  and werkzeug to fix vulnerabilities

 CVE-2019-14806

 GHSA-j3jp-gvr5-7hwq

* [Upd] Python modules

  eventlet from 0.24.1 to 0.25.1

  flask from 1.0.2 to 1.1.1

  greenlet from 0.4.13 to 0.4.15

  itsdangerous from 0.24 to 1.1.0

  peewee from 3.6.4 to 3.10

  python-socketio from 1.9.0 to 4.3.1

  python-engineio 3.8.1 to 3.9.3

  websocket-client from 0.50 to 0.56

* [Upd] Add a request_timeout for client websockets of 15s per default

* [Fix] When building packages, excluded directories (for example .git or svn) were still included in manifest file.

* [Upd] Don't canonicalize package filenames by default when scanning server repository to ease migration from previous buggy wapt.

* [Fix] package filename not rewritten in Packages when renaming package

* [New] wapt-scanpackages: Add explicit option to trigger rename of packages filenames which do not comply with canonic form

* [New] wapt-scanpackages: Add option in to provide proxy

* [Upd] return "OK by default in package's audit skeleton

* [Imp] waptconsole cosmetic: minheight 18 pixels for grid headers

* [Fix] waptserver database model: bad default datatype in model.py for created_by and updated_by (were not used until now)

* [Fix] ensure_unicode for msi output: try cp850 before utf16 to avoid chinese garbage in run output

* [New] added connected_users to hosts_for_package provider

* [Fix] use win32api to get local connected IPV4 ip address instead of socket module. In some cases, secoket can't retreive the ip...

* [Fix] "wapt-get unregister" command not working properly

* [New] Waptselfservice: Add option in wapt-get.ini to disable unfiltered packages view of local admin

* [Imp] Waptselfservice  4K improvements.

* [Fix] Waptselfservice

- packages "restricted" were shown in selfservice / now corrected

- if the repo have no packages segmentation error / now corrected

- if the repo have changed segmentation error / now corrected


WAPT-1.7.4.6165 (2019-08-02)
----------------------------

(hash f153fab4)

Improvements
++++++++++++

* [New] add unregister action to wapt-get

* [Upd] improvements with the alt logo in the self-service

Changes
+++++++

* [Upd] Use version to build the package name of unit, groups and profile type package, like for base packages.

* [Upd] Add logs to uwsgi

Fixes
+++++

* [Fix] Bugfixes with the icons of the app self-service

* [Fix] Bugfixes with the logos in the self-service

* [Upd] waptexit: don't cancel tasks on CloseQuery

* [Upd] patch server.py earlier to avoid "execute cannot be used while an asynchronous query is underway"

* [Fix] fix waptexit doint nothing if allow_cancel_upgrade=0 and waptexit_disable_upgrade=0

* [Fix] fix issue with merge of wsus rules (can cause memory errors if more than one wsus package is applied on a host) (waptenterprise)

* [Fix] fix wua auto install_scheduling issue

* [Fix] waptexit: add a watchdog to workaround some cases where it hangs (threading issue ?)


WAPT-1.7.4.6143 (2019-06-25)
----------------------------

(hash da870a2c)

Improvements
++++++++++++

* Wapt Self service application is now fully usable. It is available in <wapt>\waptself.exe

* Add an option to set a random UUID instead of BIOS UUID at setup. This is to workaround bugged BIOS with duplicated Ids.

* Better Sphinxdocs for WAPT Libraries

Changes
+++++++

* [Upd] Behaviour Change: Use computer FQDN from tcpip registry entry (first NV Hostname key) then fixed domain then DHCP

* [Fix] Invert Zip and signature steps in package build operations to workaround issue with Bad Magic Number when signing already zipped big packages

* [New] Add use_ad_groups wapt-get global parameter to activate groups from AD (this is a time consuming task, so better not activate it...)

Fixes
+++++

* [Fix] appendprofile infinite loop during setup

* [Fix] read forced uuid from wapt-get.ini earlier to avoid loading a bad host certificate in memory if changing from bios uuid to forced uuid

* [Fix] setting use_random_uuid in waptagent.iss

* [Fix] waptstarter setup: force deactivate server, hostpackages

* [Fix] include waptself in waptstarter, don't include innosetup in waptstarter

* [Fix] ensure_unicode: add utf16 decoding test before cp850

* [Fix] add ensure_unicode for tasks logs to avoid unicode decode errors in get_tasks_status callback

* [New] host status: add boot_count attribute

* [Fix] fix potential float / unicode error when scanning win updates (Enterprise)

* [Fix] handles properly excluded files in package signatures

* [Fix] waptexit: avoid some work after checking if waptservice is running if it is not running.

* [Fix] a case where WAPTLocalJsonGet could loop forever if auth fails

* [Fix] setup.pyc in manifest but not in zipped package.

excludes exactly ['.svn','.git','.gitignore','setup.pyc'] when signing and zipping

inc_build before signing

* [Upd] add use_ad_groups setting in waptagent build. Default to False (Enterprise)

* [Fix] Better detection of waptbasedir for python27.dll loading

* [Fix] allow to sign source package directory to workaround bug in python zipfile (bad magic number)

* [New] Add a htpasswd password file method for restricted access to only add_host method

Allow add_host if provided host certificate is already signed by server and content can be verified

* [Fix] wapt-get.exe crash with "can not load... " when python 3.7 is installed from MS store

* [Fix] load private_dir conf parameter earlier

* [Upd] put a rnd- in front of randomly generated uuid

add a checkbox to use random uuid (if not already defined in wapt-get.ini)

* update SSL CA certifi lib

* [Imp] utf8 decode user /password in localservice auth

* [Upd] allow authentication on local waptservice with token

* [New] filter packages on hosts based on the valid_from and valid_until control attributes

force update sooner if valid_from or valid_until or forced_install_on is sooner than regular planned update_period

* [Fix] events reporting from service tasks.

* [Fix] waptexit: fix waptexit not closing of writing for running tasks but auto upgrade has been disabled

* waptexit: add waptexit_disable_upgrade option to remove the triggering of upgrade from waptexit, but keep the waiting for pending and running tasks.

  Fix / add 'running_tasks' key in waptservice checkupgrades.json. Was not reflecting an up to date state.

* [New] add new packages attributes: name, valid_from, valid_until, forced_install_on

* fix regression on profile packages not taken in account


WAPT-1.7.4.6082 (2019-05-20)
----------------------------

(hash 38e08433)

Fixes
+++++

* waptexit: fix waptexit not closing if waiting for running tasks but auto upgrade has been disabled.

* fix events reporting from service's tasks.

Updated
+++++++

* add new packages attributes: name, valid_from, valid_until, forced_install_on

* waptexit: add ``waptexit_disable_upgrade`` option to remove the triggering of upgrade from waptexit, but keep the waiting for pending and running tasks.

* improved: add 'running_tasks' key in waptservice checkupgrades.json. Was not reflecting an up to date state.

* waptself:

  - Start support of high DPI

  - loads Icons in background


WAPT-1.7.4.6078 (2019-05-17)
----------------------------

(hash 5b6851ae)

Fixes
+++++

* takes profiles packages (AD based groups) in account (Enterprise)

WAPT-1.7.4.6077 (2019-05-15)
----------------------------

(hash 4be40c534c4627)

Fixes
+++++

* waptdeploy: Fix regression on waptdeploy unable to read current waptversion from registry.

* be more tolerant to broken or inexistent wmi layer (for waptconsole on wine for example)

Fixes and improvements over rc2
+++++++++++++++++++++++++++++++

WAPT-1.7.4.6074 (2019-05-09)
----------------------------

(hash 95a146c002)

Fixes and improvements over rc2
+++++++++++++++++++++++++++++++

* [IMP] waptself.exe preview application updated. Load icons in background.

  Known issues:

  - does not work with repositories behind proxies and client side auth

  - https server certificate is not checked when downloading icons).

  - High DPI not handled properly

  - Cosmetic and ergonomic improvements still to come...

* [IMP] waptserver setup on windows: open port 80 on firewall in addition to 443

* [IMP] waptserver on Debian. add www-data group to wapt user even if user wapt already exists.

* [IMP] waptserver on CentOS. add waptwua directory to SELinux httpd_sys_content_t context

* [FIX] waptserver client auth: comment out ssl_client_certificate and ssl_verify_client.

  By default beacuse old client's certificate don't have proper clientAuth attribute. (error http 400)

* [FIX] problem accessing to 32bit uninstall registry view from 32bit wapt on Windows server 2003 x64 and Windows server 2008 x64.

  it looks like it is not advisable to try to access the virtual Wow6432Node virtual node with disabled redirection.

* [FIX] setuphelpers installed_softwares regular expression search on name.

  https://github.com/tranquilit/WAPT/issues/7

* [IMP] waptservice: for planned periodic upgrade, use single WaptUpgrade task like the one used in websocket.

* [IMP] waptexit: Cancel all tasks if closing waptexit form

* [FIX] wapt-get: wapt-get service mode with events

  refactor using uWAPTPollThreads

* [FIX] veyon cli executable name updated

* [IMP] wapt-get: check CN and subjectAltNames in lowercase for enable-check-certificate action

  (todo: doesn't take wildcard in account)

WAPT-1.7.4 rc2 (2019-04-30)
---------------------------

(hash 5ef3487)

Security
++++++++

* upgrade urllib3 to 1.24.2 for CVE-2019-11324 (high severity)

* upgrade jinja2 to 2.10.1 for CVE-2019-10906

New
++++

* Wapt self service application preview

Improvements
++++++++++++

* Propose to copy the newly created CA certificate to ssl local service dir, and restart waptservice. Useful for first time use.

Fixes
+++++

* [FIX] sign_needed for wapt-signpackages.py

* [FIX] missing StoreDownload table create

* [FIX] bug in fallback package_uuid calculation. didn't include the version...

WAPT-1.7.4 rc1 (2019-04-16)
---------------------------

(hash 4cdcaa06c83b)

Changes
+++++++

* Handles subjectAltName attribute for https server certificates checks in waptconsole (useful when certificate is a multi hostname commercial certificate). Before, only CN was checked against host's name.

* Client certificate auth for waptconsole.

* Versioning of wapt includes now the Git revision count.

Details
+++++++

* [FIX] replace openssl command line call with waptcrypto call to create tls certificate on linux server wapt install

* [FIX] add dnsname subjectAltName extension to self signed waptserver certificate on linux wapt nginx server configuration

* [FIX] pkcs12 export

* [NEW] Handle SubjectAlternativeName in certificates for server X509 certificate check in addition to CN

  Add a subjectAltName when creating self signed certificate on linux wapt nginx server in postconf

  For old installation, certificate is not updated. It should be done manually.

* [FIX] fix check_install returning additional packages to install which are already installed (when private repository is using locale or maturities)

  missing attributes in waptdb.installed_matching

* [NEW] Add client certificate path and client private key path for waptconsole access to client side ssl auth protected servers

* [FIX] fix regression on wapt-get edit <package>

  make filter_on_host_cap a global property of Wapt class instead of func parameter

* [FIX] Fix regression if there are spaces in org unit name. Console was stripping space for https://roundup.tranquil.it/wapt/issue911 and https://roundup.tranquil.it/wapt/issue908

* allow '0'..'9', 'A'..'Z', 'a'..'z', '-','_','=','~','.' in package names for org unit packages. replaces space with ~ in package names and ',' with '_'

* make sure we have a proper package name in packages edit dialogs

* waptservice config: allow waptupdate_task_period to be empty in wapt-get.ini to disable it in waptservice

* waptutils: fix regression on wget() if user-agent is overriden

* waptwua: fix an error in install progress % reporting for wua updates

* wapttray: Refactor tray for consistency. Makes use of uwaptpollthreads classes

* waptexit: some changes to try to fix cases when it does not close automatically.

* build: add git Revcount (commit count) to exe metadata

* waptconsole: fix hosts for package grid not refreshed if not focused

* [FIX] internal: use synapse httpsend for waptexit / wapt-get / wapttray local service http queries to workaround auth retry problems with indy.

* [ADD] wapt-get.exe: add --locales to override temporarily locales form wapt-get.ini.

* [ADD] wapt-get.exe: add WaptServiceUser and WaptServicePassword/WaptServicePassword64 command line params

  fix timeout checking in checkopenport

* core: add logs for self-service auth

* waptservice: Add /keywords.json service action

* waptservice: Add filter keywords (csv) on packages.json provider

* waptconsole: replace tri-state checkbox by a radio group for wua enabled etting in create waptagent dialog

* waptservice local webservice: temporary workaround to avoid costly icons retrieval in local service

* [FIX] simplify installed_wapt_version in waptupgrade package to avoid potential install issues

* [IMP]waptconsole layout: anchors for running task memo

* [FIX] Makefullyvisible for main form

  avoid forms outside the visible area when disconnecting a seonc ddisplay

* Fix layout of tasks panel for Windows 10

* [FIX] add token_lifetime server side (instead of using clockskew for token duration)

* [UPD] default unit "days" instead of minutes for wua scan download install and install_delay

* [ADD] Optional export of key and certificate as PKCS12 file in create key dialog. (to check SSL client auth in browsers...)

* [FIX] winsetup.py fix for backslashes in ngix

* [FIX] wapt-get json output / flush error

* [IMP] cache host_certificate_fingerprint and issuer id in local db so that we don't need to read private directory to get host_capabilities. Allow to use wapt-get list-upgrade as normal user.

* [UPD] Don't make DNS query in waptconsole Login / waptconfig to avoid DNS timeout if domain dns server is not reachable

* [FIX] Fix warning message introduced in previous revision when adding a new ini config on login (Enterprise)

* [FIX ] waptwua: handles redirect for wsusscn2 head request (Enterprise)

* [UPD] Report only 3 members on the wapt_version capability attribute

* core: refactor WaptUpgrade task: check task to append and then append them to tasks queue in WaptUpgrade.run instead of doing it in caller code. Avoid timeout when upgrading.

* core: self service rules refactoring

* core: notify server when audit on waptupgrade

* core: fix update_status not working when old packages have no persistent_dir in db

* core: tasks, events waptservice action: timeout in milliseconds instead of seconds for consistency

WAPT-1.7.3.11 (2019-03-25)
--------------------------

(hash 92ccb177d5c)

* [FIX] waptconsole: Use repo specific ca bundle to check remote repo server certificate (diffrent from main wapt repo)

* [FIX] waptconsole / hosts for packages: F5 does a local refresh

* [FIX] Improve update performance with repositories with a lot of packages.

* [FIX] improves wapttray reporting

  fix faulty inverted logic for notify_user parameter

* [FIX] waptconsole: bad filtering of hosts for package (Enterprise)

* [FIX] waptexit: fix waptexit closes even if Running task if no pending task / pending updates

* [FIX] waptexit: fix potential case where waptexit remains running with high cpu load

* [FIX] waptconsole:  Fix HostsForPackage grid not filtered properly (was unproperly using Search expr from first page)

* [FIX] waptservice: None has no check_install_is_running error at waptservice startup

* [FIX] core: set persistent_dir and persistent_source_dir attribute on setup module for install_wapt

* [FIX] core: fix bug in guessed persistent_dir for dev mode

* [FIX] core: fix error resetting status of stucked processes in local db (check_install_running)

* [FIX] waptservice: Trap error setting runstatus in db in tasks manager loop

  Don't send runstatus to server each time it is set

* [UPD] core: define explicitely the private_dir of Wapt object

* [UPD] server: Don't refuse to provide authtoken if fqdn has changed (this does not introduce sepcific risk as request is signed against UUID)

* [UPD] core: if package_uuid attribute is not set in package's control (old wapt), it is set  to a reproductible hash when package is appended to local waptdb so we can use it to lookup packages faster (dict)

* [NEW] waptconsole: Add audit scheduling setup in waptagent dialog (Enterprise)

  add set_waptaudit_task_period in innosetup installers

* [IMP] setuphelpers: add win32_displays  to default wmi keys for report

* [IMP] server setup: create X509 certificate / RSA key for hosts ssl certificate signing and authentication during setup of server

* [IMP] waptexit: add sizeable border and icons

  show progress of long tasks

* [IMP] waptservice: Process update of packages as a task instead of waiting for its completion when upgrading (to avoid timeout when running upgrade waptservice task)

  add ``update_packages`` optional (default True) parameter for upgrade waptservice action

* [NEW] Add audit scheduling setup in waptagent compilation dialog (Enterprise)

* [NEW] setuphelpers: Add get_local_profiles setuphelpers

* [IMP] waptserver: Don't refuse to provide authtoken for websockets auth if fqdn has changed

* [IMP] flush stdout before sending status to waptserver

* [IMP] waptcrypto handle alternative object names in csr build

* [IMP] wapt-get: --force option on wapt-get.exe service mode

* [NEW] use client side auth for waptwua too

* [CHANGE] server setup: nginx windows config: relocate logs and pid

  add conditional client side ssl auth in nginx config

* [CHANGE] waptconsole: refactor wget, wgets WaptRemoteRepo WaptServer to use requests.Session object to handle specific ssl client auth and proxies

  Be sure to set privateKey password dialog callback to decrypt client side ssl auth key

* [IMP] waptcrypto: add waptcrypto.is_pem_key_encrypted

* [IMP] waptconsole: Make sure waptagent window is fully visible.

* [IMP] waptconsole: Make sure Right click select row on all grids

* [ADD] waptconsole: Import from remote repo: add certificate and key for client side authentication.


WAPT-1.7.3.10 (2019-03-06)
--------------------------

(hash ec8aa25ef)

Security
++++++++

* upgraded OpenSSL dlls to 1.0.2r for https://www.cert.ssi.gouv.fr/avis/CERTFR-2019-AVI-080/ (moderate risk))

New
+++

* Much reworked wizard pages embedded in waptserversetup.exe windows server installer. Install of waptserver on Windows is easy again.

   register server as a client of waptserver

   create new key / cert pair

   build waptagent.exe and waptupgrade package

   configure package prefix

* If client certificate signing is enabled on waptserver (waptserver.ini config), the server sign a CSR for the client when the client is registered. See :ref:`client_side_certificate_authentication`.

* wapt-get: added new command ``create-keycert`` to create a pair of RSA key / x509 certificate in batch mode. self signed or signed with a CA key/cert

    (options are case sensitive...)

    /CommonName: CN to embed in certificate

    /Email /Country /Locality /Organization /OrgUnit: additional attributes to embed in certificate

    /PrivateKeyPassword: specify the password for private key in clear text form

    /PrivateKeyPassword64: specify the password for private key in base64 encoding form

    /NoPrivateKeyPassword: Ask to create or use an unencrypted RSA private key

    /CA=1 (or 0)): create a certification authority certificate if 1 (default to 1)

    /CodeSigning=1 (or 0) ): create a code signing certificate if 1 (default to 1)

    /ClientAuth=1 (or 0): create a certificate for authenticating a client on a https server with ssl auth. (default to 1)

    /CAKeyFilename: path to CA private key to use for signing the new certificate (default to  %LOCALAPPDATA%\waptconsole\waptconsole.ini [global] default_ca_key_path setting)

    /CACertFilename: path to CA certificate to use for signing the new certificate (default to  %LOCALAPPDATA%\waptconsole\waptconsole.ini [global] default_ca_cert_path setting)

    /CAKeyPassword: specify the password for CA private key in clear text form to use for signing the new certificate (no default)

    /CAKeyPassword64: specify the password for CA private key in base64 encoding form to use for signing the new certificate (no default)

    /NoCAKeyPassword: specify that the CA private to use for signing the new certificate is unencrypted

    /EnrollNewCert: copy the newly created certificate in <wapt>\ssl to be taken in account as an authorized packages signer certificate.

    /SetAsDefaultPersonalCert: set personal_certificate_path in configuration inifile [global] section (default %LOCALAPPDATA%\waptconsole\waptconsole.ini)

* [NEW] wapt-get: added new commands ``build-waptagent`` to compile a customized waptagent in batch mode.

    Copy waptagent.exe and pre-waptupgrade locally (if not /DeployWaptAgentLocally, upload to server with https)

    /DeployWaptAgentLocally: Copy the newly built waptagent.exe and prefix-waptupgrade_xxx.wapt to  local server repository directory ( <wapt>\waptserver\repository\wapt\ )

* [NEW] ``wapt-get register``: Add options for easy configuration of wapt when registering

  ``--pin-server-cert``: When registering, pin the server certificate. (check that CN of certificate matches hostname of server and repo)

  ``--wapt-server-url``: When registering, set wapt-get.ini wapt_server setting.

  ``--wapt-repo-url``: When registering, set wapt-get.ini repo_url setting. (if not provided, and there is not repo_url set in wapt-get.ini, extrapolate repo_url from wapt_server url)

* [NEW] wapt-get Add check-valid-codesigning-cert / CheckPersonalCertificateIsCodeSigning action

Improvements and fixes
++++++++++++++++++++++

* python libraries updates

  upgrade cryptography from 2.3.1 to 2.5.0

  upgrade pyOpenSSL from 18.0.0 from 19.0.0

* [FIX] don't reset host.server_uuid in server db when host disconnect from websocket

  set host.server_uuid in server db when host get a token

* [FIX] Modify isAdminLoggedIn to try to fix cases when we are admin but function return false

* [FIX]Ensure valid package name in package wizard (issue959)

* [FIX] regression Use python cryptography 2.4.2 openssl bindings for windows XP agent (openssl bindings of the python cryptopgraphy default WHL >= 2.5 does not work on windows XP)

* [FIX] trap exception when creating db tables from scratch fails, allowing upgrade of structure.

* [FIX] Reduce the risk of "database is locked" error

* [FIX] fix deprecation warning for verifier and signer when checking crl signature

* [FIX] persistent_dir calculation in package's call_setup_hook when package_uuid is None in local wapt DB (for clients migrated from pre 1.7 wapt, error None has no len() in audit log)

* [FIX] regression Don't try to use host_certificate / key for client side ssl auth if they are not accessible

* [IMP] Define proxies for crl download in wapt-get scan-packages

* [IMP] Fix bad normalization action icon

* [IMP] paste from clipboard action available in most packages editing grid

* [IMP] Propose to define package root dev path, package prefix, waptagent or new private key/ cert when launching waptconsole

* [IMP] Remove the need to define waptdev directory when editing groups / profiles / wua packages / self-service packages

* [IMP] Grid Columns translations in french

* [IMP] waptexit responsiveness improvements

  Separate events check thread and tasks check thread.

* [NEW] Add ClientAuth checkbox when building certificate in waptconsole

* [NEW] Add --quiet -q option to postconf.py

* [MISC] add an example of client side cert auth

* Add clientAuth extended usage to x509 certificates (default True) for https client auth using personal certificate

* Makes use of ssl client cert and key in waptconsole for server auth

* fix ssl client certificate auth not taken in account for server api and host repo

* add is_client_auth property for certificates

  default None for is_client_auth cert / csr build

  don't fallback to host's client certificate auth if it is not clientAuth capable (if so, http error 400)

* [MISC] waptcrypto: Add SSLPKCS12 to encapsulate pcks#12 key/cert store

* [MISC] Add splitter for log memo in Packages for hosts panel

* Store fixes

* Be tolerant when no persistent_dir in wsus packages

  Min wapt version 1.7.3 for self service packages and waptwua packages

* fix WsusUpdates has no attribute 'downloaded'

WAPT-1.7.3.7 (2019-02-19)
-------------------------

(hash 373f7d92)

Bug fixes
++++++++++

* fix softs normalization dialog closed when typing F key (Enterprise)

* include waptwua in nginx wapt server windows locations  (Enterprise)

* fix force option from service or websockets not being taken in account in install_msi_if_needed or install_exe_if_needed

* improved win updates reporting (uninstall behaviour)  (Enterprise)

* add uninstall action for winupdates in waptconsole  (Enterprise)

* fix reporting from dmi "size type" fields with non int content  (Enterprise)

Improvements
++++++++++++

* waptexit: Allow minimize button

* waptexit: Layout changes

* AD Auth: less restrictive on user name sanitity check (Enterprise)

* handle updates of data for winupdates with additional download urls  (Enterprise)

* Add some additional info fields to WsusUpdates table (Enterprise)

* add filename to Packages table for reporting and store usage (Enterprise)

* Add uninstall win updates to waptconsole (Enterprise)

* Add windows updates uninstall task capabilities (Enterprise)

* add filename to Packages table

* increased default clockskew tolerance for client socket io


WAPT-1.7.3.5 (2019-02-13)
-------------------------

Bug fixes
+++++++++

* Fix regression in package filenames (missing _)

* fix mismatch for waptconsole [global] waptwua_enabled setting

* default waptconsole EnableWaptWUAFeatures to True

WAPT-1.7.3.4 (2019-02-13)
-------------------------

Bug fixes
+++++++++

* waptexit: Fix install of and empty list of Windows Updates (Enterprise)

* wapt-get.exe WaptWUA commands: fix import of waptwua client module  for waptwua-scan download install (Enterprise)

* fix install_delay for Windows Updates stored as a time_delta in waptdb (Enterprise)

Improvements
++++++++++++

* Add versioning on group packages filenames

* Add button to create AD Host profiles (package automatically installed/removed based on AD Grouo memberships)

* Reduce wapttray notifications occurences. notify_user=0 per default

* waptexit: fix details panel does not show the pending packages to install

* Always install the missing dependencies in install (even if upgrade action should have queued dependencies installs bedoire) for cases for some corner cases.

* Fix get server certificate chain popup action in build waptagent

* Add action to create a key / cert in waptconsole conf

* Hide inactive / disabled WaptWUA actions in Host popup menu.

* Add checkbox to dispaly newest only for Groups

* Add waptconsole config parameter 'licences_directory" to specify the location (directory) of licences (Enterprise)

* waptagent build dialog: Removed the "Append host's profiles" option

* remove waptenterprise directory if waptsetup community is deployed over a waptenterprise edition

WAPT-1.7.3.3 (2019-02-11)
-------------------------

* Core

  - Better support for locales, maturities and architecture packages filtering

* Self service rule packages (Enterprise)

  - Package to define which packages can be installed / remove for groups of users.

  - WAPT Windows Updates rules packages (Enterprise)

* Package to define which Windows Updates are allowed / forbidden to be deployed by Wapt WUA agents

* **waptagent** build:

  - Add option for use_fqdn_as_uuid when building waptagent.exe

  - Add option to define the profile package to be deployed upon Wapt install on hosts.

  - Add options to enable WaptWUA (Windows updates with Wapt) (Enterprise)

* Host Profile packages (Enterprise)

  - Specific packages (like Group packages) which are installed or removed depending of wapt-get.ini [global] host_profiles ini key

  - If a "profile" package name matches Computer's AD Groups, it is deployed automatically.

* Reporting (Enterprise)

  - Import / Export queries as json files

  - Softwares names normalization as a separate dialog.

* **waptexit**:

  - reworked to make it more robust

  - Takes in account packages to remove

  - Takes in account Wapt WUA Updates (Enterprise).

    - command line switch:  /install_wua_updates

    - wapt-get.ini setting: [waptwua] install_at_shutdown=1

    - checkbox in waptexit to skip install of Windows Updates

* **waptconsole** Custom commands:

  - Ability to define custom popupmenu commands which are launched for the selection of hosts. Custom variables {uid}

* Other improvements:
  French translations fixes

Changelog 1.7.2
---------------

* Reporting (Enterprise)

  Basic SQL reporting capabiliti

  Duplicate action / copy paste for reporting queries

* setuphelpers: added helpers
  processes_for_file
  add get_computer_domain


Librairies updates
------------------

* python 2.7.15 on Windows

* openssl-1.0.2p libeay

* upgraded python-requests to 2.20.0 (Security Fix)


Improvements
------------

* Don't refresh GridHostsForPackage if not needed (Enterprise)

* Don't add a newline to log text output for LogOutput

* improved handling of update_host_data hashes to reduce amount of data sent to server on each update_server_status

* set python27.dll path in wapt-get and waptconsole.exe (fix cases with multiple python installations)

* fix removal of packages when upgrading host via websockets

* don't get capa if not needed when updating
  don't check package control signatures in wapt-get when loading list of packages for development tasks

* Moved static waptserver assets to a /static root
  split base.html and index.html templates for blueprints

* Fix selective pending wua install or downloads (Enterprise)

* fix wua updates filter logic (Enterprise)

* uninstall host packages if use_hostpackages is set to false

  Add a forced update in the task loop when host capabilities have been changed

  Include use_host_packages and host_profiles in host's capabilities.

* Fix regression not removing implicit packages.

* more tolerant to unicode errors in update_host_data to avoid hiding actual exception behind an encoding exception.

* fix order of columns not kept when exporting reports (Enterprise)

* ``install_msi_if_needed``, ``install_exe_if_needed``:  check if killbefore is not empty or None

* changed tasks's progress and runstatus to property

* Fix Audit aborted due to exception: 'NoneType' object is not iterable (Enterprise)

* setuphelpers: Add get_app_path and get_app_install_location

  Add fix_wmi procedure to re-register WMI on broken machines

  some wmi fallbacks to avoid unregistered machines when WMI is broken on them

* Online wua scans (Enterprise)

* Add a random package_uuid when signing a package metadata which could be used later as a primary key

  creates a random package_uuid when installing in DEV mode

  creates a random package_uuid when installing a package without package_uuid

* Moved and renamed EnsureWUAUServRunning to setuphelpers

* Add pending_reboot_reasons to inventory

* Display package version for missing packages

* wapt-get sign-packages: Add setting maturity and inc version in sign-packages action

* Add WindowsUpdates's host History grid below WindowsUpdate grid. (Enterprise)

* Stores Host Windows update history in server DB (Enterprise)

* Keep selected or focused rows in Grids

* Updates Packages table when uploading a Package / Group. This table is meant mainly for reporting purpose.

* Disable indexes for some BinaryJson fields

* fix windows update install_date reporting (Enterprise)

* Add checkbox to enable "use_fqdn_as_uuid" when building waptagent.exe

* Change default value for upgrade_only_if_not_process_running

* Changed naming of organizational unit packages to remove ambiguity with comma in package name and comma to describe list of packages depends / conflicts

  Replace ',' with '_' when editing package. (Enterprise)

* waptexit: add priorities and only_if_not_process_running  command line switches

* waptupgrade: Changed windows_version and Version

* setuphelpers windows_version: added members_count

* waptutils.Version: strip members to members_count if not None

* Add control attributes editor keywords licence homepage package_uuid to local waptservice db

* add short fingerprint to repr of SSLCertificate

* Be sure password gui is visible even if parent window is not

* add gui for private key password dialog if --use-ggui

* Add --use-gui "wapt-get.exe" command line arg to force use of waptguihelper for server credentials when registering.

WAPT-1.6.2.7 (2018-10-02)
-------------------------

This is a bugfix release for 1.6.2.5

* *waptexit*: changed the default value of
  *upgrade_only_if_not_process_running* parameter to *False*
  instead of *True*:

  if *upgrade_only_if_not_process_running* is *True*, the install tasks for
  packages with running processes (*impacted_process*) are skipped;

  if *upgrade_only_if_not_process_running* is *False*, the install tasks
  for packages with running processes may impact the user if the installer
  kills the running processes;

* *waptwua*: take in account Windows Updates *RevisionNumber* attribute
  to identify uniquely an Update in addition to UpdateID field (**Enterprise**
  only). This fixes the 404 error when downloading missing
  windows updates on a client.

WAPT-1.6.2.6 (2018-09-26)
-------------------------

This is a bugfix release for 1.6.2.5

* fix for WAPTServer Enterprise on Windows: added proper upgrade path from
  :program:`PostgreSQL 9.4` (used in WAPT 1.5) to :program:`PostgreSQL 9.6`
  which is required for WAPT-Windows Update:

  * new database binary and data directory path are suffixed with -9.6;

  * old data is suffixed with -old after migration;

* fix upgrade script for :program:`MongoDB` upgrade (WAPT 1.3)
  to :program:`PostgreSQL` used since WAPT 1.5;

* fix regression on WMI / DMI inventory which may be not properly
  sent back to the server;

WAPT-1.6.2.5 (2018-09-14)
-------------------------

Main new features if you are coming from 1.5:

* per package *Audit* feature (**Enterprise** only);

* *WAPT managed Windows Updates* tech preview (**Enterprise** only);

* wizards to guide post configuration
  of Windows server and first use of :program:`waptconsole`;

* :program:`waptconsole`/ private repo page: added a grid which shows
  the computers where the selected package is installed;

It includes numerous changes over the 1.5.1.26 version.

New
+++

* per package Audit feature:

  - def audit() hook function to add into package's :file:`setup.py`.
    By default, check *uninstall key* presence in registry:

  - :command:`wapt-get audit`;

  - :command:`wapt-get -S audit`;

  - :command:`wapt-get audit <packagename>`;

  - right click in waptconsole on machines or installed
    packages/ Audit package;

  - synthetic audit status for each machine;

  - for each installed package: *last_audit_status*, *last_audit_on*,
    *last_audit_output*, *next_audit_on*;

  - scheduled globally with wapt-get.ini parameter ``[global]``:

    .. code-block:: ini

      waptaudit_task_period = 4h

    or in package's :file:`control` file:

    .. code-block:: ini

      audit_schedule = 1d

  - audit log displayed in :program:`waptconsole` below installed package grid
    if :guilabel:`Audit Status` column is focused;

* Updated python modules

* build with Lazarus 1.8.2 instead of CodeTyphon 2.8
  for the Windows executables:

  * better strings encoding handling Easier to setup for the development

Known issues
++++++++++++

* :program:`PostgreSQL 9.6` is required for WAPT WUA tech preview
  (Debian Jessie not supported);

* WAPT 1.6 includes one more security layer in the agent to server connection.
  After server upgrade, the client desktops won't be able to connect
  to the server as long as they have not been upgraded themselves.
  If you require to be able to remotely manage the WAPT agent while the agent
  has not yet been upgraded, it is necessary
  to set *allow_unauthenticated_connect* to *True* in :file:`waptserver.ini`;

Fixes
+++++

* [Fix] add AD Groups as Hosts dependencies in :program:`waptconsole`;

* [Fix] remove image on reachable column if no status has been sent yet;

* [Fix] Organizational Units WAPT packages not being installed
  when there are spaces in DN;

* [Fix] Operational error when host are trying
  to reconnect but are not registered;

* [Fix] fill in *created_on* db fields on win updates data;

* debian server postinst: remove old :file:`pyc` files;

Changes
+++++++

* Improved WAPT console setup Wizard;

* *allow_unauthenticated_connect* defaults to
  *allow_unauthenticated_registration* if it is not explicitly set in
  :file:`waptserver.ini` file (This will ease migration from 1.5 to 1.6);

* :kbd:`Escape` key on password edit of login moves focus
  to configuration combo;

* PackageEntry.asrequirement(): removed space between package name
  and version specification;

* missing *install_date* in *insert_many* for some updates;

* add force arg for WAPTUpdateServerStatus action;

* don't includes :file:`setup.py` in initial host's
  packages inventory, and full inventory;

* allow to use installed :program:`waptdeploy.exe` without retry/ignore dialog;

* be sure error is reported properly in :program:`socketio`;

* added *package_uuid* and homepage package attributes;

* added installed on columns for host wsus updates;

* fix WUA grid layout saving;

WAPT-1.6.2.2 (2018-07-16)
-------------------------

Known issues
++++++++++++

* :program:`PostgreSQL 9.6` is required for WAPT WUA tech preview
  (Debian Jessie not supported);

* the authentication of client connections to the WAPT websockets server
  is not compatible with pre-1.6.2 wapt clients. During migration,
  if you want to keep the connection with clients, you have to disable
  the authentication with the parameter: *allow_unauthenticated_connect* = 0
  in server's configuration file :file:`waptserver.ini`.
  When all clients have migrated, this can be removed;

New
+++

* wizard for the initial configuration of :program:`waptserver` on Windows;

* wizard for the initial configuration of :program:`waptconsole`
  connection parameters;

* **Enterprise only**: waptconsole/ private repo page: added a grid
  which shows the computers where the selected package is installed;

* **Enterprise only**: WAPT WUA Windows Updates management technical preview:

  - activate with *waptwua_enabled* = 1 in :file:`wapt-get.ini` file
    on the client;

  - scan of updates on Windows clients with the IUpdateSearcher Windows API
    and the :file:`wsusscan2` cab file from Microsoft;

  - additional page in :guilabel:`WAPTconsole` host inventory for
    Windows updates status reported (HostWsus model);

  - additional page in :guilabel:`WAPTconsole` for the consolidated view
    of all updates reported by hosts (WsusUpdates model);

  - periodic Task on server to check and download newer version
    of :file:`wsusscan2` cab file from Microsoft (daemon/ service wapttasks);

  - periodic Task on server to download missing windows updates files
    as reported by Windows client after scan:

    * missing files are downloaded if one of the client should install
      it and has not yet a copy in its local windows update cache;

    * downloads are logged in *WsusDownloadTasks* model;

Changes
+++++++

* added field in hosts table to keep the hashes of sent host data,
  so that clients can send only what needs to be updated;

* added *db_port server* config parameter if :program:`posgresql` server
  is not running on standard port 5432is not running on standard port 5432;

* added editor optional attribute for package control, used
  in *register_windows_uninstall* helper if supplied;

* websocket authentication with a timestamped token obtained
  from server with client SSL certificateom server with client SSL certificate;

* json responses from :program:`waptserver` are gzipped;

Fixes
+++++

* forced host uuid

* forced computer AD Organizational unit

* public certs dir

* fix caching of negative result for certs chain validation

* refactoring of server python modules (*config*, *utils*, *auth*, *app*,
  *common*, *decorators*, *model*, *server*) for the enterprise modularity;

* fix timezone file timestamp handling for http download;

Python modules updates
++++++++++++++++++++++

* peewee to 3.4

* eventlet==0.23.0

* huey 1.9.1

* eventlet 0.20.1 -> 0.22.1

0.22.1

  * event: Event.wait() timeout=None argument to be
    compatible with upstream CPython

  * greendns: Treat /etc/hosts entries case-insensitive;
    Thanks to Ralf Haferkamp

0.22.0

  * dns: reading /etc/hosts raised DeprecationWarning for universal lines
    on Python 3.4+; Thanks to Chris Kerr

  * green.openssl: Drop OpenSSL.rand support; Thanks to Haikel Guemar

  * green.subprocess: keep CalledProcessError identity;
    Thanks to Linbing@github

  * greendns: be explicit about expecting bytes from sock.recv;
    Thanks to Matt Bennett

  * greendns: early socket.timeout was breaking IO retry loops

  * GreenSocket.accept does not notify_open; Thanks to orishoshan

  * patcher: set locked RLocks' owner only when patching existing locks;
    Thanks to Quan Tian

  * patcher: workaround for monotonic "no suitable implementation";
    Thanks to Geoffrey Thomas

  * queue: empty except was catching too much

  * socket: context manager support; Thanks to Miguel Grinberg

  * support: update monotonic 1.3 (5c0322dc559bf)

  * support: upgrade bundled dnspython to 1.16.0 (22e9de1d7957e)
    https://github.com/eventlet/eventlet/issues/427

  * websocket: fd leak when client did not close connection properly;
    Thanks to Konstantin Enchant

  * websocket: support permessage-deflate extension;
    Thanks to Costas Christofi and Peter Kovary

  * wsgi: close idle connections (also applies to websockets)

  * wsgi: deprecated options are one step closer to removal

  * wsgi: handle remote connection resets; Thanks to Stefan Nica

0.21.0

  * new timeout error API: .is_timeout=True on exception object.
    It's now easy to test if network error is transient and retry
    is appropriate. Please spread the word and invite other libraries
    to support this interface.

  * hubs: use monotonic clock by default (bundled package);
    Thanks to Roman Podoliaka and Victor Stinner

  * dns: EVENTLET_NO_GREENDNS option is back, green is still default

  * dns: hosts file was consulted after nameservers

  * wsgi: log_output=False was not disabling startup and accepted messages

  * greenio: Fixed OSError: [WinError 10038] Socket operation on nonsocket

  * dns: EAI_NODATA was removed from RFC3493 and FreeBSD

  * green.select: fix mark_as_closed() wrong number of args

  * New feature: Add zipkin tracing to eventlet

  * db_pool: proxy Connection.set_isolation_level()

* Flask-socketio 2.9.2 -> 3.0.1

* python-engineio 2.0.1 -> 2.0.4

* python-socketio 1.8.3 -> 1.9.0

* websocket-client 0.47

WAPT-1.6.2.1 (2018-07-04)
-------------------------

New features
++++++++++++

* Audit: def audit() optional hook in package is called periodically
  to check compliance. Log and status is reported in server DB
  and displayed in console (**Enterprise**).

* WSUS tech preview: based on local Windows update engine and :file:`WSUSSCAN2`
  cab Microsoft file. WAPT server act as a caching proxy for updates.
  Scanning for, downloading and applying Windows updates can be triggered
  from console on workstations (**Enterprise**).
  A new wapttasks process is launched on the server to download updates and
  wsusscan cab from Internet.

Changes / Improvements
++++++++++++++++++++++

* Better utf8 handling

* wapt-get make-template from a directory creates
  a basic installer for portable apps.

* wapt-get, waptexit: Removed ZeroMQ message queue on the client,
  replaced by simple http long polling to monitor tasks status.

* waptconsole: Replaced blocking timer based http polling for tasks
  status by threaded http long polling.

* waptconsole: Filter hosts on whether current personal certificate signature
  is authorized for remote tasks (**Enterprise**). If same server is used
  for several organizations, it allows to focus on own machines.
  This supposes that different CA certificates are deployed depending
  on the client host's organization. In this release, the filtering is not
  enforced and not cryptographically authenticated.

* Renamed waptservice.py to service.py and waptserver.py to server.py,
  activated absolute import for all python sourced
  absolute import for all python sources

* Removed *use_http_proxy_for_template* parameter
  (setting is now in ``[wapt-templates]`` repo)

waptservice
+++++++++++

* Handle WUA tasks (Scan, download, apply updates) (**Enterprise**)

* Handle Auditing tasks

waptserver
++++++++++

* Added a tasks queue (Huey) for the WSUS background tasks (**Enterprise**).

* gzip compression activated on the nginx configuration

wapttray
++++++++

* option in wapt-get.ini to hide some items:

  * hidden_wapttray_actions: comma separated list of:

   LaunchWAPTConsole register serviceenable reloadconfig cancelrunningtask
   cancelalltasks showtasks sessionsetup forceregister localinfo configure

* use long polling instead of zmq

* stop/ start/ query waptservice using a thread to avoid gui freeze.

Fixes
+++++

* waptguihelper: be sure to load the proper python27.dll

* core: forward *force* argument from console to setup.py install() hook

* overwrite psproj package file when editing a package to fix path to WAPT
  python virtualenv and add new debug actions.

Modules updates
+++++++++++++++

* GUI Binaries are built with Lazarus 1.8.2/ fpc 3.0.4 instead
  of CodeTyphon 2.8.

* peewee 3.0.4

* eventlet 0.23.0

* huey 1.9.1

* pywin32 rev 223

* Flask-socketio 2.9.6

* engineio.socket 2.0.4

* websocket-client 0.47

* pyOpenSSL 17.5.0

* request 2.19.1

Known issues
++++++++++++

* *unit* type of packages (with AD DN style names) are not well handled
  by local WAPT self service, because of commas in name.

WAPT-1.6.1.0 (2018-06-21)
-------------------------

Fixes
+++++

* wapttray: fix av potential cause

* improved buffer LogOuput

* fix wait task result loop in waptserver

* fix bad acl on waptservice

* fix repo timeout not taken in account

* bad parameter for repo_url and [wapt-host] section

* waptexit AV potential cause

* make isAdmin non blocking as a workaround for false positive checks

* use timeout parameter when importing external package

* pass timeout parameter when importing

* fix bad repo_url config naming

* fix calc hash when compiling if file does not exist

* fix repo timeout is float

* fix custom zip corruption when signing a package with non ascii filenames

* fix check wapt_db is assigned when rollbacking

* improved logging in events

* waptconsole: fix bug installed packages section is reported as *base*
  instead of unit or host

* ensure manual service wua running when using command line

* Python modules updates
  upgrade peewee to 3.4
  eventlet==0.23.0
  huey 1.9.1

* Replace eventprintinfo with LogOutput Add waptwua_enabled
  config parameter missing ensure_listdd waptwua_enabled config parameter
  missing ensure_list

* Default *waptwua_enabled* to None to avoid wuauserv
  service configuration change

* added missing columns for windows window updates

* waptconsole: Add action in waptconsole to show help on KB

* wapttray cosmetic: hide duplicated separators
  in tray popup menu when some actions are hidden

* Add http_proxy ini setting for the server external download operations

* wapttray: Start and stop WAPTservice using a thread to avoid gui freeze

* Pure FPC PBKDF2 password hash calc for postconf

* Refactor server code to share app and socketio instances

* fix: forward the "force" argument (command line and through the websockets)
  to the install() setup.py hook

* fix: wapttray: don't display all missed events at tray startup

* no default audit_period

* Removed zeromq, replaced by long http polling between wapttray, wapt-get
  and waptservice

WAPT 1.5.1.26 (2018-07-12)
--------------------------

Bug fixes
+++++++++

* revert monkey_patch for server on windows. No reason to exclude thread...

* add 'allow_unauthenticated_connect' server config (default false)

* fix CRITICAL update_host failed UnboundLocalError("local variable 'result'
  referenced before assignment",)

* fix https://roundup.tranquil.it/wapt/issue951

* fix https://forum.tranquil.it/viewtopic.php?f=13&t=1160ix

* fix https://forum.tranquil.it/viewtopic.php?f=13&t=1160

* fix init_workdir.bat

* Returns a token when updating host data for websocket auth

* Rewrite package psproj when editing (to fix wapt basedir paths)

* fix %s -> %d format string for expiration warning message

* fix host_certificate not found for waptstarter

* some dev build scripts

WAPT-1.5.1.24 (2018-07-04)
--------------------------

Bug fixes
+++++++++

* fix zipfile python library bug for packages which contains files
  with non-ascii filenames. Signed WAPT packages were corrupted in this case.

* fix deadlocks on server database when simultaneous DB connections
  is larger than 100 (default maximum connections configured by default
  on postgresql)

* fix waptconsole crash on warning message when license
  is about to expire (Enterprise)

* fix %s -> %d format string for expiration warning message

* fix host_certificate not found for waptstarter

* update waptserversetup.iss to include enterprise modules (**Enterprise**)

* fix download link to waptsetup and waptdeploy on server index page for Windows

Modules updates
+++++++++++++++

* requests 2.19.1

* Rocket 1.2.8 - Don't try to resurrect connections that timeout.
  Increase the timeout ... to decrease the likelihood.

  - handle PyPi only supports HTTPS/TLS downloads now

  - Fix the problem that when body is empty no terminating
    chunk is sent for chunked encoding.

  - Avoid sending the terminating chunk in case it's a HEAD request.

  - Fix the problem that when body is empty no terminating
    chunk is sent for chunked encoding.

  - Explicitly set the log level to warning.

  - Fix bug "Threadpool grows by negative amount when max_threads = 0"

  - Don't try to resurrect connections that timeout. Increase the timeout
    to decrease the likelihood.

  - handle PyPi only supports HTTPS/TLS downloads now

  - Fix the problem that when body is empty no terminating chunk is sent
    for chunked encoding.

  - Avoid sending the terminating chunk in case it's a HEAD request.

  - Fix the problem that when body is empty no terminating
    chunk is sent for chunked encoding.

  - Explicitly set the log level to warning.

  - Fix bug "Threadpool grows by negative amount when max_threads = 0"

WAPT-1.5.1.23 (2018-03-28)
--------------------------

Changes
+++++++

* waptexit: Displays a custom PNG logo if one
  is created in :file:`%WAPT_HOME%\\templates\\waptexit-logo.png`

* nssm.exe is signed with Tranquil IT code signing key

* waptconsole: Add locale and maturity columns in packages status grid

* waptconsole: wapagent wizard; be sure to get a relative path
  when checking cert validity

* waptsetup: Add /CopyPackagesTrustedCA and /CopyServersTrustedCA command line
  parameters to allow deployment of wapt with specific certificates
  with GPO for wapt without recompiling waptsetup.

  Example:

    :code:`C:\tmp\waptdeploy
    --hash=e17c4eddd45d34000df0cfe64af594438b0c3e1ee9791812516f116d4f4b9fa9
    --minversion=1.5.1.23
    --waptsetupurl=http://buildbot/~tisadmin/wapt/latest/waptsetup.exe
    --setupargs=/CopyPackagesTrustedCA=c:\tmp\tranquilit.crt
    --setupargs=/CopyServersTrustedCA=c:\tmp\srvwapt.mydomain.lan.crt
    --setupargs=/verify_cert=ssl\server\srvwapt.mydomain.lan.crt
    --setupargs=/repo_url=https://srvwapt.mydomain.lan/wapt
    --setupargs=/waptserver=https://srvwapt.mydomain.lan
    --setupargs=/DIR=c:\wapt`

Bug fixes
+++++++++

* waptconsole: regression introduced in 1.5.1.22. Unable to login if server
  has not a fully qualified domain name (FQDN)

* setuphelpers: winstartup_info fallback when COMMON_STARTUP
  folder does not exist, repeventing a client to register properly.

* version/ revision in wapttray dispkay the git hash instead
  of old svn rev number.

* waptconsole: update fr translation for certs bundle hint

* waptconsole: compare properly packages when number of version
  members differs 1.3 -<> 1.3.1 for example

WAPT-1.5.1.22 (2018-03-27)
--------------------------

Bug fixes
+++++++++

* Fix add Active Directory groups

* Fix newest only with *locale*, *architecture* and *maturity*

* Fix Import from external repository with mixed *locale*,
  *architecture* and *maturity*

* Add --setupargs to :program:`waptdeploy`

* RPM fix

* Enterprise build fix (Enterprise)

* Different icons for WAPT Community and Enterprise editions

* Switch to Community features when no licence instead of aborting
  (**Enterprise**)

* Some up to date Installed Packages marked as upgradable because
  of bad comparison maturity None/ maturity ''

* Depends and conflicts fields of HostsPackagesStatus table limited
  to 800 chars -> type changed to ArrayField
  to handle unlimited number of dependencies

* git python module added as part of WAPT libraries

* list organizational unit packages in Group package table (**Enterprise**)

* fix MongoDB to PostgreSQL database upgrade script

* fix licence/ hosts count/ expiry check (**Enterprise**)

* relative path for *verify_cert*

Known issues
++++++++++++

* When waptserver is searched with DNS SRV query (dnsdomain param),
  Kerberos register auth is not working.

WAPT-1.5.1.21 (2018-03-13)
--------------------------

Global architecture
+++++++++++++++++++

* Multiple languages for description of packages. English, French, German,
  Spanish, Polish are handled as a start point. More to be added in the future.

* The Description columns in waptconsole displays either languages depending
  on *language* setting in :file:`waptconsole.ini`.
  In packages, *description_fr*, *description_en*, etc... have been added.

* When renaming hosts, old host package (matching previous host uuid)
  is now "removed" instead of forgotten.is now "removed" instead of forgotten.

* [NEW] Handle AD organizational unit packages (Enterprise edition)

* New package attributes:

  * *locale* attribute: A computer can be configured to accept
    only packages with a specific locale.

  * *maturity* attribute:  stores status like *DEV, *PREPROD*, *PROD
    to describe the level of completion of the package. Computers
    can be configured to accept packages with specified maturities.
    Default packages maturity of computer is both the empty one and *PROD*.

  * *impacted_process* attribute: csv list of process names which
    would be killed before install (:command:`install_msi_if_needed`,
    :command:`install_exe_if_needed`) and uninstall (by the mean of uninstallkey
    list). Could be used too in the future for "soft" upgrade remote action
    which upgrade softwares while they are not running.

Setup/ WAPT upgrades
++++++++++++++++++++

WAPTupgrade package:

* Increased lifetime for upgrade task windows scheduler trigger
  for computers which are down for many days when upgrading.

* Added a trigger at start of the computer.

WAPTconsole
+++++++++++

* Displays the list of embedded trusted packages certificates
  when building the custom waptagent installer.

Bug fixes
+++++++++

* handle unicode filepaths for Packages Wizard.

* work in progress improvement of unicode handling globally in WAPTconsole.

* fix use proxy if needed for "download and edit" from external repo

Setuphelpers
++++++++++++

* fix bug in :command:`create_programs_menu_shortcut` and
  :command:`create_user_programs_menu_shortcut`. Shortcuts were created
  in :file:`startup` and not :file:`startup/programs`.

WAPT-1.5.1.19 rc1 (2018-03-08)
------------------------------

Global architecture
+++++++++++++++++++

There is now some additional support for packages localization.

In Package :file:`control` file, the *description_fr*, *description_en*,
*description_de*, *description_pl*, *description_es* can be used
to give description in respective french, english, german, polish languages.

If not set, the base description is used.

WAPTconsole
+++++++++++

WAPT-1.5.1.18 rc1 (2018-02-27)
------------------------------

Global architecture
+++++++++++++++++++

There is a significant internal change on how python libraries are managed
inside WAPT. This There is a significant internal change on how python libraries
are managed inside WAPT. This has implications on the way python scripts
are launched. This change is only relevant for peoples launching WAPT
processes manually.

We have removed the (not clean) sys.path manipulations inside wapt python
scripts sources. The consequence is that all python scripts must be run
with prior setting PYTHONHOME and PYTHONPATH pointing to WAPT home directory
(:file:`/opt/wapt` on Linux).

Failing to do so results in scripts claiming that libraries are missing.

On Linux waptserver, libs are now in the default :file:`/opt/wapt/lib/python2.7`
location instead of using non standard former one.

* [IMP] WAPT has its own full python environment for libraries,
  even when debugging. Before, system wide python27 installation
  was needed for :program:`PyScripter` to run.

  Now, :program:`PyScripter` can be started with a special
  batch file :file:`waptpyscripter.bat` which sets the environment variables
  for python (PYTHONHOME and PYTHONPATH) and run :program:`PyScripter`
  with python dll path set to wapt own copy.

* [NEW] Command line scripts with proper environment:

  * *wapt-serverpostconf* on Linux server to start server postconf.py

  * *wapt-scanpackages*

  * *wapt-signpackages*

* [NEW] Added some debugging commandline tools which setup python environment
  properly before running the python script.ly before running the python script:

    * To debug waptservice, launch in cmd as admin: *runwaptservice.bat*;

    * To debug waptserver, launch in cmd: *runwaptserver.bat*
      or under linux: *runwaptserver.sh*;

    * To launch :program:`PyScripter` without the need for local
      system wide python27 install, run :program:`waptpyscripter.bat`;

WAPT client
+++++++++++

* [IMP] Add local wapt-get.ini settings *packages_whitelist*
  and *packages_blacklist* to restrict accepted packages from repository
  based on their package's name;

* [IMP] More detailed reporting off host's repositories configuration
  (now includes dnsdomain, proxy, and list of trusted certificates);

* [FIX] fixed display in the Windows task bar of the login window
  (to allow in particular the autofill of the password by password managers);
  waptagent failing to compile if keys/ certificates already exist
  but the certificate had been removed from :file:`C:\\wapt\\ssl`;

* [NEW] Handle AD organizational unit packages (Enterprise edition)

* [IMP] Fallback to basic auth when a host is registering on waptserver
  if Kerberos is enabled but authentication fails.

* [IMP] for :program:`wapt-get.exe`, allow to designate configuration
  :file:`wapt-get.ini` file with *--config* option with base name
  of user waptconsole ini file (without ini extension) instead of full path.
  Handy when switching between several configurations. Same behaviour
  as for waptconsole. Example:

  :code:`wapt-get -c site3 build-upload c:\\waptdev\\test-7zip-wapt`;

* [FIX] Be sure to not loop for ever in websockets retry loop if something
  is wrong in host waptserver or websocket configuration.

* [FIX] Update PyScripter project template to use project directory as parameter
  for debug actions, and use relative paths for filenames.

* [FIX] Fix bad package version comparison. Return True when comparing 1.2-1
  to 1.2.1-3 (note: this is not homogeneous with the Version() class behaviour.
  todo: merge both);

* [FIX] waptsetup: register and update must be launched with elevated
  privileges. So remove *runasoriginaluser* option.

* [NEW] Introduced attributes target_os and impacted_process for package's
  :file:`control` file. They are not yet taken in account.

* [NEW] Introduced machinery to handle X509 client certificates authentication
  for repositories and waptserver (specially for public servers);

* [NEW] Introduced classes to generate X509
  :abbr:`CRL (Certificate Revocation List)`;

Setuphelpers
++++++++++++

* [UPD] setuphelpers.removetree:  Try to remove readonly flag when remove_tree
  reach a Access Denied error.

* [FIX] unicode handling in shell startup shortcuts.

* [IMP] waptutils.wget can check sha1 or sh256 hashes in addition to md5,
  and can cache and resume partial downloads.

WAPT Console
++++++++++++

* [NEW] Action in WAPTconsole to plan in near future
  a restart of waptservice on selected Hosts.

* [IMP] Mass host update/upgrade in waptconsole actions are now launched
  in single shot instead of one host at a time.

* [NEW] Allow to force a host_dn in :file:`wapt-get.ini`
  when host is not in a domain (**Enterprise**).

* [NEW] Add timeout parameter for setuphelpers
  *service_start*, *service_stop* and *service_restart*.

* [IMP] Group filter list box is now editable, and one can type a partial
  group match and press enter to filter on all matching groups.
  Seperator is comma (*,*). Handle * at the end of search to find
  all occurrences even if one group matches exactly.

WAPT Server
+++++++++++

* Add bat script migrate-hosts.bat to set environment for migrate-hosts.py

* Add trigger_action.py script to trigger action on pre 1.5 hosts with
  reachable 8088 waptservice port from 1.5 server.

* Fix registration_auth_user reset to None when reusing host certificate
  for re-register.

* Removed unnecessary dependencies krb5-user, msktutil, python-psutil
  for waptserver package.

* Increase client_max_body_size for http post on nginx
  for large update/ upgrade trigger

  * fix signature_clockskew waptserver config parameter not taken in account

  * unified loggers for server

  * have waptserver ask wapt client to update status using websockets
    if websocket connection is up but database is not aware of given SID
    (case where waptserver is restarted but Nginx is kept up,
    and restart of waptserver service is fast enough
    to not trigger a reconnection of the clients);

* [FIX] Disable proxy for migrate-hosts;

Known issues
++++++++++++

* waptservice: if a system account level http proxy is defined in registry
  on the windows host, websocket client library tries to use it and fails
  to connect to the server. Workaround: make an exception for waptserver;

* waptconsole: if a http proxy is defined in :file:`waptconsole.ini`,
  section ``[global]``, key *http_proxy*, it is used by the waptconsole
  even if setting *use_proxy_for_xxx* is False Workround: set *http_proxy*
  to an empty string in :file:`waptconsole.ini`;

* when using a not self-signed personal certificate, depending of th issuer,
  the certificate file :file:`<private_dir>\mine_cert.crt` can contain
  the full chain (own certificate, intermediate CA, and root CA).
  When waptconsole asks if the certificate should be put in authorized
  client certificate directory (:file:`<wapt-dir>\ssl`), the full :file:`crt`
  file is copied as this.
  This means that all certificates in :file:`crt` file are authorized,
  and not only the personal one. This is perhaps not desired;

  Workaround: check if the personal pem encoded :file:`crt` file contains
  the full certificates chain. If this is the case, copy in
  :file:`<wapt-dir>\ssl` only the parts of the PEM file matching
  the certificates you want to trust;

* SNI is not properly handled by waptconsole code, leading to incorrect
  error about certificate validation on https server with virtual hosts;

* Certificates CRL updates (periodical signature, ...) must be managed manually
  using tools like easy-rsa. Only CRL accessible by a URL are supported;

* proxies are not supported on the server, so
  :abbr:`CRL (Certificate Revocation List)` can not be updated properly
  (as far as Distribution Point is defined in certificates)
  if the server has no direct http access to the distribution points;

* https certificates are verified on the clients using the bundle defined
  by the *verify_cert* ini settings. If this setting is simply *True*,
  the bundle supplied with python libraries is used to check issuers.
  This bundle is not updated unless WAPT is upgraded, so new issuers or
  no more trusted issuers are taken in account only at this point.
  So it is better to deploy your own CA bundle along with wapt
  and define the *verify_cert* path.

* for 1.5.1.18 rc1, on the linux server, there are broken symbolic links
  in lib/python2.7 folder. Next rc does not exhibit this problem;

WAPT-1.5.1.14 (2018-01-09)
--------------------------

* [NEW] Historize in *wapt_localstatus* PostgreSQL table the dependencies
  and conflicts of installed packages (to provide an easy way to warn when
  conflicting package will be installed or should be removed);

* [FIX] load fill certificate chain from host packages to check :file:`control`
  (as it is the case for other types of packages);

* [SECURITY] regression: check host package control signature
  right after downloading (it is checked too when starting install);

* [FIX] regression: don't install host package if version is lower
  than installed one;

* [FIX] don't raise an exception during session-setup if package
  has no :file:`setup.py`;

WAPT Client
+++++++++++

* [FIX] intermediate CA pinning:
  Allow to deploy intermediate CA as authorized package CA
  without root CA (segragation of rules between entities);

* [FIX] old style print statement (without parentheses)
  raising an error in *setup-session*
  or *uninstall* :program:`setup.py` functions;

setuphelpers/ libraries
+++++++++++++++++++++++

* [UPD] Add *cache_dir* parameter to :program:`wget` function;

* [UPD] renamed *cabundle* parameter to *trusted_bundle*;

* [NEW] Add python methods to create certificate from CSR;

WAPT Console
++++++++++++

* Add checkbox in create waptagent to sign with sha1 in addition to sha256
  for old wapt client upgrades;

* Force host package version to be at least equal to already installed
  host package (when host package is deleted, version was starting again at 0);

* [FIX] regression: check existing host package signature before editing it;

WAPT Server
+++++++++++

* [FIX] Force waptserver DB structure upgrade at each server startup;

* [UPD] Add *db_connect_timeout* parameter for pool of
  waptserver DB connections;

* [NEW] Store *depends* and *conflicts* attributes in waptserver
  *HostPackagesStatus* PotsgreSQL table;

Known issues
++++++++++++

* SNI is not properly handled by waptconsole code, leading to
  incorrect error about certificate validation
  on https server with virtual hosts;

* Certificates CRL updates (periodical signature, ...) must be managed manually
  using tools like easy-rsa. Only CRL accessible by a URL are supported;

WAPT-1.5.1.13 (2018-01-03)
--------------------------

* Quelques fallback pour permettre l'utilisation de la console WAPT sous Wine

* Ebauche architecture plugins dans waptconsole.

* Interface GUI pour entrer les mots de passe dans PyScripter

* Action make-template dans installeur crée un paquet vide

* Inclusion de la chaine de certificats du signataire dans le paquet
  au lieu du seul certificat final

* IMPROVE: gestion des certificats signés par une autorité intermédiaire
  pour les actions de la console Wapt

* Ajout option pour spécifier fichier de configuration pour waptconsole.

* [FIX] SNI pour la récupération de la chaine de certificats dans waptconsole.

* [ADD] added actions to launch mass updates/ upgrades, offer updates
  to the users (WAPT Enterprise);

* :kbd:`F5` rafraîchit la liste des paquets

* Changement à distance de la description de l'ordinateur

* Possibilité de configurer plusieurs instances de serveurs Wapt
  sur un serveur/ VM.

* chunked http upload pour pouvoir uploader des gros paquets
  sans passer par du scp.

* Ajout installation forcée d'un paquet sur un poste dans la console.

* Ajout option pour masquer les actions avancées
  (simplication affichage console)

* CN du Certificat / clé machine sont nommés comme l'UUID.

* Si une ou plusieurs dépendances d'un paquet ne peuvent pas être installées,
  le paquet parent n'est pas installé et est marqué en erreur.

* Memory leak sur le serveur

* Gestion timezone pour validité de certificats

* [SECURITY] prend tous les fichiers en compte dans la vérification des hashes,
  pas seulement ceux dans le répertoire racine (régression apparue en 1.5
  mais non présente en 1.3)

WAPT-1.5.1.5 (2017-11-16)
-------------------------

Architecture globale
++++++++++++++++++++

* [NEW] the host packages are now named with the BIOS :term:`UUID`
  of the machine instead of the :term:`FQDN` (it is possible to use
  the FQDN as the UUID with the parameter *use_fqdn_as_uuid*
  but it may create duplicates in the console);

* le service :program:`waptservice` écoute sur l'adresse de loopback,
  port 8088 et non plus sur toutes les interfaces.
  Cela réduit la surface d'attaque potentielle
  si un attaquant spoofe l'adresse IP du serveur WAPT;

* le service :program:`waptservice` crée au démarrage
  une connexion Websockets (Socket.IO) vers le serveur pour permettre
  à la console de déclencher les Update/ Upgrade /
  Install/ Remove ; On ne pass plus par le port 8088 du service;

* [NEW] the Websocket requests from the WAPT console to the WAPT agents are now
  signed with the key of the :term:`Administrator`. Before, security relied on
  source IP restriction and the validation
  of the Administrator's login/ password;

* la base de données d'inventaire est maintenant une base PostgreSQL
  en remplacement de MongoDB.
  Cela facilite le requêtage pour un reporting personnalisé, le langage SQL
  étant mieux connu des administrateurs système;

* l'affichage dans la console d'un grand nombre de machines a été amélioré.
  L'affichage de plusieurs milliers de machines n'est plus un problème;

* modifier la configuration d'un grand nombre de machines
  a été rendu largement plus performant;

* la reprise d'un téléchargement partiel de paquet est
  maintenant possible (interruption lors de l'arrêt ...);

* les clés privées doivent maintenant obligatoirement être protégées
  avec un mot de passe;

Console WAPT
++++++++++++

* passage en Websockets;

* gestion des écrans de haute résolution (ex: écrans 4k);

* modernisation des jeux d'icônes dans la console;

* changement à la volée de la description du poste;

* option pour changer le mot de passe d'une clé;

Format des paquets
++++++++++++++++++

* la présence du fichier :file:`setup.py` est optionnelle (plus particulièrement,
  il n'est pas nécessaire pour les paquets groupes et machines
  qui ne contiennent que des dépendances);

* [NEW] if the package contains a :file:`setup.py` file, it MUST be signed with a
  **Code Signing** certificate, otherwise the package WILL NOT be installed. The
  roles are now differenciated between the role of the :term:`Package Deployer`
  (allowed to sign group and host packages) and the role of :term:`Package
  Developer` (allowed to sign group, host AND base packages);

* lors de la signature du paquet, le certificat du signataire est ajouté
  dans le paquet (:file:`WAPT/certificate.crt`);

* le fichier :file:`manifest` est renommé :file:`manifest.sha256` au lieu de
  :file:`manifest.sha1` et :file:`signature.sha256` au lieu de :file:`signature`;

* ajout des attributs suivants au fichier :file:`control`:

  * *signed_attributes*: pour la fiabilité de la vérification

  * *min_wapt_version*:  le paquet est ignoré (et ne s'installe pas)
    si wapt n'est pas au moins à cette version

  * *installed_size*: le paquet ne s'installe pas s'il n'y a pas au moins
    cet espace disponible sur le disque système

  * *max_os_version*: le paquet est ignoré si Windows
    a une version supérieure à cet attribut

  * *min_os_version*: le paquet est ignoré si Windows
    a une version inférieure à cet attribut

  * *maturity*:

  * *locale*:

Configuration générale des agents
+++++++++++++++++++++++++++++++++

* section explicite ``[wapt-host]`` pour le dépôt des paquets machines
  sinon l'url est déduite de  <repo_url>+'-host';

* section explicite ``[wapt]`` pour le dépôt principal,
  sinon <repo_url> est pris en compte;

* vérification des certificats activée par défaut
  pour toutes les connexions https;

* signature avec du sha256 au lieu de sha1;

* prise en compte de paquets signés avec des certificats délivrés
  par une autorité, déploiement uniquement du certificat de l'autorité;

* utilisation de l'UUID du client pour le nom des paquets machine
  au lieu du FQDN;

* possibilité d'utiliser le FQDN comme UUID au lieu de l'UUID du Bios.
  (paramètre *use_fqdn_as_uuid*) (ou uuid forcé: paramètre *forced_uuid*);

* lorsqu'on signe, on désigne le signataire par son certificat et
  non sa clé privée. La clé privée est recherchée par wapt
  dans le même répertoire que le certificat personnel.
  On incite à avoir un certificat par personne agissant sur WAPT;

* possibilité de prendre en compte la révocation de certificats
  (la CRL est fournie aux poste lors de l'update, dans le fichier Packages);

* re-signature possible sous Linux avec
  la commande :program:`wapt-signpackage.py`;

* installation dans :file:`Program Files(x86)` par défaut;

setuphelpers
++++++++++++

* *running_as_admin*, *running_as_system*;

* correctif sur :command:`add_shutdown_script`;

* ajout paramètre *remove_old_version* pour :command:`install_msi_if_needed` et
  :command:`install_exe_if_needed`;

wapt-get
++++++++

* ajout fonction :command:`update-package-sources` qui lance
  la fonction optionnelle :command:`update_package()` du paquet;

* remplacement de l'option *--private-key* par l'option *--certificate*
  pour désigner le certificat à utiliser pour signer le paquet.
  La clé privée est recherchée dans le même répertoire que le certificat;

* remplacement du fichier :file:`WAPT/wapt.psproj` à chaque édition d'un paquet
  (pour mettre à jour le chemin vers les modules WAPT suivant l'installation
  dans :file:`C:\\wapt` ou :file:`C:\\Program Files (x86)\\wapt`);

* vérification du certificat serveur lors du :command:`enable-check-certificate`
  pour éviter de mauvaises configurations;

wapt-signpackages
+++++++++++++++++

* ajout options

.. code-block:: bash

  --if-needed
  --message-digest
  --scan-packages
  --message-digest

.. code-block:: bash

  Usage: wapt-signpackages -c crtfile package1 package2

  Re-sign a list of packages

  Options:
    -h, --help            show this help message and exit
    -c PUBLIC_KEY, --certificate=PUBLIC_KEY
                          Path to the PEM RSA certificate to embed identitiy in
                          control. (default: )
    -k PRIVATE_KEY, --private-key=PRIVATE_KEY
                          Path to the PEM RSA private key to sign packages.
                          (default: )
    -l LOGLEVEL, --loglevel=LOGLEVEL
                          Loglevel (default: warning)
    -i, --if-needed       Re-sign package only if needed (default: warning)
    -m MD, --message-digest=MD
                          Message digest type for signatures.  (default: sha256)
    -s, --scan-packages   Rescan packages and update local Packages index after
                          signing.  (default: False)

Console WAPT
++++++++++++

* [NEW] all actions sent to the hosts are signed with the Administrator's key;

* [NEW] generation of a key / certificate pair signed by
  a Certificate Authority (WAPT Enterprise);

* option de créer un certificat **Code Signing** ou non (version Enterprise);

* option pour changer le mot de passe d'une clé RSA;

* option de vérification des certificats lors de la
  création du :program:`waptagent`;

* lancement TISHelp (version Enterprise);

* limitation du nombre de machines retournées dans la console;

* ajout filtre :guilabel:`reachable` =  poste connecté au serveur WAPT;

* possibilité de changer la description du poste

waptserver
++++++++++

* authentification sur une base LDAP (version Enterprise);

* utilisation des Websockets pour les actions;

waptservice
+++++++++++

* le Webservice http de :program:`waptservice` écoute uniquement
  sur la loopback 127.0.0.1 (donc plus de vérification si port 8088
  ouvert sur firewall..);

* le :program:`waptservice` se connecte en websocket au serveur WAPT
  si le paramètre *waptserver* est présent dans :file:`wapt-get.ini`;

* le paramètre *websockets_verify_cert* active la vérification SSL du certificat
  pour la connexion websockets;

* affichage de liste des certificats / CA autorisés pour les paquets;

* affichage signataire paquet;

* [NEW] *allow_user_service_restart* parameter allows a standard user to restart
  the WAPT service on her computer;

* lancement de :program:`tishelp` en mode service par URL /tishelp;

Installeur waptagent
++++++++++++++++++++

* suppression installation :program:`msvcrt`;

* restent uniquement 2 options: installer le service et lancer
  :guilabel:`wapttray`;

* options pour une installation silencieuse:
    * *dnsdomain* pour la recherche auto wapt et waptserver
    * *wapt_server*
    * *repo_url*

* :program:`waptupgrade` fait systématiquement une installation complète
  (pas d'installation incrémentale);

Improvements 1.5.0.12-amo -> 1.5.0.16
++++++++++++++++++++++++++++++++++++++

* :file:`setup.py` pas obligatoire pour uninstall;

* chemin unicode pour édition de paquets;

* corrigé la recherche de dépots en s'appuyant sur les DNS;

* corrigé \\0000 pour PostgreSQL;

* introduit une option pour avoir une double signature sha1 et sha256;

* vérification https pour upload :program:`waptagent`;

* option *--if-needed* dans :command:`wapt-signpackages`;

* fix proxy dans import paquets;

* gestion des révocations de certificats (CRL);

* fix attributs requis dans signature actions;

* *max_clients*;

* fix option sans serveur (:program:`waptstarter`);

* ajout lancement :program:`tishelp`;

* force update à l'installation;

WAPT-1.4.0 (2017-05-05)
-----------------------

* pas de release officielle;

* [NEW] migration sur la base PostgreSQL à la place de MongoDB;

WAPT-1.3.13 (2017-07-25)
------------------------

Security fix
++++++++++++

* régression: Package files content check was skipped if signature of :file:`manifest`
  and :file:`Packages` index file checksum was ok. This regression affects all 1.3.12 releases,
  but not WAPT <= 1.3.9 and >= upcoming 1.5. In order to exploit this bug,
  one would need to tamper the :file:`Packages` files either through a MITM
  (if you do not have valid https certificate check) or a root access on the WAPT server.

Other changes
+++++++++++++

* compatibility with packages signed with upcoming WAPT 1.5.
  With WAPT 1.5, package are signed with sha256 hashes. An option allows to sign
  them with sha1 too so that they can be used with WAPT 1.3 without signing them again.

* new package certificate for Tranquil IT packages.
  previous certificate for package on store.wapt.fr has expired.
  all packages on store.wapt.fr has been signed again with new key / certificate
  with both sha1 and sha256 hashes, and WAPT 1.5 signature style
  (control data is signed as well as files)

* fix for local GPO add_shutdown_script() function (thanks jf-guillou!)

* fix for :program:`waptsetup.exe` postinstall actions (:command:`update` / :command:`register`)
  when running :program:`waptsetup.exe` installer without elevated priviledges: added *runascurrentuser* flag

* remove needless python libraries to make install package slimmer

WAPT 1.3.12.13 (2017-06-26)
---------------------------

Console WAPT
++++++++++++

* [NEW] Assistant de création de paquets à partir d'un fichier :file:`MSI` ou d'un :file:`Exe`;

* [NEW] Option dans le menu :guilabel:`Outils` ou par drag drop dans l'onglet dépôt privé;

* [NEW] Découverte des options silencieuses;

* [NEW] Utilisation des fonctions :command:`install_exe_if_needed` et :command:`install_msi_if_needed`
  au lieu d'un simple :command:`run()` pour les exes et les MSI
  (plusieurs templates de :file:`setup.py` dans :file:`C:\\wapt\\templates`);

* [NEW] Amélioration significative de la vitesse de modification en masse des paquets machines;

* [NEW] Vérification optionnelle de la signature des paquets que l'on importe d'un dépôt extérieur.
  La liste des certificats autorisés se trouve par défaut dans :file:`%APPDATA%\\waptconsole\\ssl`
  et peut-être précisée dans les paramètres de la :program:`waptconsole`.
  Le paramètre ini se nomme *authorized_certs_dir*. Sinon, les certificats autorisés
  sont ceux dans :file:`C:\\wapt\\ssl`;

* [NEW] Vérification optionnelle du certificat https pour les dépôts extérieurs dans la console;

* [NEW] Vérification de la signature des paquets machines, groupes et logiciels
  avant leur modification dans la console ou dans :program:`PyScripter`;

* [NEW] Lors de l'import d'un dépôt extérieur, possibilité d'éditer le paquet
  pour inspection plutôt que de le charger directement sur le dépôt de production;

* [NEW] Changement des URL relatives à la documentation. https://www.wapt.fr/en/doc/;

* [NEW] Possibilité d'actualiser le certificat sans recréer la paire de clés RSA
  (en particulier pour préciser un Common Name correct, qui apparaît comme le signataire des paquets);

* [NEW] HTTPS par défaut pour les URL de dépot.

Autres correctifs
+++++++++++++++++

* [FIX]  Paramètre *AppNoConsole:1* pour NSSM (:program:`waptservice` / :program:`waptserver`)
  pour permettre le fonctionnement sur Windows 10 Creators Updates;

* [FIX]  Problème de fichier Zip qui restent verrouillés si une erreur est déclenchée;

* [FIX]  Suppression répertoire temporaire lors de l'annulation d'édition d'un groupe;

* [FIX]  Gestion espace dans les fichiers de projet PyScripter;

* [FIX]  Gestion utf8 / unicode pour certaines fonctions;

* [FIX]  Fix gestion encoding quand :command:`run_not_fatal()` renvoie une errreur;

* [FIX]  remplacement librairie mongo.bson par json natif de python ,

* [FIX]  bug dans la synchro des groupes AD avec les paquets WAPT;

* [FIX]  bug "La clé privée n'existe pas" la première fois qu'elle est renseignée
  si on ne redémarre pas la console;

* [FIX]  bug "redémarrage service wapt" (merci à QGull);

* [FIX]  possibilité d'avoir des majuscules dans les noms de paquet
  (toutefois pas recommandé, les noms des paquets sont sensibles à la casse);

* [FIX]  quelques actualisation des exemples de configuration :file:`wapt-get.ini.tmpl`

* [FIX]  la compilation du :program:`waptagent` échoue si les clés / certificats
  existent déjà mais que le certificat a été supprimé de :file:`C:\\wapt\\ssl`;

* [FIX]  affichage dans la barre des tâches de la fenêtre de login
  (pour permettre en particulier l'autofill par des gestionnaires de mot de passe);

WAPT 1.3.9.3 (2017-04-11)
--------------------------

* [FIX] Argument *shell* = *True* was not explicitly passed to the underlying
  function as it occurred on previous versions.

WAPT 1.3.9 (2017-03-03)
------------------------

Fixes
+++++

* [FIX] update code to follow more PEP8 recommandations;

* [FIX] upgradedb locks sqlite database issue;

* [FIX] Fix broken DNS SRV record discovery;

* [FIX] Fix unicode handling of signer / CN / organisation in certificates;

* [FIX] Unzipped netifaces module;

wapt-get
++++++++

* [NEW] Expands wildcards args for :command:`install`, :command:`show`,
  :command:`build-package`, :command:`sign-package`;

* [FIX] Fix :command:`show-params` wapt-get command;

* [FIX] Fix :command:`register` with description not working on some computers;

* [FIX] Fix broken *-c* *--config* option;

Added setuphelpers functions
++++++++++++++++++++++++++++

* [NEW] :command:`reg_key_exists`;

* [NEW] :command:`reg_value_exists`;

* [NEW] :command:`run_powershell`;

* [NEW] :command:`remove_metroapp`;

* [NEW] :command:`local_users_profiles`;

* [NEW] :command:`get_profiles_users`;

* [NEW] :command:`get_last_logged_on_user`;

* [NEW] :command:`get_user_from_sid`;

* [NEW] :command:`get_profile_path`;

* [NEW] :command:`wua_agent_version`;

* [NEW] :command:`local_admins`;

* [NEW] :command:`local_group_memberships`;

* [NEW] :command:`local_group_members`;

Modified helpers
++++++++++++++++

* [IMP] command:`run`: explicit default values for :command:`run` command help in :program:`PyScripter`.
  Added *return_stderr argument* (overloaded str object);

* [FIX] :command:`run_notfatal`: fix unicode issue in use wmi module for :command:`wmi_info_basic`
  instead of :command:`wmic` shell command;

* [IMP] :command:`make_path`: improved when first argument is a drive.
  Be smart if an argument is a callable;

* [FIX] :command:`CalledProcessError`: restored command:`CalledProcessError` alias;

* [ADD] :command:`host_infos`: added *profiles_users*, *last_logged_on_user*,
  *local_administrators*, *wua_agent_version* attributes;

* [IMP] :command:`ensure_unicode`: return None if None, for bytes strings,
  try utf8 decoding before system locale decoding;

Console WAPT
++++++++++++

* [FIX] restore allowed lowercase/uppercase package naming;

* [ADD] 4 host popup menu actions:

    * :guilabel:`Computer Mgmt`;
    * :guilabel:`Computer Users`;
    * :guilabel:`Computer Services`;
    * :guilabel:`RemoteAssist`;

* [FIX] fixed other issues in the WAPT console:

    * Don't search host while typing;
    * utf8 search (accents...);
    * utf8 compare;
    * try to get localized versions of special folders;

Setup
+++++

* [ADD] :program:`waptpythonw.exe` binary in distribution for console less python scripts
  (to avoid having :program:`cmd.exe` windows poping up when invoking a python script);

* [FIX] change default wapt templates URL to https://store.wapt.fr/wapt;

* [FIX] when upgrading, (full :program:`waptagent.exe` install) remove stalled
  :program:`waptagent.exe` installs;

WAPT 1.3.8.2 (2016-11-18)
--------------------------

Security
++++++++

* [SEC] Fix inheritance of rights on wapt root folder for Windows 10 during setup
  when installed in :file:`C:\\wapt`. On Windows 10, :program:`cacls.exe` does not work
  and does not remove "Authenticated Users" from :file:`C:\\wapt`.
  :program:`cacls.exe` has been replaced by :program:`icacls.exe`:

    * on pre-wapt 1.3.7 systems, you can fix this by running the following command,
      or upgrade to wapt 1.3.8 (you may check :code:`icacls.exe c:\wapt /inheritance:r`)
    * This can be achieved with a GPO, or a wapt package

* [IMP] in next versions of WAPT, the default install path of wapt will be changed
  from root folder :file:`C:\\wapt` to a more standard :file:`C:\\Program Files (x86)\\wapt`.

* [IMP] By default, :program:`waptsetup.exe` / :program:`waptsetup-tis.exe` do not
  distribute certificates to avoid to deploy directly packages from Tranquil IT.
  :program:`waptagent.exe` by default distributes the certificates that are installed
  on the mangement desktop creating the :program:`waptagent`.

Core changes
++++++++++++

* [IMP] The database structure has changed between 1.3.8 and 1.3.8.2 to include
  additional attributes from packages: *signer*, *signer_fingerprint*, *locale*, and *maturity*.
  *signer* and *signer_fingerprint* are populated when signing the package to identify the origin.
  This means local WAPT database is upgraded when first starting WAPT 1.3.8.2
  and this is not backward compatible;

* [IMP] Installers have a limited set of options, the most common use of WAPT is priviledged;

* [ADD] 3 new parameters for the :program:`waptexit` policy behaviour: *hiberboot_enabled*,
  *max_gpo_script_wait*, *pre_shutdown_timeout*. These parameters are not set by default
  and should be added to :file:`wapt-get.ini` *[global]* section if needed;

* [IMP] Use user's :file:`waptconsole.ini` configuration file instead of :file:`wapt-get.ini`
  for the commands targeted to package development (*sources*, *make-template*,
  *make-host-template*, *make-group-template*, *build-package*, *sign-package*,
  *build-upload*, *duplicate*, *edit*, *edit-host*, *upload-package*, *update-packages*.
  This avoids the need to write these parameters in :file:`wapt-get.ini` on the development workstation.
  These parameters are not shared across multiple users on same machine.
  One use case is to allow multiple profiles (key, upload location)
  depending on the maturity of package (development, test, production...);

Setuphelpers
++++++++++++

* [ADD] helper functions :command:`dir_is_empty`, :command:`file_is_locked`,
  :command:`service_restart` and :program:`WindowsVersions` class
* [IMP] Added referer and *user_agent* in :program:`wget` and :program:`wgets`
* [IMP] run function: define stdin as PIPE to avoid lockup process waiting for input
  or error like unable to duplicate handle when using for example powershell
* [IMP] Version class: try to compare version using at least Version.members_count
* [FIX] encoding fixes for registry functions, fix encoding for registry_setstring key name
* [FIX] :command:`install_exe_if_needed`: don't check uninstall_key or min_version if not provided
* [FIX] :command:`install_exe_if_needed` and :command:`install_msi_if_needed`
  version check if *--force*
* [UPD] Check version and uninstall key after install with :command:`install_exe_if_needed`
  and :command:`install_msi_if_needed`
* [UPD] inventory includes informations from WMI.Win32_OperatingSystem
* [ADD] :command:`get_disk_free_space` helper function
* [UPD] check free disk space when downloading with :program:`wget`. check http status before.
* [UPD] Version class: Version('7')<Version('7.1') should return True

wapt-get
++++++++

* [ADD] 2 commands to get server SSL certificate and activate the certificate checking
  when using https with waptserver
* [FIX] :command:`get_sources` to allow svn checkout of a new package project
* [FIX] :command:`register` problems with some BIOS with bitmaps
* [UPD] Check uninstall key after package install if uninstallkey is provided
* [FIX] added compatibility OS in :file:`manifest` file for :program:`wapt-get`
  and :program:`waptconsole` version windows
* [FIX] erroneous error messages for :command:`session-setup` in the WAPT console
* [UPD] add "pattern" parameter to all_files function
* [FIX] Install Date incorrectly registered by :command:`register_uninstall`
* [ADD] :command:`user_local_appdata` function
* [ADD] add the *signer* CN and *signer_fingerprint*
  to :file:`control` file when building package
* [ADD] add control attributes *min_wapt_version* to trigger an exception
  if :file:`Package` requires a minimum level of libraries. The version is checked
  againts :program:`setuphelpers.py` 's __version__ attribute.
* [ADD] *authorized_certificates* attribute is sent to the WAPT server.
  It contains the list of host's signer certificates distributed on the host
* [FIX] When signing, check if WAPT zip file has already a :file:`signature` file.
  (python zipfile can not replace the file inline)

waptservice
+++++++++++

* [ADD] Show :guilabel:`All Versions` checkbox in :guilabel:`Available Packages` page
* [UPD] Skin updated
* [ADD] :guilabel:`Filter` searchbox for available packages

waptconsole
+++++++++++

* [ADD] Add :guilabel:`NOT` checkbox for keywords search in :program:`waptconsole`
  to search for hosts NOT having a specific package or software...
* [FIX] fix integer limit for grid display of package size, use int64
  for size of packages in :program:`waptconsole`.
* [UPD] don't list packages of section "restricted" in local webservice available packages list
* [UPD] *Common Name* attribute should be populated now, so that signer identity
  is not None in package :file:`control` file.
* [ADD] signer's identity column in packages grid
* [FIX] escape quotes in package's description
* [ADD] Check :program:`waptagent.exe` version against :program:`waptsetup-tis` version
  at :program:`waptconsole` startup.
* [UPD] try to display a :guilabel:`progress` dialog at :program:`waptconsole` startup
* [FIX] company not set when building customized :program:`waptagent.exe`
* [ADD] initialize Organization in :program:`waptagent.exe` build with CN from certificate.

waptexit
++++++++

* [UPD] some text introduction changes

waptray
+++++++

* [NEW] Limit trayicon balloon popup when Windows version is above Windows 7
  or if *notify_user* = *0* in :file:`wapt-get.ini`

waptserver
++++++++++

* [UPD] Use broadcast address on interface for wakeonlan call
* [FIX] remove the check of wapt server password which prevents
  the proper registration of :program:`waptserver` on Windows.
* [UPD] when upgrading, reuse existing :file:`waptserver.ini` file if it already exists,
  don't overwrite server_uuid and ask for password reset if it already exists

waptdeploy waptupgrade
++++++++++++++++++++++

* [FIX] :program:`waptdeploy` not working on WinXP removed
  DisableWow64FileSystemRedir on :command:`runtask`.
* [FIX] :program:`waptupgrade`: Missing quotes for system account on Windows XP

Libraries
+++++++++

* [ADD] BeautifulSoup for wapt packages auto updates tasks
* [UPD] :program:`winsys` library update to '1.0b1'

WAPT 1.2.3.2 (2015-05-05)
-------------------------

* [ADD] :term:`UUID` parameter for direct requests to hosts from the WAPT Server;
* [ADD] allow host to refuse request if not right target (if ip has changed
  since last :command:`update_status` for example)
* [ADD] fallback on waptserver usage_statictics if mongodb lacks aggregate support
* [IMP] register host on server in postconf using :program:`waptservice` http
  instead of command line :program:`wapt-get`

WAPT 1.2.2 (2015-04-22)
-------------------------

* [ADD] :command:`reset-uuid` and :command:`generate-uuid` for
  https://roundup.tranquil.it/wapt/issue421 duplicated :term:`UUID` issues
* [IMP] mass hosts delete, added delete hosts package action. server >=1.2.2 only:
  https://roundup.tranquil.it/wapt/issue433
* [ADD] read the docs theme for sphinx setuphelpers API documentation. WIP
  https://roundup.tranquil.it/wapt/issue427
* [IMP] doc updates
* [ADD] api/v1/hosts_delete method
* [ADD] :command:`need_install`, :command:`install_exe_if_needed`,
  :command:`install_msi_if_needed` functions to setuphelpers
* [ADD] parameters for :program:`waptdeploy`.

WAPT 1.2.1 (2015-03-26)
-------------------------

Console WAPT
++++++++++++

* [ADD] combobox for filtering on groups in :program:`waptconsole`.
* [ADD] :guilabel:`Add ADS Groups as packages` action to WAPT host selection popup menu
* [ADD] :command:`cleancache` action to clean local waptconsole packages cache
* [ADD] added :command:`notify_server` on network reconfiguration if :program:`waptserver` is available;
* [IMP] column :guilabel:`groups` shows only host's direct dependencies with package's
  section == "group" instead of all direct dependencies.
* [ADD] optional anonymous statistics (nb of machines, nb of packages, age of updates...)
  sent to Tranquil IT to document the communication around WAPT
  (sent by :program:`waptconsole` at most every 24h)
* [IMP] improved mass hosts delete,
* [ADD] delete hosts package action. server >=1.2.2 only: https://roundup.tranquil.it/wapt/issue433
* [IMP] big packages uploads (write uploaded packages by chunk)
  (but still some issues on 32bits servers due to :program:`uwsgi`)
* [IMP] display version of mismatch when editing package
* [FIX] host's packages not saved when some dependencies don't exist anymore
* [FIX] restore working :guilabel:`Cancel running task` button
* [FIX] canceling subprocesses not working in freepascal apps
  (when waiting for :program:`InnoSetup` compile for example)

wapt-get / waptservice
++++++++++++++++++++++

* [ADD] :command:`reset-uuid` and :command:`generate-uuid` for
  https://roundup.tranquil.it/wapt/issue421 duplicated :term:`UUID` issues
* [IMP] :command:`find_wapt_repo_url` processus to avoid waiting for all repos
  if one repo is ok (improved response time in buggy networks)
* [IMP] windows DNS resolver in wapt client (python part) instead of pure python resolver.
  Should reduce issues when multiple network cards or inactive network connections.
* [IMP] changed priority of server discovery using SRV dns records.
  -> first priority ascending and weight descending. -> comply with standards.
* [FIX] solved some issues with :program:`SQLite` and threads in local :program:`waptservice`
* [IMP] explicit transaction handling and *isolation_level* = *None* for local waptDB (to try to avoid locks)
* [IMP] teardown handler for :program:`waptservice` to commit or rollback thread local connections
* [FIX] for waptrepo detection in freepascal parts: same processus as python part.
* [FIX] for :command:`edit_package` when supplying a wapt filename instead of package request

Setuphelpers
++++++++++++

* [ADD] read the docs theme for sphinx setuphelpers API documentation.
  WIP https://roundup.tranquil.it/wapt/issue427
* [ADD] _all_ list to avoid importing unecessary names in :program:`setup.py` modules.
  Now only functions defined in :program:`setuphelpers` are available when importing :program:`setuphelpers`.
  This can break some WAPT packages if names were indirectly imported through :program:`setuphelpers` module.
* [ADD] :command:`need_install`, :command:`install_exe_if_needed`,
  :command:`install_msi_if_needed` functions to :program:`setuphelpers`
* [ADD] :command:`local_desktops` function
* [FIX] version class instances accept to be compared to str
* [REM] :command:`processnames_list` which is unused in :program:`setuphelpers`
* [ADD] :command:`add_ads_groups` and :command:`get_computer_groups` to :program:`waptdevutils.py`
* [FIX] :command:`run` helper
* [FIX] on_write callback not working
* [FIX] TimeoutExpired not formatted properly
* [FIX] use closure for registry keys

Waptdeploy
++++++++++

* [IMP] :program:`waptdeploy` with more command line options
  (in particular tasks to merge to default innosetup selected tasks)
* [FIX] waptrepo detection using dns records

Install
+++++++

* [FIX] :program:`waptagent` upload error on windows
* [FIX] debian packages should work for Jessie
* [IMP] :command:`copytree2` for :program:`waptupgrade`
* [FIX] trap exception for version check on copy of :file:`exe` and :file:`dll`
* [FIX] :program:`mongodb-server` version should be >= 2.4

WAPT-1.1.1 (2015-02-26)
-----------------------

Console WAPT
++++++++++++

* [IMP] the loading of the main grid has been optimized; only configured coumns are displayed;
* [IMP] the WAPT server detects the hosts whose :program:`waptservice` is listening.
  Their :guilabel:`Reachable` status is shown with a green / grey indicator;
* [IMP] the WAPT package to upgrade WAPT on hosts (???-waptupgrade.wapt) is generated by the WAPT console
  at the same time as the WAPT agent installer (:program:`waptagent.exe`),
  the two files are then uploaded on the WAPT server;
* [ADD] the package dependencies of each host are displayed in the grid. This allows to see what hosts have no package;
* [ADD] possibility to trigger available package upgrades on hosts that are listening from the WAPT console.
  In that case, the host sends its status to the WAPT server after the upgrade;
* [ADD] possibility to filter hosts in the WAPT console according to their upgrade status
  or whether they are "reachable" or not,
* [ADD] when packages are flagged for install but are not yet installed on a host,
  they appear with a blue "+" indicator. It is then possible to force the immediate install
  of the package with a right-click;

Waptservice
+++++++++++

* [ADD] cleaning of the cache on the hosts after each successful upgrade;

Watpserver
++++++++++

* [ADD] the versions of the WAPT agent, WAPT Server are shown in the main web page
  of the WAPT Server (with a red indicator if there is a problem);

Packaging
+++++++++

* [ADD] functions to :program:`setuphelpers` to manage shortcuts:

  * :command:`remove_desktop_shortcut`;
  * :command:`remove_user_desktop_shortcut`;
  * :command:`remove_programs_menu_shortcut`;
  * :command:`remove_user_programs_menu_shortcut`;

Installation
++++++++++++

* [IMP] verification of used ports during the post-configuration of WAPT Server on a Windows machine;

Webservices
+++++++++++

* [IMP] the :program:`waptserver` no longer listen on 8080 port by default.

    The Apache frontal web server listens in HTTP and HTTPS and relays action calls
    to the python :program:`waptservice` that only listens locally.

    It is therefore necessary to update :file:`wapt-get.ini` files on WAPT agents and to replace
    *wapt_server* = http://srvwapt.mydomain.lan:8080 with *wapt_server* = https://srvwapt.mydomain.lan

    If you can not make that change to your WAPT agents, it is possible to return
    to the previous behavior.

    On Debian, edit the file :file:`/opt/wapt/waptserver/waptserver.ini`, and in the ``[uwsgi]`` section, put:

    .. code-block:: bash

        http-socket = 0.0.0.0:8080

    On Windows, edit :file:`C:\\wapt\waptserver\\waptserver.ini` and replace:

    .. code-block:: bash

        server = Rocket(('127.0.0.1', port), 'wsgi', {"wsgi_app":app})

    with:

    .. code-block:: bash

        server = Rocket(('0.0.0.0', port), 'wsgi', {"wsgi_app":app})

    The repository may stay in HTTP on port 80.

    The calls to the WAPT Server are authenticated, but it is advized to restrict
    access to authorized sub-networks with a firewall.

* [IMP] json calls to the webservice of the WAPT Server are now standardized;

* [IMP] when launching command:`update` / command:`upgrade` / command:`remove`
  / command:`forget` / command:`tasks_status` actions from the WAPT console,
  the IP address of the host is no longer sent, but instead its :term:`UUID`,
  and it is the WAPT Server that finds the IP address and the port to use;
  et c'est le serveur wapt qui s'occupe de déterminer quelle IP / port utiliser;

* [ADD] verification in the WAPT console that the version of the WAPT Server is sufficient;

* [ADD] the timeout to connect to WAPT agents and read the data are configurable in :file:`waptserver.ini`;

WAPT-1.0 (2015-01-31)
-----------------------

* [ADD] first public version of WAPT
