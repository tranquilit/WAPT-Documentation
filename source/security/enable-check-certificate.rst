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

When running the WAPT Server post-configuration script, the script will generate
a self-signed certificate in order to enable HTTPS communications.

The WAPT agent checks the HTTPS server certificate according
to the ``verify_cert`` value in section ``[global]``
in :file:`C:\\Program Files (x86)\\wapt\\wapt-get.ini`.

.. table:: Options for ``verify_cert``
  :widths: 30, 50
  :align: center

  =============================================================================== =============================================================================================================================================================================================================================================
  Options for ``verify_cert``                                                     Working principle of the WAPT agent
  =============================================================================== =============================================================================================================================================================================================================================================
  ``verify_cert`` = 0                                                             the WAPT agent will not check the WAPT Server HTTPS certificate

  ``verify_cert`` = 1                                                             the WAPT agent will check the WAPT Server HTTPS certificate using the certificate bundle :file:`C:\\Program Files (x86)\\wapt\\lib\\site-packages\\certifi\\cacert.pem`

  ``verify_cert`` = C:\\Program Files (x86)\\wapt\\ssl\\srvwapt.mydomain.lan.crt  the WAPT agent will check the WAPT Server HTTPS
                                                                                  certificate with the certificate bundle
                                                                                  :file:`C:\\Program Files (x86)\\wapt\\ssl\\srvwapt.mydomain.lan.crt`
  =============================================================================== =============================================================================================================================================================================================================================================

.. hint::

   To quickly and easily enable verification of the https certificate,
   you can use the *Pinning* method.

Pinning the certificate
-----------------------

The *pinning of certificate* consists of verifying the SSL/ TLS certificate
with a well defined and restricted bundle.

.. hint::

   This method is the easiest when using a self-signed certificate.

For this, you need to launch the following commands in the Windows
:program:`cmd.exe` shell (with elevated privileges if :abbr:`UAC (User Account
Control)` is active).

If you already have a Windows :program:`cmd.exe` shell open,
close it and open a new shell so to take into account
the updated environment variables:

.. code-block:: bash

    wapt-get enable-check-certificate
    net stop waptservice
    net start waptservice

Validate the certificate with :command:`wapt-get update`

When you have executed the :command:`update` command, make sure that everything
has gone well, and if in doubt check :ref:`error_run_check_cert`.

.. note::

  * the command *enable-check-certificate* downloads the certificate
    :file:`srvwapt.mydomain.lan.crt` in the folder
    :file:`C:\\Program Files (x86)\\WAPT\\ssl\\server`;

  * it then modifies the file :file:`wapt-get.ini` to specify the value
    ``verify_cert`` =
    :file:`C:\\Program Files (x86)\\wapt\\ssl\\server\\srvwapt.mydomain.lan.crt`;

  * the WAPT agent will now verify certificates using the pinned certificate;

.. attention::

   If you use the *certificate pinning* method, be reminded to archive
   the :file:`/opt/wapt/waptserver/ssl` folder on your WAPT Server.

   The file will have to be restored on your server if you migrate or upgrade
   your WAPT Server, if you want the WAPT agents to continue to be able
   to establish trusted HTTPS connections.

How to use a commercial certificate or certificates provided by your organization?
----------------------------------------------------------------------------------

If the pinning method does not suit you, you can replace
the self-signed certificate generated during the installation
of :program:`WAPT`.

Replace the old certificate with the new one in the folder
:file:`/opt/wapt/waptserver/ssl/` (linux) or
:file:`c:\\wapt\\waptserver\\ssl\\` (windows).

The new key pair must be in PEM encoded Base64 format

.. note::

  **Special case where your certificate has been signed
  by an internal Certificate Authority**

  Certificates issued by an internal :term:`Certificate Authority` must have
  the complete certificate chain up to the :term:`Certificate Authority`'s
  certificate.

  You can manually add the certificate chain up to the Certificate Authority
  to the certificate that will be used by :program:`Nginx`.

  Example: :code:`echo srvwapt.mydomain.lan.crt ca.crt > cert.pem`

For linux servers it is also necessary to reset the :abbr:`ACLs (Access Control
List)`:

.. code-block:: bash

   #Debian :
   chown root:www-data /opt/wapt/waptserver/ssl/*.pem

   #Centos :
   chown root:nginx /opt/wapt/waptserver/ssl/*.pem

* restart :program:`Nginx` to take into account the new certificates;

  * Linux:

    .. code-block:: bash

      systemctl restart nginx

  * Windows:

    .. code-block:: bash

      net stop waptnginx
      net start waptnginx

Configuring the WAPT agent
++++++++++++++++++++++++++

For a commercial certificate you can set ``verify_cert`` = 1
in :file:`wapt-get.ini`.

For a certificate issued by an internal Certificate Authority,
you must place the certificate in the
:file:`C:\\Program Files (x86)\\wapt\\ssl\\server\\ca.crt` folder
and specify the certificate path in ``verify_cert``
in the agent's :file:`wapt-get.ini`.

To apply the new configuration to your entire fleet,
you can regenerate a WAPT agent with the appropriate settings.

Verifying the certificate in the WAPT console
---------------------------------------------

When the WAPT console first starts, it reads the content of
:file:`C:\\Program Files (x86)\\WAPT\\wapt-get.ini` and it builds its configuration
file :file:`C:\\Users\\admin\\AppData\\Local\\waptconsole\\waptconsole.ini`.

This properly sets the ``verify_cert`` attribute for the HTTPS communication
between the WAPT console and the WAPT Server.
