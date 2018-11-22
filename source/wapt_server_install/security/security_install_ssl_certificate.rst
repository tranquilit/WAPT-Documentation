.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
    :description: Using valid SSL / TLS certificates for the WAPT Server
    :keywords: certificat, WAPT, SSL / TLS, Certificate Authority, documentation

.. _install_ssl_certificate:

Using valid SSL/ TLS certificates for the WAPT Server
+++++++++++++++++++++++++++++++++++++++++++++++++++++

When running the WAPT Server post-configuration script, the script will generate
a self-signed certificate so to enable HTTPS communications.

The self-signed certificate will of course not be recognized by web browsers
and users may get warning messages.

It is thus advised to set up a proper SSL/ TLS certificate that will be
recognized by you :term:`Organization`'s web browser
(either a commercial certificate or one emitted by your internal
:term:`Certificate Authority`).


Setting up a SSL / TLS certificate on Linux
"""""""""""""""""""""""""""""""""""""""""""

* replace the self-signed public certificate and the private key file located
  in :file:`/opt/wapt/waptserver/ssl/` with keys and certificates provided
  by your Organization;

.. hint::

  * we suppose here that the certificate has already been created
    with the **Common Name** corresponding to your WAPT
    Server name **srvwapt.mydomain.lan**;

  * first copy your certificates :file:`.crt` and :file:`.key` files
    on your WAPT Server. Below, we suppose that they are in
    the :file:`/etc/ssl/private` folder;

  .. code-block:: bash

    cp -f /etc/ssl/private/srvwapt.mydomain.lan.crt /opt/wapt/waptserver/ssl/cert.pem
    cp -f /etc/ssl/private/srvwapt.mydomain.lan.key /opt/wapt/waptserver/ssl/key.pem
    chmod 440 /opt/wapt/waptserver/ssl/*.pem

    #Debian :
    chown root:www-data /opt/wapt/waptserver/ssl/*.pem

    #Centos :
    chown root:nginx /opt/wapt/waptserver/ssl/*.pem

.. note::

  **Special case where your certificate has been signed
  by an internal Certificate Authority**

  Certificates issued by an internal :term:`Certificate Authority` must have
  the complete certificate chain up to the :term:`Certificate Authority`'s
  certificate.

  You can manually add the certificate chain up to the Certificate Authority
  to the certificate that will be used by :program:`Nginx`.

  Example: :code:`echo srvwapt.mydomain.lan.crt ca.crt > cert.pem`

  * for more details on the WAPT agent verifying and validating certificates,
    visit :ref:`this documentation <activating_HTTPS_certificate_verification>`;

  * for more information on :program:`Nginx` configuration,
    please refer to the :ref:`documentation on configuring Nginx
    <config_nginx>`;

* restart :program:`Nginx` to take into account the new certificates;

.. code-block:: bash

  systemctl restart nginx

* check that :program:`Nginx` restarts;

.. code-block:: bash

  ps -edf | grep nginx

Setting up a SSL/ TLS certificate on Windows
""""""""""""""""""""""""""""""""""""""""""""

* replace the self-signed public certificate and private key file located
  in :file:`/opt/wapt/waptserver/ssl/` with keys and certificates provided
  by your Organization;

.. note::

  **Special case where your certificate has been signed
  by an internal Certificate Authority**

  Certificates issued by an internal :term:`Certificate Authority` must have
  the complete certificate chain up to the :term:`Certificate Authority`'s
  certificate.

  You can manually add the certificate chain up to the Certificate Authority
  to the certificate that will be used by :program:`Nginx`.

  * for more details on the WAPT agent verifying and validating
    certificates, visit :ref:`this documentation
    <activating_HTTPS_certificate_verification>`;

  * for more information on :program:`Nginx` configuration, please refer to
    the :ref:`documentation on configuring Nginx <config_nginx>`;

* restart :program:`Nginx` to take into account the new certificates;

.. code-block:: bash

  net stop waptnginx
  net start waptnginx

Checking the validity of the certificate
""""""""""""""""""""""""""""""""""""""""

* connect with an up-to-date web browser (for example Firefox 57/ Firefox
  52.5 ESR) to the WAPT Server web console https://srvwapt.mydomain.lan;

.. hint::

  If you are using an internal :term:`Certificate Authority`, the web browser
  must already have your Organization's internal CA in its certificate store.

  **Expected result**: you access WAPT Server web page without warning and
  with the SSL/ TLS validation icons in the address bar; all is fine.

Go on to the next step to :ref:`configure AD authentication configuration
<configure_ad_auth>` or directly to :ref:`install the WAPT console
<installing_the_WAPT_console>`.
