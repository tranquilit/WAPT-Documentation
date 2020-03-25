.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Advanced settings for WAPTserver
  :keywords: waptserver.ini, Nginx, sections,

Configuring the WAPT Server
===========================

The WAPT Server configuration file on GNU/ Linux systems is found
in :file:`/opt/wapt/conf/waptserver.ini`.

The WAPT Server configuration file on Windows systems is found
in :file:`C:\\wapt\\conf\\waptserver.ini`.

.. attention::

  **Modification of these files is reserved for advanced users !!**

.. _waptserver_configuration:

Section [option]
----------------

Several options can be defined in the section:

.. code-block:: ini

    [options]

.. tabularcolumns:: |\X{5}{12}|\X{7}{12}|

=========================================================================== ==================================================================================================================================================
Options                                                                     Description
=========================================================================== ==================================================================================================================================================
``db_name`` = wapt                                                          Name of the PostgreSQL database that the WAPT
                                                                            Server will connect to.
``db_host`` =                                                               Address of the PostgreSQL server (empty by default,
                                                                            it will use a local Unix Socket).
``db_user`` =                                                               Name of the PostgreSQL user connecting to the database
                                                                            (default: empty, it will use a local UNIX socket).
``db_password`` =                                                           Password for authenticating the user on the PostgreSQL database (default: empty, it will use a local UNIX socket)
``wapt_user`` = admin                                                       Defines the :term:`SuperAdmin` username in the WAPT console.
``wapt_password`` = 46642dd2b1dfezfezgfezgadf0ezgeezgezf53d                 :term:`SuperAdmin` password for connecting to the WAPT console.
``secret_key`` =  FKjfzjfkF687fjrkeznfkj7678jknk78687                       Random string for initializing the Python Flask application server.
                                                                            It is generated when first installing the WAPT Server
                                                                            and is unique for every WAPT Server.
``wapt_folder`` = /var/www/wapt                                             Directory of the WAPT repository.
``waptwua_folder`` = /var/www/waptwua                                       Location of WAPT WUA folder
``server_uuid`` = 76efezfa6-b309-1fez5-92cd-8ea48fc122dc                    WAPT Server :term:`UUID` (this anonymous id is used for WAPT statistics).
``use_kerberos`` = true                                                     Requires a Kerberos authentication when first registering the WAPT agent.
``loglevel`` = debug                                                        Debug level.
``client_tasks_timeout`` = 1                                                Maximum allowed delay before WAPT agent requests timeout
``signature_clockskew`` = 72000                                             Maximum allowed time difference for the websockets
``db_connect_timeout`` = 10                                                 Maximum allowed delay before PostgreSQL queries timeout
``db_max_connections`` = 100                                                Maximum simultaneous connections to the PostgreSQL database
``allow_unauthenticated_registration`` = True                               Allows the initial registration of the WAPT agent using
                                                                            a login and password
``allow_unauthenticated_connect`` = False                                   Defines whether websocket connections should be authenticated
``http_proxy`` = http://proxy.ad.tranquil.it:3128                           Defines the proxy server to allow the WAPT server to recover
                                                                            its :abbr:`CRL (Certificate Revocation List)`
``wol_port`` = 9,123,4000                                                   List of WakeOnLAN UDP ports to send magic packets to
``wapt_admin_group_dn`` = CN=waptadmins,OU=groups,DC=ad,DC=domain,DC=lan    LDAP DN of Active Directory User Group allowed to connect to WAPT console
``remote_repo_support`` = True                                              Enables replication on remote repository
=========================================================================== ==================================================================================================================================================

.. _config_nginx:

Configuring Nginx
-----------------

The default Nginx configuration is as follows:

.. code-block:: nginx

  server {
    listen                      80;
    listen                      443 ssl;
    server_name                 _;
    ssl_certificate             "/opt/wapt/waptserver/ssl/cert.pem";
    ssl_certificate_key         "/opt/wapt/waptserver/ssl/key.pem";
    ssl_protocols               TLSv1.2;
    ssl_dhparam                 /etc/ssl/certs/dhparam.pem;
    ssl_prefer_server_ciphers   on;
    ssl_ciphers                 'EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH';
    ssl_stapling                on;
    ssl_stapling_verify         on;
    ssl_session_cache           none;
    ssl_session_tickets         off;
    index index.html;

    location ~ ^/wapt.* {
      proxy_set_header Cache-Control "store, no-cache, must-revalidate, post-check=0, pre-check=0";
      proxy_set_header Pragma "no-cache";
      proxy_set_header Expires "Sun, 19 Nov 1978 05:00:00 GMT";
      root "/var/www";
      }

    location / {
      proxy_set_header X-Real-IP  $remote_addr;
      proxy_set_header Host $host;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header X-Forwarded-Proto $scheme;

    location  ~ ^/(api/v3/upload_packages|api/v3/upload_hosts/|upload_waptsetup)  {
      proxy_pass http://127.0.0.1:8080;
      client_max_body_size 4096m;
      client_body_timeout 1800;
      }

    location /wapt-host/Packages {
      return 403;
      }

    location /wapt-host/add_host_kerberos {
      return 403;
      }

    location / {
      proxy_pass http://127.0.0.1:8080;
      }

    location /socket.io {
      proxy_http_version 1.1;
      proxy_buffering off;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection "Upgrade";
      proxy_pass http://127.0.0.1:8080/socket.io;
      }
    }
  }
