.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
    :description: Installing the WAPT Server
    :keywords: install, WAPT, documentation

.. _installing_WAPT_Server:

Installing the WAPT Server
==========================

The WAPT Server can be installed on Debian Linux, CentOS or Microsoft Windows
**64 bits only**.

Installation tips and requirements
----------------------------------

You have to take into consideration a few security points in order
to get all the benefits of WAPT:

* we advise you to install WAPT Server on a Linux server (Debian or CentOS)
  following the security recommendations of French :term:`ANSSI`
  or the `recommendations of your state cyberdefense agency
  <https://www.ssi.gouv.fr/uploads/2015/10/NP_Linux_Configuration.pdf>`_.

* the WAPT Server must be installed on a **dedicated machine**
  (physical or virtual);

.. attention::

   In all steps of the documentation, you will not use any accent or special
   character for:

   * user logins;

   * path to the private key and the certificate bundle;

   * the :abbr:`CN (Common Name)`;

   * the installation path for WAPT;

   * group names;

   * the name of hosts or the the name of the server;

   * the path to the folder :file:`C:\\waptdev`;

Hardware recommendations
------------------------

The WAPT Server can be installed either on a virtual
server or a physical server.

RAM and CPU recommandations are:

.. tabularcolumns:: |\X{4}{6}|\X{1}{6}|\X{1}{6}|

========================= ===== ================================================
Size of the network       CPU   RAM
========================= ===== ================================================
From 0 to 200 desktops    1 CPU 1024MB
From 200 desktops onward  4 CPU 4096Mo
========================= ===== ================================================

A minimum of 10GB of free space is necessary for the system,
the database and log files.

The overall disk requirement will depend on the number and size of your WAPT
packages (softwares) that you will store on your main repository;
30GB is a good start.

DNS configuration
-----------------

.. toctree::
  :maxdepth: 1

  dns/dns-introduction.rst

Install on Debian Linux
-----------------------

.. toctree::
  :maxdepth: 1

  debian/install-debian-base.rst
  debian/install-debian-wapt.rst
  debian/install-debian-kerberos.rst
  security/security-install-ssl-certificate.rst

Install on CentOS7
------------------

.. toctree::
  :maxdepth: 1

  centos/install-centos-base.rst
  centos/install-centos-wapt.rst
  centos/install-centos-kerberos.rst
  security/security-install-ssl-certificate.rst

Install on Microsoft Windows
----------------------------

.. toctree::
  :maxdepth: 1

  windows/index.rst
  windows/change-port.rst

Authenticating WAPT Administrators against Active Directory
-----------------------------------------------------------

.. note::

  This feature is only available in WAPT **Enterprise**.

.. toctree::
  :maxdepth: 1

  security/security-configuration-auth-ad.rst
