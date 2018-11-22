.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
   :description: Using the local web interface
   :keywords: WAPT, interface web, documentation

.. _wapt_web_interface:

Using the local web interface
=============================

Users and Local Administrators may access informations and perform WAPT actions
directly from the host by visiting http://localhost:8088.

Opening the WAPT web interface
------------------------------

The WAPT web interface opens by :menuselection:`Right-clicking on the WAPT icon
in the Windows notification tray --> View software status`.

It is also accessible directly from a web browser by visiting
http://localhost:8088.

.. figure:: wapt_web_interface.png
  :align: center
  :alt: WAPT web interface

  WAPT web interface

.. raw:: html

   <iframe width="560" height="315" src="https://www.youtube.com/embed/s2YerEWr_Wg?rel=0&amp;showinfo=0" frameborder="0" allowfullscreen></iframe>

Description of the WAPT web interface
-------------------------------------

The WAPT agent web interface is composed of 4 tabs:

* the :guilabel:`WAPT` tab that shows the status of the host and some system
  related informations;

* the :guilabel:`Installed packages` tab that lists the packages
  that are installed on the host;

* the :guilabel:`List of packages` that lists the WAPT packages available
  on registered repositories;

* the :guilabel:`Tasks` that lists tasks in *pending*, *done* and
  *error* states;

Available actions from the WAPT agent web interface
---------------------------------------------------

.. note::

  * viewing host information, updating and upgrading actions are available
    for every users;

  * Other actions need :term:`Local Administrator` rights; they are also
    available to users who are members of the *waptselfservice*
    Active Directory security group.

* Refreshing the list of available package:

  In the tab :menuselection:`List of packages --> Update available packages`.

* Installing a package:

  In the tab :menuselection:`List of packages --> Install` the desired package.

* clearing the cache:

  In the tab :menuselection:`List of packages --> Clear package cache`.
