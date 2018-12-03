.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
    :description: Building the WAPT agent installer
    :keywords: waptagent.exe, installeur, InnoSetup, documentation, WAPT

.. _create_WAPT_agent:

Building the WAPT agent installer
=================================

The :program:`waptagent` binary is an InnoSetup installer.

Once the WAPT console has been installed on the :term:`Administrator` computer,
we have all files required to build the WAPT agent installer.

* files that will be used during building of the WAPT agent are located
  in :file:`C:\Program Files (x86)\wapt`;

* installer source files (:file:`.iss` files) are located
  in :file:`C:\Program Files (x86)\wapt\waptsetup`;

.. hint::

  Before building the WAPT agent, please verify the public certificate(s)
  in :file:`C:\Program Files (x86)\wapt\ssl`.

  If you wish to deploy other public certificates on your :term:`Organization`'s
  computers that are equipped with WAPT, you will have
  to copy them in that folder.

.. danger::

  **DO NOT COPY the private key** of any :term:`Administrator`
  in :file:`C:\Program Files (x86)\wapt`.

  This folder is used when building the WAPT agent and the private keys
  would then be deployed on all the computers.

* In the WAPT console, go to :menuselection:`Tools --> Build the WAPT agent`.

.. figure:: waptagent-menu_generate_waptagent.png
  :align: center
  :alt: Generate the WAPT agent from the console

  Generate the WAPT agent from the console

* fill in the informations that are necessary for the installer:

  * the field :guilabel:`Public certificate`: *required**;

    example : :file:`C:\private\mydomain.crt`

  * the field :guilabel:`Address of the WAPT repository`: **required**;

    example : https://srvwapt.mydomain.lan/wapt

  * the field :guilabel:`Address of the WAPT Server`: **required**;

    example : https://srvwapt.mydomain.lan

  * the checkbox :guilabel:`Verify the WAPT Server HTTPS certificate`;

  * the field :guilabel:`Path to the bundle of certificates` to verify
    the HTTPS certificate of the WAPT Server;

  * the checkbox :guilabel:`Use Kerberos for registering WAPT agents`;

  * the field :guilabel:`Organization` to identify the origin of WAPT packages;

.. figure:: waptagent-organisation-info.png
  :align: center
  :alt: Fill in the informations on your Organisation

  Fill in the informations on your Organisation

.. danger::

   The checkbox **Use Kerberos for the initial registration** must be checked
   **ONLY IF** you have followed the documentation
   on **Configuring the Kerberos authentication**.

* provide the password for unlocking the private key:

.. figure:: ../../wapt-common-resources/enter-certificate-password.png
  :align: center
  :alt: Provide the password for unlocking the private key

  Provide the password for unlocking the private key

.. figure:: waptagent-creation-in-progress.png
  :align: center
  :alt: Progression of WAPT agent installer building

  Progression of WAPT agent installer building

Once the WAPT agent installer has finished building, a confirmation dialog
pops up indicating that the :program:`waptagent` binary
has been successfully uploaded to https://srvwapt/wapt/.

.. figure:: waptagent-successfully-uploaded.png
  :align: center
  :alt: Confirmation of the WAPT agent loading onto WAPT repository

  Confirmation of the WAPT agent loading onto WAPT repository

.. note::

  A warning shows up indicating that the GPO hash value should be changed.
  GPOs may be used to deploy the WAPT agent on your Organization's computer.

Package *test-waptupgrade*
""""""""""""""""""""""""""

The ``test-waptupgrade`` package has also been uploaded on the repository.

The ``test-waptupgrade`` package contains the WAPT agent with arguments
specified during the installation of WAPT on your Administrator's computer.

.. figure:: waptagent-new-agent-in-repository.png
  :align: center
  :alt: New WAPT agent in the repository

  New WAPT agent in the repository

.. note::

  This package is a standard WAPT package designed
  to upgrade WAPT agents on client machines.
