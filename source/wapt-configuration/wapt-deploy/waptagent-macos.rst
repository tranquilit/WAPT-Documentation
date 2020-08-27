.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Deploying the WAPT agent on MacOS
  :keywords: waptagent, MacOS, deployment, deploy, deploying, documentation, WAPT

.. |clap| image:: ../../icons/emoji/clapping-hands-microsoft.png
  :scale: 50%
  :alt: Clapping hands

.. |apple| image:: ../../icons/apple.png
  :scale: 20%
  :alt: Apple logo

.. |work_in_progress| image:: ../../icons/work-in-progress.png
  :scale: 20%
  :alt: Work in Progress

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

* download WAPT agent for Apple Mac OSX :
  Copy link from `Tranquil IT's public repository <https://wapt.tranquil.it/wapt/releases/latest/>`_ and paste it into a terminal
  .. code-block:: bash
    sudo curl <PastedLink> tis-waptagent.pkg

* install the downloaded package:

  .. code-block:: bash

    sudo installer -pkg tis-waptagent.pkg -target /

Creating the agents configuration file
++++++++++++++++++++++++++++++++++++++

The requisites for your WAPT agent to work are:

* ``wapt-get.ini`` config file in :file:`/opt/wapt/`;

* a public certificate of the package-signing authority in :file:`/opt/wapt/ssl/`;

You need to create and configure the :file:`wapt-get.ini`
file in :file:`/opt/wapt` (:ref:`wapt-get-ini`).

An example of what it should look like is present further down on this page.
You may use it after changing the parameters to suit your needs.

.. code-block:: bash

  sudo vim /opt/wapt/wapt-get.ini

.. code-block:: ini

  [global]
  repo_url=https://srvwapt.mydomain.lan/wapt
  wapt_server=https://srvwapt.mydomain.lan/
  use_hostpackages=1
  use_kerberos=0
  verify_cert=0

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
you must copy the certificate in your WAPT Mac agent.

The certificate should be located on your Windows machine
in :file:`C:\\Program Files (x86)\\wapt\\ssl\\server\\`.

Copy your certificate(s) in :file:`/opt/wapt/ssl/server/`
using :program:`WinSCP` or :program:`rsync`.

Then, modify in your :file:`wapt-get.ini` config file
the path to your certificate.

.. code-block:: bash

  sudo vim /opt/wapt/wapt-get.ini

And give absolute path of your cert.

.. code-block:: ini

  verify_cert=/opt/wapt/ssl/server/YOURCERT.crt

.. attention::

  If you are not using SSL/TLS certificates with your WAPT Server,
  you must set the following lines to 0 in :file:`/opt/wapt/wapt-get.ini`:

.. code-block:: bash

  verify_cert=0

Registering your MacOS agent
++++++++++++++++++++++++++++

.. attention::

  * beware, by default, WAPT takes the system language by default for packages,
    you may have to define the language in :file:`wapt-get.ini`
    with ``locales=``.

* restart the WAPT service:

.. code-block:: bash
   sudo launchctl unload /Library/LaunchDaemons/com.tranquilit.tis-waptagent.plist
   sudo launchctl load /Library/LaunchDaemons/com.tranquilit.tis-waptagent.plist

* finally, execute the following command to register your MacOS host
  with the WAPT server:



* you must logon as root to run :
.. code-block:: bash
 wapt-get register

* then switch back to normal user for the following :
.. code-block:: bash
 sudo wapt-get update

|clap| **Congratulations**, your MacOS Agent is now installed and configured
and it will now appear in your WAPT Console with a |apple| icon!

Supported features
++++++++++++++++++

Most features are now supported in version 1.8.2 of WAPT.

Unsupported features
""""""""""""""""""""

* installing updates on shutdown |work_in_progress|;

* WAPT console is not currently available on linux |work_in_progress|;

* any Windows specific feature;

Particularities with domain functionality
"""""""""""""""""""""""""""""""""""""""""

* testing was carried out with sssd with an Active Directory domain
  and kerberos authentication;

* to integrate a machine in the Active Directory domain,
  you can choose to follow `this documentation <https://dev.tranquil.it/samba/en/samba_config_client/client_join_clients_linux.html>`_

* to force the update of Organisational Units on the host,
  you can apply a :command:`gpupdate` from the WAPT console;

* in order for Active Directory groups to function properly,
  you must verify that the :command:`id hostname$` command returns
  the list of groups the host is member of;

.. attention::

   We have noticed that the Kerberos LDAP query does not work
   if the reverse DNS record is not configured correctly
   for your domain controllers. These records must therefore
   be created if they do not exist.
