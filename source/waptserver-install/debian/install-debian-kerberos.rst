.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. _configure_krb5_auth_debian:

.. include:: ../security/security-install-kerberos.rst
   :end-before:  .. SUBSTITUTION: kerberos installation instruction

Installing the Kerberos components
""""""""""""""""""""""""""""""""""""

.. code-block:: bash

   apt-get install krb5-user msktutil
   apt-get install libnginx-mod-http-auth-spnego

.. include:: ../security/security-install-kerberos.rst
   :start-after: .. SUBSTITUTION: kerberos installation instruction
   :end-before: .. SUBSTITUTION: change ownership and permission on keytab

Finally, change the ownership rights on the keytab file.

.. code-block:: bash

    sudo chown root:www-data /etc/nginx/http-krb5.keytab
    sudo chmod 640 /etc/nginx/http-krb5.keytab

.. include:: ../security/security-install-kerberos.rst
   :start-after: .. SUBSTITUTION: change ownership and permission on keytab
