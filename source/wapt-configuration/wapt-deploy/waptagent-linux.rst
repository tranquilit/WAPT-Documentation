.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Deploying the WAPT Agent on Linux
  :keywords: waptagent, linux, deployment, deploy, deploying, documentation, WAPT

.. |clap| image:: ../../icons/emoji/clapping-hands-microsoft.png
  :scale: 50%
  :alt: Clapping hands emoji

.. |pinguin| image:: ../../icons/emoji/pinguin.png
  :scale: 20%
  :alt: Pinguin emoji

.. |linux_debian| image:: ../../icons/debian.png
  :scale: 20%
  :alt: Debian logo

.. |linux_ubuntu| image:: ../../icons/ubuntu.png
  :scale: 20%
  :alt: Ubuntu logo

.. |linux_redhat| image:: ../../icons/redhat.png
  :scale: 20%
  :alt: Red Hat / CentOS logo

.. _install_waptagent_linux:

Deploying the WAPT Agent on Linux
=================================

.. versionadded:: 1.8

Starting with WAPT 1.8, a Linux agent is available
for |linux_debian| / |linux_ubuntu| and |linux_redhat|.

.. note::

  * the following procedure installs a WAPT agent using Tranquil IT's
    repositories for Debian/CentOS;

  * if you wish to install it manually, you can look
    for your `corresponding version <https://wapt.tranquil.it/wapt/releases/>`_;

  * copy the link of the binary that you need,
    download and install it with dpkg / rpm;

Installing the WAPT agent on Debian
+++++++++++++++++++++++++++++++++++

The most secure and reliable way to install the latest WAPT agent
on Linux Debian is using Tranquil IT's public repository.

* add Tranquil IT's repository in apt repository lists:

.. important::

  **Follow this procedure for getting the right packages
  for the WAPT Enterprise** Edition.
  For WAPT Community Edition please refer to the next block.

  To access WAPT Enterprise ressources, you must use the username
  and password provided by our sales department.

  Replace **user** and **password** in the **deb** parameter
  to access WAPT Enterprise repository.

    .. code-block:: bash

      apt update && apt upgrade -y
      apt install apt-transport-https lsb-release gnupg
      wget -O - https://wapt.tranquil.it/debian/tiswapt-pub.gpg  | apt-key add -
      echo "deb https://user:password@srvwapt-pro.tranquil.it/entreprise/debian/wapt-1.8/ $(lsb_release -c -s) main" > /etc/apt/sources.list.d/wapt.list

.. important::

  **Follow this procedure for getting the right packages
  for the WAPT Community** Edition.
  For WAPT Enterprise Edition please refer to the previous block.

  .. code-block:: bash

    apt update && apt upgrade -y
    apt install apt-transport-https lsb-release gnupg
    wget -O - https://wapt.tranquil.it/debian/tiswapt-pub.gpg  | apt-key add -
    echo "deb https://wapt.tranquil.it/debian/wapt-1.8/ $(lsb_release -c -s) main" > /etc/apt/sources.list.d/wapt.list

* install WAPT agent using apt-get:

.. code-block:: bash

  apt update
  apt install tis-waptagent

Installing the WAPT agent on CentOS
+++++++++++++++++++++++++++++++++++

The most secure and reliable way to install the latest WAPT agent
on Linux CentOS is using Tranquil IT's public repository.

* add Tranquil IT's repository in yum repository lists:

.. important::

  **Follow this procedure for getting the right packages
  for the WAPT Enterprise** Edition.
  For WAPT Community Edition please refer to the next block.

    To access WAPT Enterprise ressources, you must use the username
    and password provided by our sales department.

    Replace **user** and **password** in the **baseurl** parameter
    to access WAPT Enterprise repository.

    .. code-block:: bash

      cat > /etc/yum.repos.d/wapt.repo <<EOF
      [wapt]
      name=WAPT Server Repo
      baseurl=https://user:password@srvwapt-pro.tranquil.it/entreprise/centos7/wapt-1.8/
      enabled=1
      gpgcheck=1
      EOF

.. important::

  **Follow this procedure for getting the right packages
  for the WAPT Community** Edition.
  For WAPT Enterprise Edition please refer to the previous block.

  .. code-block:: bash

    cat > /etc/yum.repos.d/wapt.repo <<EOF
    [wapt]
    name=WAPT Server Repo
    baseurl=https://wapt.tranquil.it/centos7/wapt-1.8/
    enabled=1
    gpgcheck=1
    EOF

* install WAPT agent using yum:

  .. code-block:: bash

    yum install tis-waptagent

Creating the agent configuration file
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
you must copy the certificate in your WAPT Linux agent.

The certificate should be located on your Windows machine
in :file:`C:\\Program Files (x86)\\wapt\\ssl\\server\\`.

Copy your certificate(s) in :file:`/opt/wapt/ssl/server/`
using :program:`WinSCP` or :program:`rsync`.

Then, modify in your config file the path to your certificate.

.. code-block:: bash

  vim /opt/wapt/wapt-get.ini

And give absolute path of your cert.

.. code-block:: ini

  verify_cert=/opt/wapt/ssl/server/YOURCERT.crt

.. attention::

  If you are not using SSL/TLS certificates with your WAPT Server,
  you must change it in :file:`/opt/wapt/wapt-get.ini` the following lines to 0:

  .. code-block:: bash

    verify_cert=0

Registering your Linux agent
++++++++++++++++++++++++++++

.. attention::

  * beware, by default, WAPT takes the system language by default for packages,
    you may have to define the language in :file:`wapt-get.ini`
    with ``locales=``.

* restart the WAPT service:

  .. code-block:: bash

    systemctl restart waptservice.service

* finally, execute the following command to register your Linux host
  with the WAPT server:

  .. code-block:: bash

     wapt-get register
     wapt-get update

|clap| **Congratulations**, your Linux Agent is now installed and configured
and it will now appear in your WAPT Console with a |pinguin| icon!!

Supported features
++++++++++++++++++

Most features are now supported in version 1.8.2 of WAPT.

Unsupported features
""""""""""""""""""""

* installing updates on shutdown (Work in progress);

* WAPT console is not currently available on linux (Work in progress);

* Any Windows specific feature;

Particularities with domain functionality
"""""""""""""""""""""""""""""""""""""""""

* testing was carried out with sssd with an Active Directory domain
  and kerberos authentication;

* to integrate a Linux machine in the Active Directory domain,
  you can choose to follow `this documentation <https://dev.tranquil.it/samba/en/samba_config_client/client_join_clients_linux.html>`_

* to force the update of Organisational Units on the Linux host,
  you can apply a :command:`gpupdate` from the WAPT console;

* in order for Active Directory groups to function properly,
  you must verify that the :command:`id hostname$` command returns
  the list of groups the host is member of;

.. attention::

   We have noticed that the Kerberos LDAP query does not work
   if the reverse DNS record is not configured correctly
   for your domain controllers. These records must therefore
   be created if they do not exist.
