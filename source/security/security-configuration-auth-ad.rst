.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
    :description: Configuring authentication against Active Directory
    :keywords: Active Directory, WAPT, authentification, Kerberos, documentation

.. _configure_ad_auth:

Configuring authentication against Active Directory
+++++++++++++++++++++++++++++++++++++++++++++++++++

.. versionadded:: 1.5 Enterprise

.. hint::

  Feature only available with WAPT **Enterprise**.

By default, the WAPT Server is configured with a single :term:`SuperAdmin`
account whose password is setup during initial post-configuration.

On large and security-minded network, this :term:`SuperAdmin` account should not
be used since it cannot provide the necessary traceability
for administrative actions that are done on the network.

It is thus necessary to configure authentication against the
:term:`Organization`'s Active Directory for the :term:`Administrators`
and the :term:`Package Deployers`; this will allow to use named accounts
for administrative tasks.

.. note::

  * Active Directory authentication is used to authenticate access
    to the inventory via the WAPT Console;

  * however, all actions on the WAPT equipped remote devices are based
    on X.509 signatures, so an :term:`Administrator` will need both
    an Active Directory login **AND** a private key whose certificate is
    recognized by the remote devices to manage his installed base of devices
    using WAPT;

  * only the :term:`SuperAdmin` account and the members of the Active Directory
    security group **waptadmins** will be allowed to upload packages
    on the main repository (authentication mode by login and password);

Enabling Active Directory authentication
""""""""""""""""""""""""""""""""""""""""

* to enable authentication of the WAPT server on Active Directory,
  configure the file :file:`/opt/wapt/conf/waptserver.ini` as follows:

  .. code-block:: bash

    wapt_admin_group_dn=CN=waptadmins,OU=groupes,OU=tranquilit,DC=mydomain,DC=lan
    ldap_auth_server=srvads.mydomain.lan
    ldap_auth_base_dn=DC=mydomain,DC=lan
    ldap_auth_ssl_enabled=False

  ===================== =========================== =====================================
  Settings              Value                       Description
  ===================== =========================== =====================================
  wapt_admin_group_dn   CN=waptadmins,OU=groups,    DN to the group name.
                                                    All members of this group will
                                                    be able to connect to WAPT
  ldap_auth_server      srvads.mydomain.lan         LDAP server that will be used by WAPT
  ldap_auth_base_dn     DC=mydomain,DC=lan          DN for the search
  ldap_auth_ssl_enable  False                       /
  ===================== =========================== =====================================

* restart :program:`waptserver` with :code:`systemctl restart waptserver`;

Enabling SSL/ TLS support for the LDAP connection to the Active Directory Domain Controller
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

By default, authentication on Active Directory relies on
LDAP SSL (default port 646).

SSL/ TLS is not enabled by default on Microsoft Active Directory until
a SSL certificate has been configured for the Domain Controller.

.. note::

  The WAPT Server uses the Certificate Authority *bundles* from the operating
  system (CentOS) for validating the SSL/ TLS connection to Active Directory.

  If the Active Directory certificate is self-signed or has been signed
  by an internal CA, you'll need to add these certificates
  to the certificate store of CentOS.

  Add a :term:`Certificate Authority` in the
  :file:`/etc/pki/ca-trust/source/anchors/` and update the CA store.

  .. code-block:: bash

    cp cainterne.pem /etc/pki/ca-trust/source/anchors/cainterne.pem
    update-ca-trust

* Once you have setup LDAP SSL/ TLS on your Active Directory (please refer
  to Microsoft documentation for that), then you can enable support for SSL/
  TLS security for AD in :file:`/opt/wapt/conf/waptserver.ini`:

  .. code-block:: bash

    ldap_auth_ssl_enabled=True

* restart :program:`waptserver` with :code:`systemctl restart waptserver`;

