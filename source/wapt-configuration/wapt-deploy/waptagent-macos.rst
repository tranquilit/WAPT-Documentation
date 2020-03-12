.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Deploying the WAPT agent on MacOS
  :keywords: waptagent, MacOS, deployment, deploy, deploying, documentation, WAPT

.. _install_waptagent_macos:

Deploying the WAPT agent on MacOS
=================================

.. versionadded:: 1.8

.. attention::

  Currently, the agent has only been tested on `High Sierra <https://en.wikipedia.org/wiki/MacOS_High_Sierra>`_
  (version 10.13) and `Mojave <https://en.wikipedia.org/wiki/MacOS_Mojave>`_ (10.14)
  while the latest MacOS version is `Catalina <https://en.wikipedia.org/wiki/MacOS_Catalina>`_
  (10.15). Catalina may have introduced changes that could prevent the agent
  from working.

Installing the WAPT Agent package from Tranquil IT's public repository
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

* download WAPT agent for Apple Mac OSX
  from `Tranquil IT's public repository <https://wapt.tranquil.it/wapt/releases/latest/>`_;

* install the downloaded package:

  .. code-block:: bash

    installer -pkg /Volumes/Macintosh\ HD/Users/johnsmith/Downloads/tis-waptagent-1.8.0.6632-tismacos-bdc0beea.pkg -target /

Creating the agents configuration file
+++++++++++++++++++++++++++++++++++++

The requisites for your WAPT agent to work are:

* ``wapt-get.ini`` config file in :file:`/opt/wapt/`;

* a public certificate of the package-signing authority in :file:`/opt/wapt/ssl/`;

You need to create and configure the :file:`wapt-get.ini`
file in :file:`/opt/wapt` (:ref:`wapt-get-ini`).

An example of what it should look like is present further down on this page.
You may use it after changing the parameters to suit your needs.

.. code-block:: bash

  vim /opt/wapt/wapt-get.ini

.. code-block:: ini

  [global]
  repo_url=https://srvwapt.mydomain.lan/wapt
  wapt_server=https://srvwapt.mydomain.lan/
  use_hostpackages=1
  use_kerberos=0
  verify_cert=/opt/wapt/ssl/server/verify.crt

Copying the package-signing certificate
+++++++++++++++++++++++++++++++++++++++

You need to copy manually, or by script, the public certificate
of your package signing certificate authority.

The certificate should be located on your Windows machine
in :file:`C:\\Program Files (x86)\\wapt\\ssl\\`.

Copy your certificate(s) in :file:`/opt/wapt/ssl`
using :program:`WinSCP` or :program:`rsync`.

Copying the SSL/TLS certificate
+++++++++++++++++++++++++++++++

If you already have configured your WAPT server to use correct
:ref:`Nginx SSL/TLS certificates <activating_HTTPS_certificate_verification>`,
you must copy the certificate in your WAPT Linux agent.

The certificate should be located on your Windows machine
in :file:`C:\\Program Files (x86)\\wapt\\ssl\\server\\`.

Copy your certificate(s) in :file:`/opt/wapt/ssl/server/`
using :program:`WinSCP` or :program:`rsync`.

Registering your MacOS agent
++++++++++++++++++++++++++++

* restart the WAPT service:

  .. code-block:: bash

    sudo launchctl load /Library/LaunchDaemons/com.tranquilit.tis-waptagent.plist

* finally, execute the following command to register your MacOS host
  with the WAPT server:

  .. code-block:: bash

     wapt-get register
     wapt-get update

Your MacOS Agent is now installed and configured
and it will now appear in your WAPT Console with a MacOS icon.
