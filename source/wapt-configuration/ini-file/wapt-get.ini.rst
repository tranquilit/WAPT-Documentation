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

.. list-table:: Description of available options for the WAPT agent
  :header-rows: 1
  :widths: 40 60

  * - Options
    - Description
  * - ``repo_url`` = https://srvwapt.mydomain.lan/wapt
    - If the field is left empty, the WAPT agent will make a :term:`DNS`
      query on the :term:`SRV` field ``_wapt._tcp.<dnsdomain>`` to find
      the repository (the ``dnsdomain`` attribute must be configured).
  * - ``wapt_server`` = https://srvwapt.mydomain.lan
    - If the attribute is left empty, the WAPT agent will make a
      :term:`DNS` :term:`SRV` query on the ``_waptserver._tcp.<dnsdomain>``
      field (the ``dnsdomain`` attribute must be configured).
  * - ``dnsdomain`` = mydomain.lan
    - DNS suffix to use for auto-discovery of the WAPT Server and
      repositories with :term:`SRV` / :term:`CNAME field` DNS queries.
  * - ``use_hostpackages`` = 1
    - Use host packages (default 1).
  * - ``waptupdate_task_period`` = 120
    - Update frequency (120 minutes by default).
  * - ``waptupgrade_task_period`` = 360
    - Upgrade frequency (disabled by default)
  * - ``waptservice_port`` = 8088
    - WAPT agent loopback port. It is not accessible from the network.
  * - ``dbdir`` = :file:`C:\\Program Files(x86)\\wapt\\db`
    - Folder where the database :file:`waptdb.sqlite` file will be stored.
  * - ``loglevel`` = warning
    - Log level of the WAPT agent. Possible values are: ``debug``,
      ``info``, ``warning``, ``critical``.
  * - ``maturities`` = PROD
    - List of packages maturities than can be viewed and installed by
      WAPT Agent. Default value is ``PROD``. Any value can be used.
  * - ``use_fqdn_as_uuid`` = 1
    - Allows you to use the fqdn name rather than the uuid BIOS
      as the unique machine identifier in wapt.
  * - ``waptaudit_task_period`` = 120
    - Define the frequency where the agent checks if he has audits to perform.
  * - ``locales`` = en
    - Allows you to set the list of wapt agent languages to modify the list
      of packages visible by wapt (for package filtering).
      You can add multiple language (eg. ``locales=fr,en``)
      in order of preference.
  * - ``host_profiles`` = tis-firefox,tis-java
    - Allows you to define a wapt package list that the wapt agent must install.
  * - ``language`` = en
    - Force default langauge for GUI (not for package filtering)
  * - ``host_organizational_unit_dn`` = OU=TOTO,OU=TEST,DC=DEMO,DC=LAN
    - Allows you to force an Organizational Unit on the WAPT agent.
      (Convenient to assign a fake OU for out-of-domain PC)
  * - ``download_after_update_with_waptupdate_task_period`` = True
    - Define whether a download of pending packages should be started
      after an update with waptupdate_task_period
  * - ``log_to_windows_events`` = False
    - Send the log wapt in the window events

.. _wapt-get-ini-waptserver:
.. _wapt-get-ini-kerberos:

WAPT Server configuration attributes
------------------------------------

These options will set WAPT agent behavior when connecting to WAPT Server.

.. list-table:: Description of available options for the WAPT Server
  :header-rows: 1
  :widths: 40 60

  * - Options
    - Description
  * - ``wapt_server`` =
    - WAPT Server URL. If the attribute is not present, no WAPT Server will be contacted.
      If the attribute is empty, a DNS query will be triggered
      to find the WAPT Server using the ``dnsdomain`` attribute for the DNS zone.
  * - ``dnsdomain`` =
    - DNS zone on which the DNS SRV ``_waptserver._tcp`` is searched.
  * - ``wapt_server_timeout`` = 10
    - WAPT Server HTTPS connection timeout in seconds
  * - ``use_kerberos`` = 1
    - Use Kerberos authentication for initial registration on the WAPT Server.
  * - ``verify_cert`` = C:\\Program Files (x86)\\wapt\\ssl\\server\\srvwapt.mydomain.lan.crt
    - See the documentation on activating the :ref:`verification
      of HTTPS certificates <activating_HTTPS_certificate_verification>`
  * - ``public_certs_dir`` = :file:`C:\\Program Files (x86)\\wapt\\ssl`
    - Folder of certificates authorized to verify the signature of WAPT packages,
      by default, ``<wapt_base_dir>\\ssl``. Only files in this directory with
      :mimetype:`.crt` or :mimetype:`.pem` extension are taken into account.
      There may be several X509 certificates in each file.
      Authorized packages in WAPT are those whose signature may be verified
      by one of the certificates contained in the PEM files of this directory.
      Each repository may have its own folder of authorized certificates.

.. _wapt-get-ini-repositories:

Using several repositories
--------------------------

There can be more sections in the :file:`wapt-get.ini` file
to define more repositories:

* ``[wapt]``: main repository. Relevent attributes: ``repo_url``,
  ``verify_cert``, ``dnsdomain``, ``http_proxy``, ``use_http_proxy_for_repo``,
  ``timeout``. If this section does not exist, parameters are read
  from the ``[global]`` section;

* ``[wapt-template]``: external remote repository that will be used in the WAPT
  console for importing new or updated packages;

* ``[wapt-host]``: repository for host packages. If this section
  does not exist, default locations will be used on the main repository;

More information on that usage can be found in :ref:`this article on working
with multiple public or private repositories <work_multiple_repos>`.

.. note::

  Active repositories are listed in the ``repositories`` attribute
  of the ``[global]`` section.

.. list-table:: Description of available options for repositories
  :header-rows: 1
  :widths: 40 60

  * - Options
    - Description
  * - ``repositories`` = repo1, repo2
    - List of enabled repositories, separated by a comma. Each value defines a
      section of the :file:`wapt-get.ini` file. In each section, it is possible
      to define ``repo_url``, ``dnsdomain``, ``public_certs_dir``,
      ``http_proxy``.

.. note::

  This parameter can be configured both in the WAPT agent configuration
  and in the WAPT console configuration file
  :file:`C:\\Users\\%username%\\AppData\\Local\\waptconsole\\waptconsole.ini`.

  For information on configuring the WAPT console,
  please refer to :ref:`this documentation <waptconsole_ini_file>`.

.. _waptexit_ini_file:

Settings for waptexit
---------------------

.. list-table:: Description of available options for WAPTexit
  :header-rows: 1
  :widths: 40 60

  * - Options
    - Description
  * - ``allow_cancel_upgrade`` = 1
    - Prevents users from canceling package upgrades on computer shutdown.
  * - ``pre_shutdown_timeout`` = 180
    - Timeout for scripts at computer shutdown.
  * - ``max_gpo_script_wait`` = 180
    - Timeout for GPO execution at computer shutdown.
  * - ``hiberboot_enabled`` = 0
    - Disables Hiberboot on Windows 10 to make :program:`waptexit`
      work correctly.

.. _waptself_ini_file:

Settings for WAPT Self-Service and Waptservice Authentification
---------------------------------------------------------------

.. list-table:: Description of available options for the WAPT Self-Service
  and Waptservice Authentification
  :header-rows: 1
  :widths: 40 60

  * - Options
    - Description
  * - ``waptservice_admin_filter`` = True
    - Apply *selfservice package* view filtering for Local Administrators.
  * - ``service_auth_type`` = system
    - Defines the authentication system of the wapt service,
      available value are *system*, *waptserver-ldap*, *waptagent-ldap*.
  * - ``ldap_auth_ssl_enabled`` = False
    - Useful with *waptagent-ldap*, defines if the LDAP request must be encrypted.
  * - ``verify_cert_ldap`` = True
    - Useful with *waptagent-ldap*, define whether the certificate
      should be verified.
  * - ``ldap_auth_base_dn`` = dc=domain,dc=lan
    - Useful with *waptagent-ldap*, defines the base dn for the LDAP request.
  * - ``ldap_auth_server`` = srvads.domain.lan
    - Useful with *waptagent-ldap*, defines the LDAP server to contact.
  * - ``waptservice_user`` = admin
    - Forces a user to authenticate on the WAPT service.
  * - ``waptservice_password`` = 5e884898da
    - sha256 hashed password when *waptservice_user* is used
      (the value *NOPASSWORD* disables the requirement for a password).

Settings for wapttray
---------------------

.. list-table:: Description of available options for the WAPT tray
  :header-rows: 1
  :widths: 40 60

  * - Options
    - Description
  * - ``notify_user`` = 0
    - Prevents ``wapttray`` from sending notifications (popup).

Proxy settings
--------------

.. list-table:: Description of available options for the WAPT Server
  :header-rows: 1
  :widths: 40 60

  * - Options
    - Description
  * - ``http_proxy`` = http://user:pwd@host_fqdn:port
    - HTTP proxy address
  * - ``use_http_proxy_for_repo`` = 0
    - Use the proxy to access the repositories.
  * - ``use_http_proxy_for_server`` = 0
    - Use a proxy to access the WAPT Server.
  * - ``use_http_proxy_for_templates`` = 0
    - Use a proxy to access package template server.

Settings for creating packages
------------------------------

.. list-table:: Description of available options for creating WAPT packages
  :header-rows: 1
  :widths: 40 60

  * - Options
    - Description
  * - ``personal_certificate_path`` = C:\\private\\org-coder.crt
    - Path to the Administrator's private key.
  * - ``default_sources_root`` = C:\\waptdev
    - Directory for storing packages in development.
  * - ``default_sources_root_host`` = C:\\waptdev\\hosts
    - Directory for storing host packages in development.
  * - ``default_package_prefix`` = tis
    - Default prefix for new or imported packages.
  * - ``default_sources_suffix`` = wapt
    - Default prefix for new or imported packages.

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
https://store.wapt.fr/wapt/tis-wapt-conf-policy_6_f913e7abc2f223c3e243cc7b7f95caa5.wapt:

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
