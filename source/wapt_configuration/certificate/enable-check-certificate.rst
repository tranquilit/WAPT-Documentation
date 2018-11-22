.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Securing the communications
                between the agent and the WAPT Server
  :keywords: pinning, certificate pinning, bundle, wapt-get.ini,
             Certificate Authority, enable-check-certificate, WAPT,
             documentation

.. _activating_HTTPS_certificate_verification:

Activating the verification of the SSL / TLS certificate
========================================================

.. attention::

  **For simplicity, it is better to run theses steps before
  launching the WAPT console**

The WAPT agent checks the HTTPS server certificate according
to the ``verify_cert`` value in section ``[global]``
in :file:`C:\Program Files (x86)\wapt\wapt-get.ini`.

.. table:: Options for "verify_cert"
  :widths: 30, 50
  :align: center

  =============================================================================== ========================================================================
  Options for verify_cert                                                         Working principle of the WAPT agent
  =============================================================================== ========================================================================
  ``verify_cert`` = 0                                                             the WAPT agent will not check the WAPT Server HTTPS certificate

  ``verify_cert`` = 1                                                             the WAPT agent will check the WAPT Server HTTPS
                                                                                  certificate using the certificate bundle
                                                                                  :file:`C:\Program Files (x86)\wapt\ssl\srvwapt.mydomain.lan.crt`

  ``verify_cert`` = C:\Program Files (x86)\wapt\ssl\srvwapt.mydomain.lan.crt      the WAPT agent will check the WAPT Server HTTPS
                                                                                  certificate with the certificate bundle
                                                                                  :file:`C:\Program Files (x86)\wapt\lib\site-packages\certifi\cacert.pem`
  =============================================================================== ========================================================================

.. hint::

   When using commercially issued certificates, it is advised to use
   the pinning method for more security.

Two methods are available for verifying the SSL/ TLS certificates:

* by default (``verify_cert`` = 1) with the certificate *bundle*
  contained in the standard Python :program:`certifi` module;

* by specifying the bundle that will be downloaded and activated
  with the command ``wapt-get enable-check-certificate`` (certificate pinning);

Pinning the certificate
-----------------------

The *pinning of certificate* consists of verifying the SSL/ TLS certificate
with a well defined and restricted bundle, instead of relying on the bundles
from Certificate Authorities contained in the certificate store provided
by default with Windows of with your Linux distribution.

.. hint::

   This method is useful even when using a certificate issued
   by a Trusted Authority.

   By specifying a bundle with the ``enable-check-certificate`` command,
   you restrict the list of Certificate Authorities that you trust.

   **The pinning of certificates issued by a Certificate Authority trusted
   by the Organization is the best method**.

For this, you need to launch the following commands in the Windows
:program:`cmd.exe` shell (with elevated privileges if UAC is active).

If you already have a Windows :program:`cmd.exe` shell open,
close it and open a new shell so to take into account
the updated environment variables:

.. code-block:: bash

    wapt-get enable-check-certificate
    net stop waptservice
    net start waptservice

Modify (:file:`C:\Program Files (x86)\wapt\ssl\srvwapt.mydomain.lan.crt`)
to add inside it the certificate of the ':term:`Certificate Authority`:

.. code-block:: bash

    -----BEGIN CERTIFICATE-----
    MIIFcjCCBFqgAwIBAgIQZvmdd8Fe0dhWbVj+l8GrrDANBgkqhkiG9w0BAQsFADCB
    kDELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4G

    .......             WAPT server certificate              .......

    WYmTeGzHxODu0TPOUwoRJu0v/Q75/HzXt9mqmJLVS5UR3qcas0fXvtYOLkuJ4xe1
    5T51oFRQ
    -----END CERTIFICATE-----
    -----BEGIN CERTIFICATE-----
    MIIFdDCCBFygAwIBAgIQJ2buVutJ846r13Ci/ITeIjANBgkqhkiG9w0BAQwFADBv
    MQswCQYDVQQGEwJTRTEUMBIGA1UEChMLQWRkVHJ1c3QgQUIxJjAkBgNVBAsTHUFk

    .......     certificate of the Certificate Authority     .......

    PUsE2JOAWVrgQSQdso8VYFhH2+9uRv0V9dlfmrPb2LjkQLPNlzmuhbsdjrzch5vR
    pu/xO28QOG8=
    -----END CERTIFICATE-----

Validate the certificate by using the following command:

 .. code-block:: bash

     wapt-get update

When you have executed the :command:`update` command, make sure that everything
has gone well, and if in doubt check :ref:`error_run_check_cert`.

.. note::

  the command *enable-check-certificate* downloads the certificate
  :file:`srvwapt.mydomain.lan.crt` in the folder
  :file:`C:\Program Files (x86)\WAPT\ssl`
  ;

  it then modifies the file :file:`wapt-get.ini` to specify the value
  ``verify_cert`` =
  :file:`C:\Program Files (x86)\wapt\ssl\srvwapt.mydomain.lan.crt`
  ;

  the WAPT agent will now verify certificates using the pinned certificate;

.. attention::

   If you use the *certificate pinning* method, be reminded to archive
   the :file:`/opt/wapt/waptserver/ssl` folder on your WAPT Server.

   The file will have to be restored on your server if you migrate or upgrade
   your WAPT Server, if you want the WAPT agents to continue being able
   to establish trusted HTTPS connections.

Certificate verification

Verifying the certificate in the WAPT console
---------------------------------------------

When the WAPT console first starts, it reads the content of
:file:`C:\Program Files (x86)\WAPT\wapt-get.ini` and it builds its configuration
file :file:`C:\Users\admin\AppData\Local\waptconsole\waptconsole.ini`.

We find the ``verify_cert`` attribute that defines the behavior
of the WAPT console in regards the HTTPS connection with the WAPT Server.

You may now proceed to the next step and :ref:`start the WAPT console
<starting-waptconsole>`.
