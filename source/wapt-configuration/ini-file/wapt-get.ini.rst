.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
   :description: Configuring the WAPT agent
   :keywords: wapt-get.ini, configuration, documentation, WAPT

.. _wapt-get-ini:

Configuring the WAPT agent
==========================

The configuration file :file:`C:\\Program Files(x86)\\wapt\\wapt-get.ini`
defines the behavior of the WAPT agent.

The ``[global]`` section is required:

.. code-block:: ini

    [global]

Description of available options for the WAPT agent
---------------------------------------------------

.. note::

    * if ``repo_url`` and ``wapt_server`` fields are empty, the WAPT agent
      will look for a repository using SRV records in the ``dnsdomain`` zone;

    * if there is no ``wapt_server`` attribute in the ``[global]`` section,
      no WAPT Server will be used;

    * if there is no ``repo_url`` attribute in the ``[global]`` section,
      a repository in the ``[wapt]`` section will have to be explicitly defined;

    * it will have to be enabled by adding it to the ``repositories``
      attribute to the ``[global]`` section;

.. tabularcolumns:: |\\X{5}{12}|\\X{7}{12}|

================================================================= ==============================================================================================================================================
Options                                                           Description
================================================================= ==============================================================================================================================================
``repo_url`` = https://srvwapt.mydomain.lan/wapt                  If the field is left empty, the WAPT agent will make a :term:`DNS`
                                                                  query on the :term:`SRV` field ``_wapt._tcp.<dnsdomain>`` to find
                                                                  the repository (the ``dnsdomain`` attribute must be configured).

``wapt_server`` = https://srvwapt.mydomain.lan                    If the attribute is left empty, the WAPT agent will make a
                                                                  :term:`DNS` :term:`SRV` query on the ``_waptserver._tcp.<dnsdomain>``
                                                                  field (the ``dnsdomain`` attribute must be configured)

``dnsdomain`` = mydomain.lan                                      DNS suffix to use for auto-discovery of the WAPT Server and
                                                                  repositories with :term:`SRV` / :term:`CNAME field` DNS queries.

``use_hostpackages`` = 1                                          Use host packages (default 1).

``waptupdate_task_period`` = 120                                  Update frequency (120 minutes by default).

``waptupgrade_task_period`` = 360                                 Upgrade frequency (disabled by default)

``waptservice_user`` = admin                                      Identifier used by the WAPT service when executing actions.

``waptservice_password`` = 5e884898da                             sha256 hashed password when the WAPT service is used locally from
                                                                  a command prompt (NOPASSWORD disables the requirement for a password)

``waptservice_port`` = 8088                                       WAPT agent loopback port. It is not accessible from the network.

``dbdir`` = :file:`C:\\Program Files(x86)\\wapt\\db`              Folder where the database :file:`waptdb.sqlite` file will be stored.

``loglevel`` = warning                                            Log level of the WAPT agent. Possible values are: ``debug``,
                                                                  ``info``, ``warning``, ``critical``.

``maturities`` = PROD                                             List of packages maturities than can be viewed and installed by
                                                                  WAPT Agent. Default value is ``PROD``. Any value can be used.

``use_fqdn_as_uuid`` = 1                                          Allows you to use the fqdn name rather than the uuid BIOS as the unique machine identifier in wapt.

``waptaudit_task_period`` = 120                                   Define the frequency where the agent checks if he has audits to perform.

``locales`` = en                                                  Allows you to set the list of wapt agent languages to modify the list of packages visible by wapt (for package filtering). You
                                                                  can add multiple language (eg. ``locales=fr,en``) in order of preference.

``host_profiles`` = tis-firefox,tis-java                          Allows you to define a wapt package list that the wapt agent must install.

``language`` = en                                                 Force default langauge for GUI (not for package filtering)

``host_organizational_unit_dn`` = OU=TOTO,OU=TEST,DC=DEMO,DC=LAN  Allows you to force an Organizational Unit on the WAPT agent. (Convenient to assign a fake OU for out-of-domain PC)

================================================================= ==============================================================================================================================================

.. _wapt-get-ini-waptserver:
.. _wapt-get-ini-kerberos:

WAPT Server configuration attributes
------------------------------------

These options will set WAPT agent behavior when connecting to WAPT Server.

.. tabularcolumns:: |\\X{5}{12}|\\X{7}{12}|

=============================================================================================== ========================================================================================
Options                                                                      					Description
=============================================================================================== ========================================================================================
``wapt_server`` =                                                            					WAPT Server URL. If the attribute is not present, no WAPT Server will be contacted.
                                                                             					If the attribute is empty, a DNS query will be triggered to find the WAPT Server
                                                                             					using the ``dnsdomain`` attribute for the DNS zone.

``dnsdomain`` =                                                              					DNS zone on which the DNS SRV ``_waptserver._tcp`` is searched.

``wapt_server_timeout`` = 10                                                 					WAPT Server HTTPS connection timeout in seconds

``use_kerberos`` = 1                                                         					Use Kerberos authentication for initial registration on the WAPT Server.

``verify_cert`` = :file:`C:\\Program Files (x86)\\wapt\\ssl\\server\\srvwapt.mydomain.lan.crt`  See the documentation on activating the
 																								:ref:`verification of HTTPS certificates <activating_HTTPS_certificate_verification>`

``public_certs_dir`` = :file:`C:\\Program Files (x86)\\wapt\\ssl`            					Folder of certificates authorized to verify the signature of WAPT packages,
                                                                             					by default, ``<wapt_base_dir>\\ssl``. Only files in this directory with
                                                                             					:file:`.crt` or :file:`.pem` extension are taken into account. There may be
                                                                             					several X509 certificates in each file. Authorized packages in WAPT are those
                                                                             					whose signature may be verified by one of the certificates contained in the
                                                                             					PEM files of this directory. Each repository may have its own folder of
                                                                             					authorized certificates.
=============================================================================================== ========================================================================================

.. _wapt-get-ini-repositories:

Using several repositories
--------------------------

There can be more sections in the :file:`wapt-get.ini` file
to define more repositories.

* ``[wapt]``: main repository. Relavent attributes: ``repo_url``,
  ``verify_cert``, ``dnsdomain``, ``http_proxy``, ``use_http_proxy_for_repo``,
  ``timeout``. If this section does not exist, parameters are read
  from the ``[global]`` section;

* ``[wapt-template]``: external remote repository that will be used in the WAPT
  console for importing new or updated packages;

* ``[wapt-host]``: repository for host packages. If this section
  does not exist, default locations will be used on the main repository;

More information on that usage can be found here: :ref:`work_multiple_repos`.

.. note::

  Active repositories are listed in the ``repositories`` attribute
  of the ``[global]`` section.

.. tabularcolumns:: |\\X{5}{12}|\\X{7}{12}|

================================== ============================================================================
Options                            Description
================================== ============================================================================
``repositories`` = repo1, repo2    List of enabled repositories, separated by a comma. Each value defines a
                                   section of the :file:`wapt-get.ini` file. In each section, it is possible
                                   to define ``repo_url``, ``dnsdomain``, ``public_certs_dir``, ``http_proxy``.
================================== ============================================================================

.. note::

  This parameter can be configured both in the WAPT agent configuration
  and in the WAPT console configuration file
  :file:`C:\\Users\\%username%\\AppData\\Local\\waptconsole\\waptconsole.ini`.

  For information on configuring the WAPT console,
  please refer to :ref:`this documentation <waptconsole_ini_file>`.

.. _waptexit_ini_file:

Settings for waptexit
---------------------

.. tabularcolumns:: |\\X{5}{12}|\\X{7}{12}|

================================ ====================================================================
Options                          Description
================================ ====================================================================
``allow_cancel_upgrade`` = 1     Prevents users from canceling package upgrades on computer shutdown
``pre_shutdown_timeout`` = 180   Timeout for scripts at computer shutdown
``max_gpo_script_wait`` = 180    Timeout for GPO execution at computer shutdown
``hiberboot_enabled`` = 0        Disables Hiberboot on Windows 10 to make ``waptexit`` work correctly
================================ ====================================================================

.. _waptself_ini_file:

Settings for WAPT Self-Service
------------------------------

===================================== ====================================================================
Options                               Description
===================================== ====================================================================
``waptservice_admin_filter`` = True   Apply Self-Service package view filtering for local admins
===================================== ====================================================================


Settings for wapttray
---------------------

.. tabularcolumns:: |\\X{5}{12}|\\X{7}{12}|

================================ ========================================================
Options                          Description
================================ ========================================================
``notify_user`` = 0              Prevents ``wapttray`` from sending notifications (popup)
================================ ========================================================

Proxy settings
--------------

.. tabularcolumns:: |\\X{5}{12}|\\X{7}{12}|

================================================ ==============================================
Options                                          Description
================================================ ==============================================
``http_proxy`` = http://user:pwd@host_fqdn:port  HTTP proxy address
``use_http_proxy_for_repo`` = 0                  Using the proxy to access the repositories
``use_http_proxy_for_server`` = 0                Use a proxy to access the WAPT Server
``use_http_proxy_for_templates`` = 0             Use a proxy to access package template server.
================================================ ==============================================

Settings for creating packages
------------------------------

.. tabularcolumns:: |\\X{5}{12}|\\X{7}{12}|

============================================================ ==================================================
Options                                                      Description
============================================================ ==================================================
``personal_certificate_path`` = C:\\private\\org-coder.crt   Path to the Administrator's private key
``default_sources_root`` = C:\\waptdev                       Directory for storing packages in development
``default_sources_root_host`` = C:\\waptdev\\hosts           Directory for storing host packages in development
``default_package_prefix`` = tis                             Default prefix for new or imported packages
``default_sources_suffix`` = wapt                            Default prefix for new or imported packages
============================================================ ==================================================

Settings for ``WAPT Windows Updates``
-------------------------------------

Refer to :ref:`this article on configuring WAPTWUA on the WAPT agent <wapt_wua_agent>`.

Overriding settings of *upload* functions
-----------------------------------------

It's possible to override :command:`upload` commands to define
a particular behavior when uploading packages. It's possible for example
to upload packages on several repositories, or via another protocol, etc.

To upload packages on the repository
(:command:`wapt-get upload-package` or :command:`build-upload`), use:

.. code-block:: ini

  upload_cmd="C:\\Program Files (x86)\\WinSCP\\WinSCP.exe" admin@srvwapt.mydomain.lan /upload %(waptfile)s

To upload host-packages on the repository (:command:`upload-package`
or :command:`build-upload` of a host package), use:

.. code-block:: ini

    upload_cmd_host="C:\\Program Files (x86)"\\putty\\pscp -v -l admin %(waptfile)s srvwapt.mydomain.lan:/var/www/wapt-host/

To launch a command after a package :command:`upload`, use:

.. code-block:: ini

    after_upload="C:\\Program Files (x86)"\\putty\\plink -v -l admin srvwapt.mydomain.lan "python /var/www/wapt/wapt-scanpackages.py /var/www/%(waptdir)s/"

Configuration of WAPT agents
----------------------------

After standard installation, the default configuration is:

.. code-block:: ini

     [global]
     waptupdate_task_period=120
     waptserver=https://srvwapt.mydomain.lan
     repo_url=https://srvwapt.mydomain.lan/wapt/
     use_hostpackages=1

Making changes in :file:`wapt-get.ini` and regenerating an agent
is not sufficient to push the new configuration.

You can create a WAPT package to push updated :file:`wapt-get.ini` settings.

The package is available from the Tranquil IT repository:
https://store.wapt.fr/store/details-tis-wapt-conf-policy_6_all.wapt:

.. code-block:: python

  # -*- coding: utf-8 -*-
  from setuphelpers import *

  uninstallkey = []

  def install():

    print('Modify max_gpo_script_wait')
    inifile_writestring(WAPT.config_filename,'global','max_gpo_script_wait',180)

    print('Modify Preshutdowntimeout')
    inifile_writestring(WAPT.config_filename,'global','pre_shutdown_timeout',180)

    print('Disable Hyberboot')
    inifile_writestring(WAPT.config_filename,'global','hiberboot_enabled',0)

    print('Disable Notify User')
    inifile_writestring(WAPT.config_filename,'global','notify_user',0)
