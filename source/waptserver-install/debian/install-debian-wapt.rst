.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Installing the WAPT Server on Debian Linux
  :keywords: Server, WAPT, Debian, install, installation, documentation

.. _install_wapt_debian:

Installing the WAPT Server on Debian Linux
++++++++++++++++++++++++++++++++++++++++++

.. attention::

  The upgrade procedure is different from installation.
  For upgrade, please refer to :ref:`Upgrading the WAPT Server <upgrade-wapt>`.

Installing the WAPT Server requires a few steps:

* configuring the repositories;

* installing additional Linux packages;

* installing and provisioning the PostgreSQL database;

* post-configuring the WAPT Server;

.. note::

  The WAPT Server packages and repository are signed by Tranquil IT
  and it is necessary to get the gpg public key below in order
  to avoid warning messages during installation.

Configuring DEB repositories and installing WAPT and PostgreSQL packages
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

The configuration of repositories for **WAPT Enterprise**
and **WAPT Community** Edition differs. **Make sure to choose the right one!**

During installation, you may be asked for the Kerberos realm. Just press
:kbd:`Enter` to skip this step.

.. important::

  **Below is the configuration for WAPT Community** Edition.
  For WAPT Enterprise Edition please see above.

  To access WAPT Enterprise ressources, you must use the username
  and password provided by our sales department.

  Replace **user** and **password** in the **deb** parameter
  to access WAPT Enterprise repository.

    .. code-block:: bash

      apt-get update && apt-get upgrade
      apt-get install apt-transport-https lsb-release
      wget -O - https://wapt.tranquil.it/debian/tiswapt-pub.gpg  | apt-key add -
      echo "deb https://user:password@srvwapt-pro.tranquil.it/entreprise/debian/wapt-1.8/ $(lsb_release -c -s) main" > /etc/apt/sources.list.d/wapt.list

.. important::

  Below is the configuration for **WAPT Community** Edition.
  For WAPT Enterprise Edition please see above.

  .. code-block:: bash

    apt-get update && apt-get upgrade
    apt-get install apt-transport-https lsb-release gnupg
    wget -O - https://wapt.tranquil.it/debian/tiswapt-pub.gpg  | apt-key add -
    echo "deb https://wapt.tranquil.it/debian/wapt-1.8/ $(lsb_release -c -s) main" > /etc/apt/sources.list.d/wapt.list

Installing the WAPT Server packages
"""""""""""""""""""""""""""""""""""

.. code-block:: bash

    apt-get update
    apt-get install tis-waptserver tis-waptsetup

Post-configuring
""""""""""""""""

.. attention::

  For post-configuration to work properly, you must first have properly
  configured the *hostname* of the WAPT server. To check *hostname*
  configuration use the command :code:`echo $(hostname)` which must return
  the *hostname* that will be used by WAPT agents on client computers.

.. hint::

  This post-configuration script must be run as **root**.

* run the script:

  .. code-block:: bash

        /opt/wapt/waptserver/scripts/postconf.sh

* click on :guilabel:`Yes` to run the postconf script:

  .. code-block:: bash

     do you want to launch post configuration tool?

            < yes >          < no >

* enter the password for the :term:`SuperAdmin` account
  of the WAPT Server (minimum 10 caracters);

  .. code-block:: bash

    Please enter the wapt server password (min. 10 characters)

    *****************

    < OK >          < Cancel >

* confirm the password;

  .. code-block:: bash

    Please enter the server password again:

    *****************

    < OK >          < Cancel >

* choose the authentication mode for the initial registering of the WAPT agents;

  * choice #1 allows to register computers without authentication
    (same method as WAPT 1.3). The WAPT server registers all computers that ask;

  * Choice #2 activates the initial registration based on Kerberos. (you can activate it later)

  * choice #3 does not activate the Kerberos authentication mechanism
    for the initial registering of machines equipped with WAPT.
    The WAPT server will require a login and password for each machine
    registering with it;

    .. code-block:: bash

      WaptAgent Authentication type?

      -------------------------------------------------------------------------------------------------------------------------------------
      (*) 1 Allow unauthenticated registration, same behavior as wapt 1.3
      ( ) 2 Enable kerberos authentication required for machines registration. Registration will ask for password if kerberos not available
      ( ) 3 Disable Kerberos but registration require strong authentication
      -------------------------------------------------------------------------------------------------------------------------------------
                                                         < OK >          < Cancel >

* select :guilabel:`OK` to start WAPT Server;

  .. code-block:: bash

    Press OK to start waptserver

           < OK >

* select :guilabel:`Yes` to configure Nginx;

  .. code-block:: bash

     Do you want to configure nginx?

        < Yes >        < No >

* enter the :term:`FQDN` of the WAPT Server;

  .. code-block:: bash

     FQDN for the WAPT server (eg. wapt.mydomain.lan)

     ---------------------------------------------
     wapt.mydomain.lan
     ---------------------------------------------

           < OK >          < Cancel >

* select :guilabel:`OK` and a self-signed certificate will be generated,
  this step may take a long time ...

  .. code-block:: bash

    Generating DH parameters, 2048 bit long safe prime, generator 2
    This is going to take a long time
    .......................................+...............................+...

Nginx is now configured, select :guilabel:`OK` to restart :program:`Nginx`:

.. code-block:: bash

  The Nginx config is done.
  We need to restart Nginx?

         < OK >

The post-configuration is now finished.

.. code-block:: bash

   Postconfiguration completed.
   Please connect to https://wapt.mydomain.lan/ to access the server.

                    < OK >

Listing of post-configuration script options:

.. tabularcolumns:: |\X{2}{12}|\X{10}{12}|

=============== ================================================================
Flag            Definition
=============== ================================================================
*--force-https* Configures :program:`Nginx` so that *port 80
                is permanently redirected to 443*
=============== ================================================================


The WAPT Server is now ready.

You may go to the documentation on :ref:`installing the WAPT console
<installing_the_WAPT_console>`!!
