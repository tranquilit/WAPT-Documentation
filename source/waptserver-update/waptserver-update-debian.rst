.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Performing minor updates on a Debian based WAPT Server
  :keywords: Debian, WAPT, documentation, examples, update, updating

.. _wapt_minor_upgrade_debian:

Performing minor updates on a Debian based WAPT Server
------------------------------------------------------

.. attention::

  Ports 80 and 443 are used by the WAPT Server and must be available.

* first of all, update the Debian underlying distribution:

  .. code-block:: bash

     apt-get update && apt-get upgrade && apt-get dist-upgrade

* add the package repository for Debian packages, import the GPG key
  from the repository and install the WAPT Server packages:

WAPT Enterprise
+++++++++++++++

.. hint::

   **To access WAPT Enterprise ressources**, you must use the username
   and password provided by our sales department.

   Replace **user** and **password** in the **deb** parameter
   to access WAPT Enterprise repository.

.. code-block:: bash

   apt-get install apt-transport-https lsb-release
   wget -O - https://wapt.tranquil.it/debian/tiswapt-pub.gpg  | apt-key add -
   echo  "deb  https://user:password@srvwapt-pro.tranquil.it/entreprise/debian/wapt-1.8/ $(lsb_release -c -s) main"  > /etc/apt/sources.list.d/wapt.list
   apt-get update
   apt-get install tis-waptserver tis-waptrepo tis-waptsetup

WAPT Community
++++++++++++++

.. code-block:: bash

  apt-get install apt-transport-https lsb-release
  wget -O - https://wapt.tranquil.it/debian/tiswapt-pub.gpg  | apt-key add -
  echo  "deb  https://wapt.tranquil.it/debian/wapt-1.8/ $(lsb_release -c -s) main"  > /etc/apt/sources.list.d/wapt.list
  apt-get update
  apt-get install tis-waptserver tis-waptsetup

Post-configuration
++++++++++++++++++

* launch the post-configuration step

  .. note::

    * we advise that you launch the post-configuration steps after each server
      upgrade so that the server uses the latest configuration format;

    * it is not required to reset a password for the WAPT console during
      the post-configuration step;

    * if you have personalized the configuration of :program:`Nginx`,
      do not answer :guilabel:`Yes` when the post-configuration ask you to
      configure :program:`Nginx`;

  .. attention::

    * with WAPT 1.8 post-configuration, WAPT WUA packages will be moved
      from their current storage location to waptwua
      root folder (:file:`/var/www/waptwua`).

    * if repository replication has been set, all KB/CAB packages
      will be re-synchronized on remote repositories

  .. code-block:: bash

    /opt/wapt/waptserver/scripts/postconf.sh

  The password requested in step 4 is used to access the WAPT console.

* start the WAPT Server:

  .. code-block:: bash

    systemctl restart waptserver

* upgrade the WAPT console by following the same set of steps as
  :ref:`installing the WAPT console <installing_the_WAPT_console>`;

* then :ref:`create the WAPT agent <create_WAPT_agent>`:

  You will have to keep the same prefix for your packages and change nothing
  in relation to the private key/ public certificate pair!

  This will generate a **waptupgrade** package in the private repository.

  .. note::

    There are two methods for deploying the updates:

      * using a :abbr:`GPO (Group Policy Object)` and :program:`waptdeploy`;

      * using a :program:`waptupgrade` package and deploy it using WAPT;

* update the WAPT agents

  The steps to follow to update WAPT agents are the same as the ones to first
  install the WAPT agents.

  Download and install the latest version of the WAPT agent
  by visiting http://wapt.mydomain.lan/wapt/waptagent.exe.

  As mentioned above, this procedure may be made automatic
  with a GPO or a **waptupgrade** package.
