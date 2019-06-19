.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. _configure_krb5_auth_centos:

.. include:: ../security/security-install-kerberos.rst
   :end-before:  .. SUBSTITUTION: kerberos installation instruction

Installing the Kerberos components
""""""""""""""""""""""""""""""""""

.. code-block:: bash

   yum install krb5-workstation msktutil nginx-mod-http-auth-spnego

.. include:: ../security/security-install-kerberos.rst