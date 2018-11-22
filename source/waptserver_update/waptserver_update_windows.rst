.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Performing minor updates on a Windows based WAPT Server
  :keywords: Windows, WAPT, documentation, examples, update, updating

.. _wapt_minor_upgrade_windows:

Performing minor updates on a Windows based WAPT Server
-------------------------------------------------------

.. attention::

  In the case you choose to use a :abbr:`GPO (Group Policy Object)`
  to upgrade the WAPT agent, the WAPT Server must be excluded
  from the :abbr:`OU (Organizational Unit)` where the GPO will apply.

.. note::

  The WAPT Server may be installed on 64bit Windows 7 and Windows 10 clients,
  and 64 bit Windows Server 2008/R2, 2012/R2 and 2016.2, 2012/R2, 2016
  and 2019.

* on the Windows machine hosting the WAPT Server, download the latest version
  of the installer from Tranquil IT's website `WAPTServerSetup.exe <http://wapt.tranquil.it/wapt/releases/latest/waptserversetup.exe>`_
  and launch it as :term:`Local Administrator`;

* install the update;

.. note::

  The procedure to follow is the same as the one for :ref:`installing a WAPT Server on Windows <wapt-server_win_install>` .

.. attention::

  **The prefix must not be changed and you must not generate a new key!**

* on the workstation that you use to build your packages, manually
  download WAPTSetup from https://wapt.tranquil.it/wapt/releases/latest/waptsetup.exe.

* then :ref:`create the WAPT agent <create_WAPT_agent>`:

  You will have to keep the same prefix for your packages and change nothing
  in relation to the private key/ public certificate pair!

  This will generate a **waptupgrade** package in the private repository.

  .. note::

    There are two methods for deploying the updates:

    * using a :abbr:`GPO (Group Policy Object)` and :program:`waptdeploy`;

    * using a :program:`waptupgrade` package and deploy it using WAPT;

* update the WAPT agents

 The steps to follow to update WAPT agents are the same as the ones to
 first install the WAPT agents.

 Download and install the latest version of the WAPT agent
 by visiting http://wapt.mydomain.lan/wapt/waptagent.exe.

 As mentioned above, this procedure may be made automatic
 with a GPO or a **waptupgrade** package.
