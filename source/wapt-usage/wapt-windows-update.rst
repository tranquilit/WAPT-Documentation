.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Using the WAPT console
  :keywords: WAPT, console, documentation

.. _wapt_wua:

.. versionadded:: 1.7

Using WAPT Windows Update Agent (WAPTWUA)
=========================================

.. note::

	Since version 1.7, WAPT is able to manage Windows Updates on your endpoints.
	 * The internals of WAPTWUA is based on "Windows Update Agent API".
	 * For more information : https://docs.microsoft.com/en-us/windows/desktop/wua_sdk/using-the-windows-update-agent-api


Principle
-----------

Regularly, the WAPT server downloads :file:`"wsuscn2.cab"` file from Microsoft's server. (once a day, the files will not be downloaded if they have not changed since the last download.)

The wsuscn2.cab file will allow WAPT Windows Update Agent to check for necessary updates on the machine. (The WAPT agent directly download the wsuscn2.cab file from WAPT repository)

Regularly, the machine will analyze the available updates with this file. The list is then sent to the WAPT server.

If an update is pending on the machine and if that update is not present on the WAPT server, the server will download that update.

This mode of operation allows you to download only necessary updates for your computers.

.. note:: 

	Downloaded updates are stored in the waptwua folder in the repository.
	 * On Linux servers : :file:`/var/www/waptwua`
	 * On Windows servers :file:`C:\\wapt\\waptserver\\repository\\waptwua`
	
.. hint::

	The WAPT Windows Update Agent repository download URL is based on the :file:`repo_url` in :file:`wapt-get.ini`
	 * In case of repository replication, it's fully operational with WAPT Windows Update to reduce bandwidth usage.
	 * Do not forget to synchronize the waptwua folder.
	
	
Configure WAPTWUA on the WAPT agent
--------------------------------------------

To configure WAPTWUA you can configure it in the :file:`wapt-get.ini` file.

Add a waptwua section  : :file:`[waptwua]`

You then have several options :

.. tabularcolumns:: |\X{5}{12}|\X{7}{12}|

====================================== ==================================== =========================================================================================================================
Options                                Default Value               			Description
====================================== ==================================== =========================================================================================================================
``enabled``                            False                       			Enable or disable WAPTWUA on this machine.
``offline``                            True                        			Defined if the scan should be done using wsuscn2.cab files or Online with the Microsoft servers.
``allow_direct_download``        	   False						        Allow direct download of updates from Microsoft servers if the WAPT server is not available.
``default_allow``                      False                                Set if missing update is authorized or not by default.
``filter``                             Type='Software' or Type='Driver'     Define the filter to apply for the Windows update scan        
``download_scheduling``				   None                                 Set the Windows Update scan recurrence (Will not do anything if wsus rule or wsuscn2.cab file have not changed) (ex: 2h)
``install_scheduling``                 None                                 Set the Windows Update install recurrence (Will not do anything if no update is pending) (ex: 2h)
``install_delay``                      None                                 Set a deferred installation time since online publication    (ex: 7d)
====================================== ==================================== =========================================================================================================================

.. hint::

	These options can be set when generating the agent.
	
	
Use WAPTWUA from the console
--------------------------------------------

The "WAPT Windows Update Agent" tab in the console WAPT groups two sub-menus to manage WAPTWUA

WAPTWUA Package
+++++++++++++++++

The "WAPTWUA Package" tab allows you to create Windows Update rules packages.

* When this type of package is installed on a machine, it indicates to the WAPTWUA agent the authorized or forbidden KBs.
* When several "WAPTWUA Package" packages are installed on a machine, the different rules will be merged.
* When a cab is neither mentioned in authorized nor mentioned prohibited, WAPT agent will then take the value of :file:`default_allow` in wapt-get.ini

If an update has not yet been downloaded to the WAPT server, then the update will be flagged as "MISSING" by the agent.

.. note::

	* If the WAPTWUA agent configuration is set to :file:`default_allow = True`, then it will be necessary to specify the forbidden cab.
	* If the WAPTWUA agent configuration is set to :file:`default_allow = False`, then it will be necessary to specify the authorized cab. 
	

.. hint::

	* To test updates on a small set of computers, you can set WAPTWUA default value to :file:`default_allow = False`.
	* You can test updates for a small set of hosts and if everything is good with thoses, release them for the entire fleet.


.. figure:: wapt_console-wua.png
   :align: center
   :alt: Create WAPTWUA Package

   Create WAPTWUA Package


Windows Updates list tab
++++++++++++++++++++++++++++

The "Windows Update List" tab lists all needed Windows Updates.

The left pane displays updates categories, allowing you to filter by

 * criticality
 * product
 * classificiation.

In the right pane grid, if the "Downloaded on" column is empty, it means that the update was not downloaded by WAPT server and is not present on the server. (This update isn't missing on any post)

 * You can force the download of an update by right-clicking it and click "Download".
 * You can also force the download of the wsusscn2.cab file with the "Download WSUSScan cab from Microsoft Web Site" button
 * You can see the Windows Updates download on the server with the button "show download task"

.. hint::

	To cleanup your WAPTWUA folder, you can remove unnecessary Windows Update. WAPT server will only re-download missing updates on computers.
	
	
.. figure:: wapt-wua-windows-update-list.png
   :align: center
   :alt: List Windows Update

   List Windows Update
	
	
  
WAPT Windows Updates flow process
------------------------------------------------------------------
  
.. figure:: wapt-wua-diagramme-windows-update.png
  :align: center
  :alt: WAPT Windows Update flow process

  WAPT Windows Update flow process
