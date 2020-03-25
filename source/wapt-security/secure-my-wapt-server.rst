.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
 :description: Enhancing the security of the WAPT server
 :keywords: Documentation, Security, WAPT

.. _enhancing_the_security_of_the_wapt_server:

Enhancing the security of the WAPT server
=========================================

By default, all WAPT packages are signed with your private key,
which already provides a great level of security. However you can
further improve the security of WAPT.

To fully secure your WAPT setup; you will want to do the following:

* enable authenticated registration to filter who is authorized
  to register the device with the WAPT server;

* enable https certificate verification on the agents and the console
  to ensure that the WAPT agents and the WAPT console
  are connecting to the correct WAPT server;

* configure authentication against Active Directory to allow
  access to the WAPT console only to authorized WAPT admins;

* enable Client-Side Certificate Authentication to only allow
  authenticated devices to access the WAPT server (Note: it is especially
  important if you want to expose your WAPT server to the outside
  in a :abbr:`DMZ (De-Militarized Zone)`);

.. toctree::
  :maxdepth: 4

  ./security-firewall.rst
  ./security-install-kerberos.rst
  ./enable-check-certificate.rst
  ./security-configuration-auth-ad.rst
  ./security-configuration-certificate-authentication.rst
