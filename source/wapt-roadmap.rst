.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^


.. _wapt_roadmap:

History and roadmap
===================

WAPT 0.8 Community (novembre 2013)
----------------------------------

* cleaning and stabilisation of console code;

* transfer of :program:`waptservice` local service from
  :program:`Lazarus` to :program:`Python`;

* addition of firewall rules to allow access to :program:`waptservice`
  from :program:`waptserver`;

* display wapt package update status in wapt console;

* possibility to import packages from TIS repository and adding
  them to local repository;

* build system embryo;

* after :program:`waptsetup` customization build in :program:`waptconsole`,
  possibility to upload it directly from :program:`waptconsole`;

WAPT 0.9 Community (septembre 2014)
-----------------------------------

* Windows :program:`waptserver` packaging;

* Windows postconfiguration tool to ease server installation;

* transition to https for all connexions;

* possibility to ask remote package removal;

* improving error feedbacks;

* display package description when selecting in the WAPT console;

* host identification through computer account thanks to Kerberos
  (inactive by default);

* waptselfservice group to delegates installation group;

* possibility to push :program:`waptagent` installation on a host
  through MS-RPC (if firewall allows it);

WAPT 1.0 Community (févier 2015)
--------------------------------

The release of that milestone has been announced at `Bruxelles FOSDEM
the 1st of February 2015 <https://fosdem.org/2015/schedule/event/wapt_apt_get_for_windows/>`_.

* internationalization of the console, service,
  server and notification messages;

* scenari documentation;

* addition of icon for packages for a better rendering on wapt
  website store.wapt.fr;

* windows installer improvements to avoid conflicts during installation
  (open ports check, etc.);

* bug correction with obscure network specificities;

* :program:`builbot` continuous building process;

WAPT 1.1 Community (février 2015)
---------------------------------

* several bugs and anomalies have been corrected on 1.0.0 version
  thanks to feedback from users;

* display of reachability of hosts in the WAPT console;

WAPT 1.3 et 1.5 Community (2016-2017)
-------------------------------------

* integration of the authentication of local service in Windows Active Directory
  or Samba-AD;

* adding of a integrated agent building wizard in the WAPT console;

* role segregation between :term:`Package Developers`
  and :term:`Package Deployers`;

* replacement of :program:`MongoDB` by :program:`PostgreSQL`
  with JSON extension;

* Websockets implementation;

* host identification through a shared secret for workgroup hosts
  that cannot access MSAD or Samba-AD domain;

WAPT 1.5 Enterprise (début 2018)
--------------------------------

The features and functionalities described in the section
are only relevant to the **Enterprise** version of WAPT.

* management by Organisational Units (Machine OU);

* taking into account of the Certificate Authority for signing packages,
  in addition to individual certificates;

* kerberos based SSO authentication of :term:`Administrators`
  in the WAPT console;

WAPT 1.6 (August 2018)
----------------------

* recurring audit function to insure configurations
  are maintained over time (**Enterprise**);

* (tech preview) Windows Update management in WAPT, reproducing
  WSUS functionnalities (**Enterprise**);

* authentication by certificate of the WAPT client when accessing
  a repository or connecting to the WAPT Server (inventory, websockets);

WAPT 1.7
--------

* customizable WAPT reporting integrated
  within the WAPT console (**Enterprise**);

* discrimination between user self-service packages and restricted packages
  that may be installed only by :term:`Administrators` (**Enterprise**);

* global updates according to the package's criticity level (**Enterprise**);

  * immediate upgrade for critical updates;

  * with the user accepting the upgrade if it impacts
    the user's current activities;

* software and configuration management using AD Organizational Units
  (*unit* packages) (**Enterprise**);


WAPT 1.8
--------

* Client agent for Linux Debian, Linux CentOS, Ubuntu and Apple macOS

* Built-in WAPT packages repository replication

* Built-in repository selection rules


Later
-----

* creation of the :abbr:`GPO (Group Policy Object)`
  for deploying the WAPT agent directly from the WAPT console (**Enterprise**);

* signature of packages and actions, and token based authentication
  on the WAPT console (**Enterprise**);

* integration of inventory in GLPI and other asset management
  tools (**Community** and **Enterprise**);

* asset management from the WAPT console (**Enterprise**);

* kerberos based SSO authentication of the :term:`Users`
  on the :program:`webservice` (**Enterprise**);

* creation of *stub* packages to avoid licensing problems
  for some proprietary software. The :term:`Package Developer` would download
  the package from a trusted public repository, then he would download
  the software binaries from the editor's website to obtain a complete package.
  This will facilitate the creation of packages embedding software
  with restricted distribution rights (**Enterprise**);
