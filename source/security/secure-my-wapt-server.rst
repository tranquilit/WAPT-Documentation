.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^


Enhancing the security of the WAPT server
=========================================

By default, all WAPT packages are signed with your private key,
which already provides you with great security. However you can
further improve the security of WAPT.

This documentation is necessary if your network requires
a high level of security.

To secure your WAPT server you must do this:

* enabling authenticated registration will allow you to filter
  who has the authorization to register the device on the WAPT server

* enabling https certificate verification by agents and the console
  will ensure that the WAPT agent is connecting to the correct WAPT server;

* configuring authentication against Active Directory will allow
  access to the WAPT console only to authorized WAPT admins;

* enabling Client-Side Certificate Authentication will only allow access
  to authenticated devices (Note : it is especially important
  if you want to expose your WAPT server to the outside);

.. toctree::
  :maxdepth: 4

  ./security-install-kerberos.rst
  ./enable-check-certificate.rst
  ./security-configuration-auth-ad.rst
  ./security-configuration-certificate-authentication.rst
