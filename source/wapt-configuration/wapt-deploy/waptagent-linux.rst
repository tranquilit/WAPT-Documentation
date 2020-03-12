.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Deploying the WAPT Agent on Linux
  :keywords: waptagent, linux, deployment, deploy, deploying, documentation, WAPT

.. _install_waptagent_linux:

Deploying the WAPT Agent on Linux
=================================

.. versionadded:: 1.8

Starting with WAPT 1.8, a Linux agent is available
for Linux Debian / Linux CentOS.

.. note::

  * the following procedure installs a WAPT agent using Tranquil IT's repositories
    for Debian/CentOS;

  * if you wish to install it manually, you can look
    for your `corresponding version <https://wapt.tranquil.it/wapt/releases/>`_;

  * copy the link of the binary that you need,
    download and install it with dpkg / rpm;

Installing the WAPT agent on Debian
+++++++++++++++++++++++++++++++++++

The most secure and reliable way to install the latest WAPT agent
on Linux Debian is using Tranquil IT's public repository.

* add Tranquil IT's repository in apt repository lists:

.. code-block:: bash

  apt-get update && apt-get upgrade
  apt-get install apt-transport-https lsb-release gnupg
  wget -O - https://wapt.tranquil.it/debian/tiswapt-pub.gpg  | apt-key add -
  echo "deb https://wapt.tranquil.it/debian/wapt-1.8/ $(lsb_release -c -s) main" > /etc/apt/sources.list.d/wapt.list

* install WAPT agent using apt-get:

.. code-block:: bash

  apt-get update
  apt-get install tis-waptagent

Installing the WAPT agent on CentOS
+++++++++++++++++++++++++++++++++++

The most secure and reliable way to install the latest WAPT agent
on Linux CentOS is using Tranquil IT's public repository.

* add Tranquil IT's repository in yum repository lists:

  .. code-block:: bash

    cat > /etc/yum.repos.d/wapt.repo <<EOF
    [wapt]
    name=WAPT Server Repo
    baseurl=https://wapt.tranquil.it/centos7/wapt-1.8/
    enabled=1
    gpgcheck=0
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

.. attention::

  If you are not using SSL/TLS certificates with your WAPT Server,
  you must change it in :file:`/opt/wapt/wapt-get.ini` the following lines to 0:

  .. code-block:: bash

    verify_cert=0

Registering your Linux agent
++++++++++++++++++++++++++++

* restart the WAPT service:

  .. code-block:: bash

    systemctl restart waptservice.service

* finally, execute the following command to register your Linux host
  with the WAPT server:

  .. code-block:: bash

     wapt-get register
     wapt-get update

Your Linux Agent is now installed and configured
and it will now appear in your WAPT Console with a penguin icon!!
