.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Configuring Kerberos authentication
  :keywords: Kerberos, authentication, Debian, WAPT, documentation, RedHat,
             CentOS

.. _configuring_kerberos_authentication:

Configuring Kerberos authentication
+++++++++++++++++++++++++++++++++++

.. note::

  * without Kerberos authentication, you have to either trust initial
    registration or enter a password for each workstation
    on initial registration;

  * for more information, visit the documentation on :ref:`registering a machine
    with the WAPT Server <initial_machine_registration>` and :ref:`signing
    inventory updates <signing_inventory_updates>`;

  * the Kerberos authentication will be used only when registering the device;

Installing the Kerberos components and configuring krb5.conf file
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For centos

.. code-block:: bash

   yum install krb5-workstation msktutil nginx-mod-http-auth-spnego

For Debian

.. code-block:: bash

   apt-get install krb5-user msktutil libnginx-mod-http-auth-spnego

.. note::

   The feature is not available with a WAPT Windows server

Modify the :file:`/etc/krb5.conf` file and **replace all the content with the
following 4 lines** replacing **MYDOMAIN.LAN** with your Active Directory
domain name (i.e. *<MYDOMAIN.LAN>*).

.. attention::

  ``default_realm`` must be written with **ALL CAPS**!!

.. code-block:: ini

  [libdefaults]
    default_realm = MYDOMAIN.LAN
    dns_lookup_kdc = true
    dns_lookup_realm=false

Retrieving a service keytab. Use the :`command:`kinit` and :command:`klist`. You can use an
:term:`Administrator` account or any other account with the delegated
right to join a computer to the domain in the proper destination container
(by default *CN=Computers*).

In the shell transcript below, commands are in black and returned
text is commented in light gray:

.. code-block:: bash

  sudo kinit administrator
  ## Password for administrator@MYDOMAIN.LAN:
  ## Warning: Your password will expire in 277 days on lun. 17 sept. 2018 10:51:21 CEST
  sudo klist
  ## Ticket cache: FILE:/tmp/krb5cc_0
  ## Default principal: administrator@MYDOMAIN.LAN
  ##
  ## Valid starting       Expires              Service principal
  ## 01/12/2017 16:49:31  02/12/2017 02:49:31  krbtgt/MYDOMAIN.LAN@MYDOMAIN.LAN
  ## renew until 02/12/2017 16:49:27

If the authentication request is successful, you can then create your
HTTP Keytab with the :program:`msktutil` command.

Be sure to modify the *<DOMAIN_CONTROLER>* string with the name of your domain
controller (eg: **srvads.mydomain.lan**).

.. code-block:: bash

  sudo msktutil --server DOMAIN_CONTROLER --precreate --host $(hostname) -b cn=computers --service HTTP --description "host account for wapt server" --enctypes 24 -N
  sudo msktutil --server DOMAIN_CONTROLER --auto-update --keytab /etc/nginx/http-krb5.keytab --host $(hostname) -N

.. attention::

  Be sure to have properly configured your WAPT Server *hostname* before running
  these commands;

  In order to double check your *hostname*, you can run :code:`echo $(hostname)`
  and it must return the name that will be used by WAPT agent running
  on client workstations.

* apply the proper access rights to the :file:`http-krb5.keytab` file:

  - on Debian:

    .. code-block:: bash

       sudo chmod 640 /etc/nginx/http-krb5.keytab
       sudo chown root:www-data /etc/nginx/http-krb5.keytab

  - on Centos:

    .. code-block:: bash

        sudo chown root:nginx /etc/nginx/http-krb5.keytab
        sudo chmod 640 /etc/nginx/http-krb5.keytab

Post-configuring
^^^^^^^^^^^^^^^^

You can now use post-configuration script to configure the WAPT Server
to use Kerberos.

The post-configuration script will configure :program:`Nginx`
and the WAPT Server to use Kerberos authentication.

.. hint::

  This post-configuration script must be run as **root**.

.. code-block:: bash

  /opt/wapt/waptserver/scripts/postconf.sh --force-https

Kerberos authentication will now be configured.


Special use cases
"""""""""""""""""

My WAPT server does not have access to a writeable Active Directory
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* connect to your Active Directory (Not a RODC);

* create a computer account *srvwapt*;

* add a :abbr:`SPN (Service Principal Name)` on the *srvwapt$* account;

.. code-block:: bash

   setspn -A HTTP/srvwapt.mydomain.lan srvwapt

* create a keytab for this WAPT server:

.. code-block:: batch

     ktpass -out C:\http-krb5.keytab -princ HTTP/srvwapt.mydomain.lan@MYDOMAIN.LAN rndpass -minpass 64 -crypto all -pType KRB5_NT_PRINCIPAL /mapuser srvwapt$@MYDOMAIN.LAN
     Reset SRVWAPT$'s password [y/n]?  y

* transfer this file to :file:`/etc/nginx/`
  (with :program:`winscp` for example);

* apply the proper access rights to the :file:`http-krb5.keytab` file:

  - on Debian:

    .. code-block:: bash

       sudo chmod 640 /etc/nginx/http-krb5.keytab
       sudo chown root:www-data /etc/nginx/http-krb5.keytab

  - on Centos:

    .. code-block:: bash

        sudo chown root:nginx /etc/nginx/http-krb5.keytab
        sudo chmod 640 /etc/nginx/http-krb5.keytab

WAPT agent only have access to a RODC domain controller
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* for :abbr:`RODC (Read-Only Domain Controller)`, add the *srvwapt* account
  to the allowed password group for replication;

* remember to preload the password of the WAPT server
  with the different RODC servers;

.. figure:: rodc-preload.png
  :align: center
  :alt: Preload Password srvwapt account

You have multiple Active Directory domains with or without relationship
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you have multiple Active Directory domains,
you must create one :file:`keytab` per domain by following the procedure
above, ex:

* :file:`http-krb5-domain1.local.keytab`
* :file:`http-krb5-domain2.local.keytab`
* :file:`http-krb5-domain3.local.keytab`

You will then have to merge all these :file:`keytabs`
into a unique :file:`keytab`:

.. code-block:: bash

  ktutil
  read_kt http-krb5-domain1.local.keytab
  read_kt http-krb5-domain2.local.keytab
  read_kt http-krb5-domain3.local.keytab
  write_kt http-krb5.keytab
