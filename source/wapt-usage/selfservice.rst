.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
   :description: Using WAPTtray.
   :keywords: WAPT, Tray, documentation

.. _wapt-selfservice:

Using WAPT SelfService
================================

Presentation
--------------------

With wapt 1.7 you can now filter the list of self-service packages for your users.

Your users will be able to install apt packages without having to be an administrator of their pc.

They are therefore more autonomous and this saves them from calling the help desk.


How it works ?
--------------------

Since wapt 1.7 you can now create SelfService type packages

This package can be installed on the machines to tell them the different self service rule that must apply.


Use
-----

In the console go to the tab Self-service rules

You can now create your first selfservice rule paquet

- Give a name to this package

- Now click on add for add AD group (At the bottom left)

- Enter the group name (With F2 or type directly into the cell)

- You can now drag the allowed packages for this group into the central column.

- Add as many groups as you want in this package

- You can now save this package and start its installation on the computers

- Once this package is installed, the self-service takes into account these new rules when access to it.


.. note::

	If a group appears in multiple selfservice packages, then the rules will be merged.
	
.. figure:: wapt_console-selfservice.png
   :align: center
   :alt: Create self service package

   Create self service package