.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
    :description: Glossary
    :keywords: Administrator, Local Administrateur, Package Deployer,
               Package Developer, ANSSI, DNS, FQDN, GPO, MMC, IDE,
               Setuphelpers, UUID

.. _glossary:

Glossary
========

.. glossary::

  Administrator
  Administrators
  Package Developer
  Package Developers
    In WAPT, an **Administrator** is a person with a **Code Signing**
    certificate that can sign packages, whether or not they contain
    python code or binary files, and upload the packages to the main repository.

  Local Administrator
  Local Administrators
    A **Local Administrator** is a person with administrative rights
    on computers managed with WAPT.

  Package Deployer
  Package Deployers
    A **Package Deployer** is a person that can create and sign WAPT packages
    that do not contain python code or binaries, eg. *host* and *group*
    packages, and upload them to the repository. They are typically members
    of local IT teams that have knowledge of specific user needs to be satisfied
    by deploying WAPT packages built by central IT teams.

  SuperAdmin
    The **SuperAdmin** is a :term:`User` whose login and password are set during
    the post-configuration of the WAPT Server. In the Community version of WAPT,
    he is the unique :term:`Administrator` of WAPT.

  User
  Users
    A **User** is an individual who uses a machine that is equipped
    with a WAPT agent (WAPT Enterprise and Community).

  Organization
  Organizations
    The **Organization** is the perimeter or responsibility within which
    WAPT is used.

  ANSSI
    **Agence Nationale de la Sécurité des Systèmes d'Information**
    is a French service assuming Cyber Security for the French State
    and has a responsibility for counseling and helping government agencies
    and Critical Infrastructure Operators (OIV) with securing their IT systems.

  DNS
    **Domain Name System** translates more readily memorized domain names
    to the numerical IP addresses needed for locating and identifying
    computer services and devices.

  FQDN
    **Fully Qualified Domain Name** is a domain name that specifies
    its exact location in the tree hierarchy of the Domain Name System.
    It specifies all domain levels, including the top-level domain
    and the root zone. FQDN example: wapt.nantes.pdl.organisation.fr.

  EPEL
    **Extra Packages for Enterprise Linux** is an extra repository
    for CentOS and RedHat.

  GPO
    **Group Policy Object** is a feature of the Microsoft Windows NT family
    of operating systems that controls the working environment of user accounts
    and computer accounts. Group Policy provides the centralized management
    and configuration of operating systems, applications, and users' settings
    in an Active Directory environment.

  IDE
    **Integrated Development Environment**  is a software application
    that provides comprehensive facilities to computer programmers
    for software development. An IDE normally consists of a source code editor,
    build automation tools and a debugger.

  MMC
    **Microsoft Management Console** is a component of Windows that provides
    system administrators and advanced users an interface for configuring
    and monitoring the system.

  NAT
    **Network Address Translation** is a mechanism to allow computers
    from one network, usually with private IP addresses, to connect
    to another network, usually the Internet, using only one outgoing IP address
    of the NAT router.

  Setuphelpers
    **SetupHelpers** is a python library specifically designed for WAPT.
    It's main purpose is to provide a set of functions useful
    for package development, file and folder manipulation, shortcut creation,
    etc.

  SRV
    A **Service Record** (SRV record) is a specification of data
    in the Domain Name System defining the location, i.e. the hostname
    and port number, of servers for specified services.

  virtualhost
    **Virtual hosting** is a method for hosting multiple domain names
    (with separate handling of each name) on a single server
    (or pool of servers). This allows one server to share its resources,
    such as memory and processor cycles, without requiring all services provided
    to use the same host name. The term virtual hosting is usually used
    in reference to web servers but the principles do carry over
    to other Internet services.

  Websocket
    **Websockets** is a network protocol extending HTTP protocol in order
    to allow bidirectional client-server socket using the TCP connexion
    to a web server.

  UUID
    **Universally Unique IDentifier** is a unique standard normalized identifier
    for practical purposes. In WAPT every computer is referred uniquely
    by its UUID. For more information see
    https://en.wikipedia.org/wiki/Universally_unique_identifier.

  CNAME field
    A **CNAME** DNS field is an alias name for another A :term:`DNS` field.

  A field
    A **DNS A field** matches a name (generally the name of a machine)
    with an IP address.

  Certificate Authority
    An :abbr:`CA (Certificate Authority)` is a third party entity that vouches
    the identity of individuals or services exchanging information.

  PKI
    **Public Key Infrastructure** is a set of roles, policies, and procedures
    needed to create, manage, distribute, use, store, and revoke
    digital certificates and manage public-key encryption. The purpose of a PKI
    is to facilitate the secure electronic transfer of information.
