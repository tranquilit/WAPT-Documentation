.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Deploying the WAPT agent for Windows
  :keywords: waptagent.exe, waptsetup.exe, deployment, deploy, deploying,
             documentation, WAPT

.. _install_waptagent:

Deploying the WAPT agent for Windows
====================================

Two methods are available to deploy the :program:`waptagent.exe`.

The first method is manual and the procedure must be applied on each machine.

The second one is automated and relies on :abbr:`GPO (Group Policy Objects)`.

.. note::

  The :program:`waptagent.exe` installer is available at
  http://<wapt.mydomain.lan>/wapt/waptagent.exe.

  If you do not sign the :program:`waptagent.exe` installer with a commercial
  ``Code Signing`` certificate or a ``Code Signing`` certificate issued
  by the :term:`Certificate Authority` of your Organization
  after having generated it, web browsers will show a warning message
  when downloading the installer. To remove the warning message, you must
  sign the :mimetype:`.exe` with a ``Code Signing`` certificate
  that can be verified by a CA bundle stored in the machine's certificate store.

.. hint:: When to deploy the WAPT agent manually?

  Manual deployment method is efficient in these cases:

  * testing WAPT;

  * using WAPT in an organization with a small number of computers, etc;

Deploying waptagent.exe automatically
-------------------------------------

.. attention::

  This operation requires :term:`Local Administrator` rights
  on the local computer.

Installing *waptagent.exe*
++++++++++++++++++++++++++

* choose the language and click on :guilabel:`Next` to go to next step;

  .. figure:: waptdeploy-choose-language.png
    :align: center
    :alt: Choose the installation language

    Choose the installation language

* accept the license terms and click on :guilabel:`Next` to go to next step;

  .. figure:: waptdeploy-accept-license.png
    :align: center
    :alt: Accepting the EULA

    Accepting the EULA

* choose the installation directory and click on :guilabel:`Next`
  to go to next step;

  .. figure:: waptdeploy-choose-installation-folder.png
    :align: center
    :alt: Select the installation folder for the WAPT agent

    Select the installation folder for the WAPT agent

* choose the additional parameters and click on :guilabel:`Next`
  to go to next step;

  .. hint::

    leave :guilabel:`Force-reinstall VC++ enabled` checked. If the option box
    is ticked it is because its installation is necessary.

  .. figure:: wapdeply-select-additional-tasks.png
    :align: center
    :alt: Choose the installer's options

    Choose the installer's options

* choose the WAPT repository and the WAPT Server and click on :guilabel:`Next`
  to go to next step;

  .. figure:: waptdeploy-choose-repo-and-server-url.png
    :align: center
    :alt: Choose the WAPT repository and server

    Choose the WAPT repository and server

* install the WAPT agent by clicking on :guilabel:`Install`;

  .. figure:: waptdeploy-ready-to-install.png
    :align: center
    :alt: Summary of installation options

    Summary of installation options

* wait for the installation of the WAPT agent to finish,
  then click on :guilabel:`Finish` to exit;

  .. figure:: waptdeploy-installation-in-progress.png
    :align: center
    :alt: Installation in progress

    Installation in progress

The installation of the WAPT agent is finished. With :program:`cmd.exe`,
launch a :command:`register` to register the machine with the WAPT Server
and an :command:`update` to display the list of available WAPT packages.

.. figure:: waptdeploy-installation-finished.png
  :align: center
  :alt: End of WAPT agent installation

  End of WAPT agent installation

.. note::

  * tick :guilabel:`Register this host on WAPT Server` to register
    the computer on the WAPT inventory server;

  * tick :guilabel:`Update package list from repository` to update
    the list of available packages;

To manage your Organization's WAPT clients, visit
the :ref:`documentation on using the WAPT console <using_the_WAPT_console>`.

Deploying automatically the WAPT agents
---------------------------------------

.. important:: Technical pre-requisites

  Advanced network and system administration knowledge is required
  to achieve this procedure. A properly configured network
  will ensure its success.

.. hint::

  When to deploy the WAPT agent automatically? The following method is useful
  in these cases:

  * a large organization with many computers;

  * a Samba Active Directory or Microsoft Active Directory for which
    you have enough administration privileges;

  * the security and the traceability of actions are important to you
    or to your :term:`Organization`;

  * or just simply, you prefer to act with your head instead
    of your feet ;)

Deploying the WAPT agents silently
++++++++++++++++++++++++++++++++++

Without waptdeploy
""""""""""""""""""

:program:`waptagent.exe` is an *InnoSetup* installer, it can be executed
with these silent switches:

.. code-block:: bash

  waptagent.exe /VERYSILENT

* Additional arguments available for waptdeploy

.. tabularcolumns:: |\X{2}{12}|\X{4}{12}|\X{6}{12}|

=========================== ================================================================= =================================================================================================
Settings                    Value                                                             Description
=========================== ================================================================= =================================================================================================
``/dnsdomain``              mydomain.lan                                                      Domain in :file:`wapt-get.ini` filled in during installation
``/wapt_server``            https://srvwapt.mydomain.lan                                      URL of the WAPT server in :file:`wapt-get.ini` filled in during installation
``/repo_url``               https://repo1.mydomain.lan/wapt                                   URL of the WAPT repository in :file:`wapt-get.ini` filled in during installation
``/StartPackages=``         basic-group                                                       Group of WAPT packages to install by default
``/verify_cert=``           1 or relative path :file:`ssl\\server\\srvwapt.mydomain.lan.crt`  Value of ``verify_cert`` entered during installation
``/CopyServersTrustedCA``   path to a bundle to copy to :file:`ssl\server`                    Certificate bundle for https connections (to be defined by ``verify_cert``)
``/CopypackagesTrustedCA``  path to a certificate bundle to copy into :file:`ssl`             Certificate bundle for verifying package signatures
=========================== ================================================================= =================================================================================================

.. hint::

  The :file:`iss` file for the InnoSetup installer is available here:
  :file:`C:\\Program Files (x86)\\wapt\\waptsetup\\waptsetup.iss`.

  You may choose to adapt it to your specific needs. Once modified,
  you'll just have to recreate a :program:`waptagent`.

  To learn more about the options available with *InnoSetup*, visit
  `this documentation <http://www.jrsoftware.org/ishelp/index.php?topic=setupcmdline.us>`_.

With waptdeploy
"""""""""""""""

:program:`waptdeploy` is a small binary that:

* checks the version of the WAPT agent;

* downloads via https the :program:`waptagent.exe` installer;

* launches the silent installer with arguments (checked options defined
  during the compilation of the WAPT agent);

.. code-block:: bash

  /VERYSILENT /MERGETASKS= ""useWaptServer""

* updates the WAPT Server with the WAPT agent status (WAPT version, package status);

  .. note::

    :program:`waptdeploy` must be started as :term:`Local Administrator`,
    that is why we advise you to use a GPO.

Creating a GPO to deploy the WAPT agents
++++++++++++++++++++++++++++++++++++++++

Download :file:`waptdeploy.exe` by visiting:
http://wapt.tranquil.it/wapt/releases/latest/waptdeploy.exe.

Creating the GPO
""""""""""""""""

* create a new group strategy called **install_wapt** on the Active Directory
  server (Microsoft or Samba-AD);

* add a new strategy: :menuselection:`Computer configuration --> Strategies
  --> Windows configuration --> Scripts --> Startup --> Add`;

  .. figure:: waptdeploy-add-gpo.png
    :align: center
    :alt: Creating a group strategy to deploy the WAPT agent

    Creating a group strategy to deploy the WAPT agent

* click on :guilabel:`Browse` to select the :file:`waptdeploy.exe` script;

  .. figure:: waptdeploy-browse.png
    :align: center
    :alt: Finding the waptdeploy.exe file on your computer

    Finding the waptdeploy.exe file on your computer

* copy :file:`waptdeploy.exe` in the destination folder;

  .. figure:: waptdeploy-copy-waptdeploy.png
    :align: center
    :alt: Selecting the waptdeploy.exe script

    Selecting the waptdeploy.exe script

* click on :guilabel:`Open` to import the :file:`waptdeploy.exe` script;

  .. figure:: waptdeploy-select-file.png
    :align: center
    :alt: Selecting the waptdeploy.exe script

    Selecting the waptdeploy.exe script

* click on :guilabel:`Open` to confirm the importation
  of the :program:`waptdeploy` binary;

Passing arguments
"""""""""""""""""

.. hint::

  Starting with version 1.3.7, it is necessary to provide the checksum
  of the :file:`waptagent.exe` as an argument to the *waptdeploy* GPO.

  This will prevent the remote machine from executing an erroneous/ corrupted
  :program:`waptagent` binary.

  .. code-block:: bash

    --hash="checksum du WaptAgent"--minversion=1.5.1.23 --wait=15

.. note::

  Parameters and :program:`waptagent.exe` checksum to use
  for the *waptdeploy* GPO are available on the WAPT Server by visiting
  https://<wapt.mydomain.lan>.

  .. figure:: waptdeploy-copy-parameters.png
    :align: center
    :alt: Web console of the WAPT Server

    Web console of the WAPT Server

* copy the required parameters;

  .. figure:: waptdeploy-add-extra-parameter.png
    :align: center
    :alt: add the *waptdeploy* script to the startup GPO

    add the *waptdeploy* script to the startup GPO

* click on :guilabel:`OK` to go on to the next step;

  .. figure:: waptdeploy-gpo-ready.png
    :align: center
    :alt: WAPTdeploy GPO to be deployed on next startup

    WAPTdeploy GPO to be deployed on next startup

* click on :guilabel:`OK` to go on to the next step;

* apply resulting GPO strategy to the Organization's Computers :abbr:`OU
  (Organizational Units)`;

Additional arguments available for waptdeploy
"""""""""""""""""""""""""""""""""""""""""""""

.. tabularcolumns:: |\X{2}{12}|\X{4}{12}|\X{6}{12}|

=================== ==================================================================== ================================================================================================
Settings            Value                                                                Description
=================== ==================================================================== ================================================================================================
``--force``                                                                              Forces the installation of :program:`waptagent.exe` even if the WAPT agent is already installed
``--waptsetupurl``  https://wapt/wapt/waptagent.exe                                      Gives explicitly the WAPT agent URL/path to use to download the WAPT agent
``--tasks``         autorunTray,installService,installredist2008,autoUpgradePolicy       Sets :program:`waptagent` installation tasks
``--wait``          10                                                                   Timeout for installing the WAPT agent.
``--setupargs=``    /dnsdomain=mydomain.lan /wapt_server= /repo_url=                     Passing additional parameters to :program:`waptagent`
=================== ==================================================================== ================================================================================================

.. code-block:: bash

  --hash="43254648348435423486"--minversion=1.5.1.23 --waptsetupurl=http://srvwapt.mydomain.lan/waptagent.exe --wait=10

Launching waptdeploy with a scheduled task
++++++++++++++++++++++++++++++++++++++++++

For :program:`waptdeploy` to work best, you may execute the GPO
upon computer shutdown;

You may also choose to launch :program:`waptdeploy` using a scheduled task
that has been set by GPO.

.. hint::

  This method is particularly effective for deploying WAPT on workstations
  when the network is neither available on starting up or shutting down.

The method consists of using a GPO to copy :file:`waptdeploy.exe`
and :file:`waptagent.exe`:

* Source : :file:`\\mydomain.lan\\netlogon\\waptagent.exe`

* Destination : :file:`C:\\windows\\temp\\waptagent.exe`

  .. figure:: waptdeploy-filecopy-waptdeploy.png
    :align: center
    :alt: WAPT agent installation progress

    WAPT agent installation progress

* copy :file:`waptdeploy.exe` and :file:`waptagent.exe`
  in the netlogon share of your Active Directory Server;

* then create a GPO to set up a scheduled task that will launch
  :program:`waptdeploy`:

  .. code-block:: bash

    C:\windows\temp\waptdeploy.exe

  Arguments:

  .. code-block:: bash

    --hash="43254648348435423486"--minversion=1.5.1.23 --waptsetupurl=C:\windows\temp\waptagent.exe --wait=10

  .. figure:: waptdeploy-installtask-waptdeploy.png
    :align: center
    :alt: Task installation properties

    Task installation properties

* choose a time after which the scheduled task will trigger
  and set the re-triggering of the task every 30 minutes until success:

  .. figure:: waptdeploy-launchtime.png
    :align: center
    :alt:   Advanced properties of the installation task

    Advanced properties of the installation task

* allow the scheduled task to start even if the device is powered on battery:

  .. figure:: waptdeploy-power-management.png
    :align: center
    :alt: Power settings

    Power settings

Uninstall WAPT agent from clients
---------------------------------

If you need to uninstall WAPT agents from clients,
the uninstaller is automatically created in the WAPT install location,
by default it is :file:`C:\\Program Files (x86)\\wapt\\unins000.exe`.

* default silent uninstall of WAPT agent can be achieved
  with the following command:

   .. code:: bash

      unins000.exe /VERYSILENT

* an additional argument can be passed to :command:`unins000.exe`
  to cleanup everything:

   .. code:: bash

      unins000.exe /VERYSILENT /purge_wapt_dir=1


Complete list of command-line arguments for :command:`unins000.exe`:

===================== =====================================================
Settings              Description
===================== =====================================================
``/VERYSILENT``       Launches unins000.exe silently
``/purge_wapt_dir=1`` Purges WAPT directory (removes all folders and files)
===================== =====================================================
