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
  :scale: 12.5%
  :alt: feature available

.. |nok| image:: ./nok.png
  :scale: 12.5%
  :alt: feature not available

.. |visa_secu| image:: ./visasecu_2017_logo-fr.png
  :scale: 12.5%
  :alt: French Security Visa

.. |apple| image:: ./apple.jpg
  :scale: 12.5%
  :alt: Apple logo

.. |windows| image:: ./windows.jpg
  :scale: 12.5%
  :alt: Windows logo

.. |linux_debian| image:: ./debian.png
  :scale: 12.5%
  :alt: Debian / Ubuntu logo

.. |linux_redhat| image:: ./redhat.png
  :scale: 12.5%
  :alt: Red Hat / CentOS logo

.. _community_enterprise_comparison:

Comparing features between the WAPT Enterprise and Community versions
=====================================================================

.. list-table::
  :header-rows: 1

  * - Feature available as of |date|
    - Community
    - Enterprise
  * - Deploy, update and remove software
      |windows| |linux_debian| |linux_redhat| |apple|
    - |ok|
    - |ok|
  * - Deploy and update configurations in SYSTEM context
    - |ok|
    - |ok|
  * - Deploy and update configurations in USER context
    - |ok|
    - |ok|
  * - Comprehensive Inventory of hardware, software and applied WAPT packages
    - |ok|
    - |ok|
  * - Differenciated self-service (authorized users may install authrorized
      software from authorized WAPT package stores)
    - |ok|
    - |nok|
  * - Simplified Windows Updates that work much better than a standard WSUS
      (only the required KBs are dowloaded from Microsoft)
    - |ok|
    - |nok|
  * - Applying WAPT packages to an :abbr:'OU (Organisational Unit)'
    - |ok|
    - |nok|
  * - Simple to configure and manage WAPT store relays to preserve bandwidth
      in multi-site environments
    - |ok|
    - |nok|
  * - Access to ready-to-deploy WAPT packages for common free-to-use software
    - |ok|
    - |ok|
  * - Easily verifiable python recipes for installing, updating
      and removing software and configuration, recipes may embedd Powershell code
      or scripts made with other languages (ex: for personalizing a software
      using a LDAP directory)
    - |ok|
    - |ok|
  * - Helpers for simplifying software packaging
    - |ok| [#f1]_
    - |ok|
  * - Sensitive data may be encrypted for transport (software license keys,
      login, password, server FQDN, API informations for registering software
      with the vendor, etc)
    - |ok|
    - |nok|
  * - Configuration compliance may be audited over time
    - |ok|
    - |nok|
  * - Simple to use SQL reporting integrated with the WAPT console
    - |ok|
    - |nok|
  * - WAPT Administrator authentication using an Active Directory or LDAP
    - |ok|
    - |nok| [#f2]_
  * - Differenciated roles between software packagers and package deployers
      (first know security implications, the second know user needs)
    - |ok|
    - |nok|
  * - Licensed under
    - GPLv3
    - Proprietary
  * - Verified and approved by national cybersecurity agency |visa_secu|
    - |ok|
    - |nok|
  * - Professional phone support with Tranquil IT
    - |ok|
    - |nok|

.. list-table::
  :header-rows: 1

  * - Feature coming soon
    - Community
    - Enterprise
  * - Multi-tenant, multi-client mode with :abbr:'ACL (Access Control Lists)'
      for :abbr:'MSPs (Managed Service Providers)' and large multi-departmental
      or international organisations using an internal
      :abbr:'PKI (Public Key Infrastructure)' based mecanism
    - |ok|
    - |nok|
  * - Simple to use screensharing for user support, built with the same level
      of security and privacy as WAPT
    - |ok|
    - |nok|
  * - History of actions done via WAPT for a complete reporting
      of a host's software maintenance lifecycle
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

Summary of operating principle in WAPT
--------------------------------------

* Agent based to allow no inbound open port in hosts' firewalls
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
  * using a :abbr:'GPO (Group Policy Object)' or an Ansible script;
  * manually after having downloaded the agent from the WAPT server
    or using :abbr:'SSH (Secured Shell)';

* Methods for registering hosts with the WAPT server
  * automatically using the host's kerberos account;
  * manually with the WAPT Superadmin login and password;

* Upgrades may be triggered:
  * upon shutdown of the host, the standard mode;
  * by an authorized WAPT Administrator in an emergency;
    (ex: critical vulnerabilities running in the wild);
  * by the user at a time she chooses (ex: 24/7 nursing cart unused;
    during lunch break with a simple click);
  * via a scheduled task running at a predetermined time (best for servers);

* Security is insured with:
  * signing of WAPT packages using asymetric cryptography
  * authentication of hosts against the WAPT server using symetric cryptography on registering
  * confidentiality of the WAPT server using WAPT deployed client certificates

.. rubric:: Footnotes

.. [#f1] The Enterprise version embedds more SetupHelper functions
  than the Community version.

.. [#f2] In the Community version, the WAPT SuperAdmin password is shared
  between individuals that manage the WAPT server.
