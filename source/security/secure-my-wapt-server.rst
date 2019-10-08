.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^
   

Enhance the security of my wapt server
=============================================

By default, all wapt packages are signed with your private key, which already provides you with great security, however you can further improve the security of wapt.
This documentation is necessary if your network requires a high level of security

To secure your wapt server you must do this:


* Enable Authenticate Registration

Allows to filter who has the authorization to register on the wapt server

* Enable https certificate verification by agents and the console

Check that the wapt agent is connecting to the correct wapt server.

* Configuring authentication against Active Directory

Used to filter access to the wapt console only to the authorized person
  

* Enable Client-Side Certificate Authentication

Allows wapt access only to the authenticating machine. (Especially important if you want to open your wapt server on the outside)
   

.. toctree::
  :maxdepth: 4
  
  ./security-install-kerberos.rst
  ./enable-check-certificate.rst
  ./security-configuration-auth-ad.rst
  ./security-configuration-certificate-authentication.rst
  