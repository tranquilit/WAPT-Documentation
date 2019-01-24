.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Using the WAPT console
  :keywords: WAPT, console, documentation

.. _wapt_console:

.. versionadded:: 1.7

Uses of windows update
====================================


.. note::

	Since version 1.7, wapt is able to manage Windows updates on your parc.

	The operation of waptwua is based on "Windows Update Agent API".

	For more information : https://docs.microsoft.com/en-us/windows/desktop/wua_sdk/using-the-windows-update-agent-api


Principle
-----------

Regularly, the wapt server downloads a file "wsuscn2.cab" from the Microsoft server. (once a day, the files will not be downloaded if they have not changed since the last download.)

The wsuscn2.cab file will allow the Windows Update Agent to check for the necessary updates on the machine. (The wapt agent directly download the wsuscn2.cab file from wapt server)

Regularly, the machine will analyze the available updates with this file. The list is then sent to the wapt server.

If an update is pending on the machine, if this update is not present on the wapt server, then the wapt server will download this update.

This mode of operation allows you to download only updates necessary for your parc.

.. note:: 

	All updates are stored in the waptwua folder of the wapt server.

	On linux : /var/www/waptwua
	
	And on windows : 
	
	C:\\wapt\\waptserver\\repository\\waptwua
	
.. hint::

	The update windows update download is based on repo_url in wapt-get.ini
	
	Your secondary repository will be fully operational with wapt windows update to reduce bandwidth.
	
	Be careful, do not forget to synchronize the waptwua folder.
	
	
Configure waptwua on the wapt agent
--------------------------------------------

To configure waptwua you can configure it in the wapt-get.ini file.

Add a waptwua section  : [waptwua]

You then have several options :

.. tabularcolumns:: |\X{5}{12}|\X{7}{12}|

====================================== ==================================== =========================================================================================================================
Options                                Default Value               			Description
====================================== ==================================== =========================================================================================================================
``enabled``                            False                       			Enable or disable waptwua on this machine.
``offline``                            True                        			Defined if the scan should be with the files wsuscn2.cab or Online with the microsoft servers.
``allow_direct_download``        	   False						        Allow direct download of updates from microsoft servers if the wapt server is not available.
``default_allow``                      False                                Set if missing update is accepted or not by default.
``filter``                             Type='Software' or Type='Driver'     Define the filter to apply for the update scan windows update       
``download_scheduling``				   None                                 Set the windows update scan recurrence (Will not do anything if wsus rule or wsuscn2.cab file have not changed) (ex: 2h)
``install_scheduling``                 None                                 Set the windows update install recurrence (Will not do anything if no update is pending) (ex: 2h)
``install_delay``                      None                                 Set a deferred installation time since online publication    (ex: 7d)
====================================== ==================================== =========================================================================================================================

.. hint::

	All of these options can be set when generating the agent.
	
	
Use waptwua from the console
--------------------------------------------

You have a tab "windows update" in the console wapt

Wapt WuaPackage
+++++++++++++++++






