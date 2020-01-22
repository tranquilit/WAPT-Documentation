.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Deploying the WAPT agent for Linux
  :keywords: waptagent, linux, deployment, deploy, deploying, documentation, WAPT

.. _install_waptagent_linux:

Deploying the WAPT Agent on Linux
=================================

Starting with WAPT 1.8, a Linux agent is available for Linux Debian / Linux CentOS.

.. note ::

  * The following procedure installs WAPT agent using Tranquil IT repositories for Debian/CentOS
  * If you wish to install it manually, you can look for your corresponding version with your internet browser : https://wapt.tranquil.it/wapt/releases/
  * Copy the link of the binary that you need, download and install with dpkg/rpm

Installation on Debian 
++++++++++++++++++++++

The most secure and reliable way to install latest WAPT agent on Linux Debian is using Tranquil IT public repository.

* Add Tranquil IT repository in apt repository lists :

.. code-block :: bash

  apt-get update && apt-get upgrade
  apt-get install apt-transport-https lsb-release gnupg
  wget -O - https://wapt.tranquil.it/debian/tiswapt-pub.gpg  | apt-key add -
  echo "deb https://wapt.tranquil.it/debian/wapt-1.8/ $(lsb_release -c -s) main" > /etc/apt/sources.list.d/wapt.list

* Install WAPT agent using apt-get :

.. code-block :: bash

  apt-get update
  apt-get install tis-waptagent


Installation on CentOS
++++++++++++++++++++++++++++++++++++++++

The most secure and reliable way to install latest WAPT agent on Linux CentOS is using Tranquil IT public repository.

* Add Tranquil IT repository in yum repository lists :

.. code-block :: bash

  cat > /etc/yum.repos.d/wapt.repo <<EOF
  [wapt]
  name=WAPT Server Repo
  baseurl=https://wapt.tranquil.it/centos7/wapt-1.8/
  enabled=1
  gpgcheck=0
  EOF


* Install WAPT agent using yum :

.. code-block :: bash

  yum install tis-waptagent


Registering the agent
++++++++++++++++++++++++++

You need to create and configure the :file:`wapt-get.ini` file in :file:`/opt/wapt` (:ref:`wapt-get-ini`). 

An example of what it should look like is present further down on this page. You may use it after changing the parameters to suit your needs.

.. code-block :: bash

  vim /opt/wapt/wapt-get.ini


.. code-block :: ini

  [global]
  repo_url=https://srvwapt.mydomain.lan/wapt
  wapt_server=https://srvwapt.mydomain.lan/
  send_usage_report=1
  use_hostpackages=1
  use_kerberos=0
  check_certificates_validity=0
  verify_cert=0


.. code-block :: bash

  systemctl restart waptservice.service

Finally, execute the following command to register your machine :

.. code-block :: bash

   wapt-get register
   wapt-get update


Your Linux Agent is now installed and configured and will appear in your WAPT Console.