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

Uses of Reporting
====================================

Principle
-----------

We decided with wapt to propose a complete report. 

Indeed, who better than you know what you want in your report.

With wapt we propose to write your own sql query to display the result in the wapt console.
	
	
	
Design and use Query
--------------------------------------------

In the "reporting" tab, click "Design Mode" and "New query"

To change the name of the request, use the F2 key

In the top banner, you can then write your sql query.

.. hint::

	The shortcut CTRl space offers you some choices directly.
	
You can test your requests with the "Execute" button

When you have finished writing your query, you can click save queries.

.. note::

	The queries are saved in the postgresql wapt database.
	
The "reload requests" button is used to reload requests saved on the server. (For example, if a colleague has just saved a query.)

- Deleting the query will delete the query from the wapt server.

- The duplicate button allows you to copy an existing query to avoid writing a request from scratch.


.. hint::

	You can export the result of your requests to excel with the "export to excel" button
	

.. figure:: wapt_console-report-design.png
  :align: center
  :alt: Design


Normalize the name of the software
------------------------------------------------

One of the main problem with software research is that a software may have several different names and different uninstall keys depending on the version.

To solve this problem, we propose to standardize the name of the software with wapt.

Click "Normalize Software Names" in the "Tools" menu.

Select the software to standardize. (for example, all different version of flash player)

To select several programs, select them with the shift-flech key combination

On the column "normalized", press F2 to assign a standardized name to the selected software. Then on enter

You can also indicate a software like "windows update" or "banned" (Replace "Press F2" with "Press spacebar" in the corresponding column)

- Press on write to save the changes

- Press on import to load the changes from the server

You can now search on this standardized name.


.. figure:: wapt_console-report-normalize.png
  :align: center
  :alt: Normalize
