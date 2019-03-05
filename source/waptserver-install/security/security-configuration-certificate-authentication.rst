.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
    :description: Using valid SSL / TLS certificates for the WAPT Server
    :keywords: certificat, WAPT, SSL / TLS, Certificate Authority, documentation

.. _client_side_certificate_authentication:

Configure Client-Side Certificate Authentication
+++++++++++++++++++++++++++++++++++++++++++++++++++++

.. versionadded:: 1.7 Enterprise

If your business need a public WAPT server on Internet, it can be secured with **Client-Side Certificate Authentication**. 

That configuration restricts the visibility of WAPT Server to registered clients only, using the Agent private key generated during registration.

  * The agent sends a CSR to WAPT server which is signed and send back to WAPT agent. 
  * Using that signed certificate, the agent can access protected parts of Nginx server

.. note::
    
    We advise you to enabe Kerberos or login/password registration in WAPT Server post-configuration.


Generate Certificate Authority for Nginx
"""""""""""""""""""""""""""""""""""""""""""""""

Using :file:`wapt-get.exe` command, generate the Certificate Authority for Nginx :

.. code-block:: bash
  
  mkdir c:\nginx_keys
  wapt-get.exe create-keycert /CA=1 /CodeSigning=0 /NoPrivateKeyPassword /CommonName=wapt-serverauth-ca /ConfigFilename=wapt-get.ini /BaseDir=c:\nginx_keys\


Transfer the two generated files on WAPT Server, set **clients_signing_key** and **clients_signing_certificate** values in :file:`/opt/waptserver/conf/waptserver.ini`

.. code-block:: ini

  [options]
  ...
  clients_signing_key = /opt/waptserver/nginx/wapt-serverauth-ca.pem
  clients_signing_certificate = /opt/waptserver/nginx/wapt-serverauth-ca.crt



Enabling Client-Side Certificate Authentication
"""""""""""""""""""""""""""""""""""""""""""""""

Add a Nginx configuration file :file:`/etc/nginx/certificate-auth.conf`. This file is used to restrict access to specific actions with Certificate Authentication

.. code-block:: nginx

    proxy_set_header X-Ssl-Authenticated $ssl_client_verify;
    proxy_set_header X-Ssl-Client-DN $ssl_client_s_dn;
    if ($ssl_client_verify != SUCCESS) {
        return 401;
    }


Example config file :

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

        gzip_min_length     1000;
        gzip_buffers        4 8k;
        gzip_http_version   1.0;
        gzip_disable        "msie6";
        gzip_types          text/plain text/css application/json;
        gzip_vary           on;

        ssl_client_certificate "/opt/wapt/conf/wapt-serverauth-ca.crt";
        ssl_verify_client optional;

        index index.html;

        location /static {
            alias "/opt/wapt/waptserver/static";
        }

        location / {
            proxy_set_header X-Real-IP  $remote_addr;
            proxy_set_header Host $host;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;

            client_max_body_size 4096m;
            client_body_timeout 1800;

            location ~ ^/(wapt|wapt-host|waptwua)/(.*)$ {
                proxy_set_header Cache-Control "store, no-cache, must-revalidate, post-check=0, pre-check=0";
                proxy_set_header Pragma "no-cache";
                proxy_set_header Expires "Sun, 19 Nov 1978 05:00:00 GMT";

                include /etc/nginx/certificate-auth.conf;
                
                rewrite ^/(wapt|wapt-host|waptwua)/(.*)$ /$1/$2 break;
                root "/var/www";
            }

            # kerberos auth
            location /add_host_kerberos {
                auth_gss on;
                auth_gss_keytab  /etc/nginx/http-krb5.keytab;
                proxy_pass http://127.0.0.1:8080;
            }

            # basic auth
            location ~ ^/(add_host|ping)$ {
                proxy_pass http://127.0.0.1:8080;
            }

            location /wapt-host/Packages {
                    return 403;
            }

            location / {
                include /etc/nginx/certificate-auth.conf;
                proxy_pass http://127.0.0.1:8080;

            }

            location /socket.io {
                include /etc/nginx/certificate-auth.conf;
                proxy_http_version 1.1;
                proxy_buffering off;

                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "Upgrade";
                proxy_pass http://127.0.0.1:8080/socket.io;

            }
        }

    }

