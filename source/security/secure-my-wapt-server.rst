.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
 :description: Enhancing the security of the WAPT server
 :keywords: Documentation, Security, WAPT

.. _activating_HTTPS_certificate_verification:

Enhancing the security of the WAPT server
=========================================

By default, all WAPT packages are signed with your private key,
which already provides a great level of security. However you can
further improve the security of WAPT.

This documentation is necessary if your network requires
a high level of security.

To secure your WAPT server; you must do the following:

* enable authenticated registration to allow you to filter
  who has the authorization to register the device with the WAPT server;

* enable https certificate verification by agents and the console
  to ensure that the WAPT agent is connecting to the correct WAPT server;

* configure authentication against Active Directory to only allow
  access to the WAPT console only to authorized WAPT admins;

* enable Client-Side Certificate Authentication to only allow access
  to authenticated devices (Note : it is especially important
  if you want to expose your WAPT server to the outside);

.. toctree::
  :maxdepth: 4

  ./security-install-kerberos.rst
  ./enable-check-certificate.rst
  ./security-configuration-auth-ad.rst
  ./security-configuration-certificate-authentication.rst
