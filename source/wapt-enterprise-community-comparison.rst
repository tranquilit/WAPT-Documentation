.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
    :description: Comparing features between the WAPT Enterprise and Community versions
    :keywords: WAPT, Enterprise, Community, summary, compare

.. |date| date::

.. |ok| image:: ./ok.png
  :scale: 10%
  :alt: feature available

.. |nok| image:: ./nok.png
  :scale: 10%
  :alt: feature not available

.. |visa_secu| image:: ./visasecu_2017_logo-fr.png
  :scale: 20%
  :alt: French Security Visa

.. |apple| image:: ./apple.png
  :scale: 20%
  :alt: Apple logo

.. |windows| image:: ./windows.png
  :scale: 20%
  :alt: Windows logo

.. |linux_debian| image:: ./debian.png
  :scale: 20%
  :alt: Debian logo

.. |linux_ubuntu| image:: ./ubuntu.png
  :scale: 20%
  :alt: Ubuntu logo

.. |linux_redhat| image:: ./redhat.png
  :scale: 20%
  :alt: Red Hat / CentOS logo

.. |linux_suse| image:: ./suse.png
  :scale: 20%
  :alt: Suse logo

.. _community_enterprise_comparison:

Comparing features between the WAPT Enterprise and Community versions
=====================================================================

Current feature list as of |date|
---------------------------------

.. list-table::
  :header-rows: 1
  :widths: 80 10 10

  * - Feature
    - Enterprise
    - Community
  * - **Deploy, update and remove software** on hosts running
      |windows| |linux_debian| |linux_ubuntu| |linux_redhat| |apple| |linux_suse|
    - |ok|
    - |ok|
  * - Deploy and update **configurations in SYSTEM context**
    - |ok|
    - |ok|
  * - Deploy and update **configurations in USER context**
    - |ok|
    - |ok|
  * - Get a **comprehensive inventory** of hardware, software
      and applied WAPT packages
    - |ok|
    - |ok|
  * - Benefit from the **differenciated self-service** (authorized users
      may install authorized software from authorized WAPT package stores)
    - |ok|
    - |nok|
  * - Benefit from **simplified Windows Updates** that work much better
      than a standard WSUS (only the required KBs are dowloaded from Microsoft)
    - |ok|
    - |nok|
  * - Simplify and structure your administrative workload by applying
      WAPT packages to an :abbr:`OU (Organisational Unit)`
    - |ok|
    - |nok|
  * - Configure and manage easily WAPT **store relays to preserve bandwidth**
      in multi-site environments
    - |ok|
    - |nok|
  * - Get access to **ready-to-deploy WAPT packages**
      for common free-to-use software
    - |ok|
    - |ok|
  * - Work with **easily verifiable python recipes** for installing, updating
      and removing software and configuration, recipes may embedd Powershell code
      or scripts made with other languages (ex: for personalizing a software
      using a LDAP directory)
    - |ok|
    - |ok|
  * - Benefit from **hundreds of Helpers** for simplifying
      your software packaging
    - |ok| [#f1]_
    - |ok|
  * - **Encrypt your sensitive data** for transport (software license keys,
      login, password, server FQDN, API informations for registering software
      with the vendor, etc)
    - |ok|
    - |nok|
  * - Automate the auditing of your configurations
      for an **easy, automated and always up-to-date compliance**
    - |ok|
    - |nok|
  * - Benefit from the power of SQL integrated with the WAPT console to make
      **the reports that you need for your daily sysadmin work
      or that your organisational requires for budgeting decisions**
    - |ok|
    - |nok|
  * - Authenticate your WAPT Administrator against an **Active Directory
      or LDAP**
    - |ok|
    - |nok| [#f2]_
  * - Benefit from differenciated roles between software packagers
      and package deployers so you can **delegate your WAPT powers
      to the most adequate people** (packagers know security implications,
      deployers know user needs)
    - |ok|
    - |nok|
  * - Licensed under
    - GPLv3
    - Proprietary
  * - Verified and approved by national cybersecurity agency |visa_secu|,
      **WAPT is the only deployment software in the world with this level
      of certification**
    - |ok|
    - |nok|
  * - Professional phone support with Tranquil IT
    - |ok| [#f3]_
    - |nok|

Features coming soon
--------------------

.. list-table::
  :header-rows: 1
  :widths: 80 10 10

  * - Feature
    - Enterprise
    - Community
  * - Multi-tenant, multi-client mode with :abbr:`ACL (Access Control Lists)`
      for :abbr:`MSPs (Managed Service Providers)` and large multi-departmental
      or international organisations using an internal
      :abbr:`PKI (Public Key Infrastructure)` based mecanism
    - |ok|
    - |nok|
  * - Simple to use screensharing for user support, built with the same level
      of security and privacy as WAPT
    - |ok|
    - |nok|
  * - History of actions done via WAPT for a complete reporting
      of a host`s software maintenance lifecycle
    - |ok|
    - |nok|
  * - Authentication of WAPT Administrators using
      cryptographic tokens (ex: smartcards)
    - |ok|
    - |nok|
  * - Access to ready-to-deploy WAPT packages or recipes
      for licensed business software (common business software for industry,
      medical, office, public collectivities, cybersecurity, etc)
    - |ok|
    - |nok|
  * - Access to ready-to-deploy WAPT package extensions
      for simplifying desktop armoring using Applocker or equivalent
    - |ok|
    - |nok|
  * - **Continued support for Windows XP** in WAPT for factory machine tools,
      Hospital medical equipment, expensive research instruments, etc
    - |ok| [#f4]_
    - |nok|
  * - Operating system image deployment tool integrated within WAPT
    - |ok|
    - |nok|
  * - Integration of useful subset of WAPT inventory
      with popular :abbr:`ITSM (IT Service Management)` tools
      and triggering of actions from the users ITSM console
    - |ok|
    - |nok|

Summary of operating principles in WAPT
---------------------------------------

* WAPT is agent based to allow no inbound open port in hosts` firewalls
  that initiate a secured bi-directional websocket with the server
  for allowing real-time reporting and actions;

* Can work with Trusted Data Gateways using simple task scheduling;

* Works on the principle of smoothly pulling updates and then applying upgrades
  at convenient time (works with low / intermittent bandwidth,
  high latency, high jitter);

* Does not require an AD (works with Windows Home edition too),
  but will show the host in its Active Directory tree if the host
  is joined to an AD;

* Methods for deploying WAPT agent:

  #. using a :abbr:`GPO (Group Policy Object)` or an Ansible script;

  #. manually after having downloaded the agent from the WAPT server or using :abbr:`SSH (Secured Shell)`;

* Methods for registering hosts with the WAPT server:

  #. automatically using the host`s kerberos account;

  #. manually with the WAPT Superadmin login and password;

* Upgrades may be triggered:

  #. upon shutdown of the host, the standard mode;

  #. by an authorized WAPT Administrator in an emergency (ex: critical vulnerabilities running in the wild);

  #. by the user at a time she chooses (ex: 24/7 nursing cart unused during lunch break with a simple click);

  #. via a scheduled task running at a predetermined time (best for servers);

- Security is insured with:

  #. signing of WAPT packages using asymetric cryptography;

  #. authentication of hosts against the WAPT server using symetric cryptography on registering;

  #. confidentiality of the WAPT server using WAPT deployed client certificates;

.. rubric:: Footnotes

.. [#f1] The Enterprise version embeds more SetupHelper functions
  than the Community version.

.. [#f2] In the Community version, the WAPT SuperAdmin password is shared
  between individuals that manage the WAPT server.

.. [#f3] A minimal volume of licences must be subscribed in order to benefit
  from Tranquil IT's telephone support for the daily operation of the software.
  Additional paid support is available to help you with your WAPT packaging needs.

.. [#f4] Windows XP does not work with Python > 2.7. So a special branch of WAPT
  will be frozen with the last build of the WAPT agent running with 2.7.
  This version of the agent will of course be excluded from the target
  of evaluation in future security certifications.
