.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
   :description: Using WAPT SelfService
   :keywords: WAPT, selfservice, documentation

.. _wapt-selfservice:

Using WAPT SelfService
======================

Presentation
------------

With WAPT 1.7 **Enterprise** you can now filter the list
of self-service packages available for your users.

Your users will be able to install a selection of WAPT packages
without having to be a :term:`Local Administrator` on their desktop.

The :term:`Users` gain in autonomy while deploying software and configurations
that are trusted and authorized by the :term:`Organization`.
This is a time saving feature for the Organization's IT support Helpdesk.

How it works?
-------------

With WAPT 1.7 **Enterprise**, a new type of WAPT package exists beside *base*,
*group*, *host* and *unit* packages: they are **selfservice** packages.

.. figure:: wapt_console-selfservice.png
  :align: center
  :alt: Create a self-service package

  Create a *selfservice* package

A *selfservice* package may now be deployed on hosts to list the different
self-service rules that apply to the host.

How to use the **selfservice** feature?
---------------------------------------

.. versionadded:: 1.7 Enterprise

.. hint::

  Feature only available with WAPT **Enterprise**.
  In the **Community** version, only Local Administrator users and members
  of the *waptselfservice* group can access self-service on the agent.
  It is not possible to filter the packages made accessible to the user.

In the console go to the tab :guilabel:`Self-service` rules.

You can now create your first *selfservice* rule package.

* give a name to your new *selfservice* package;

* click on :guilabel:`Add` to add an Active Directory group (at the bottom left);

* name the *selfservice* group (with :kbd:`F2` or type directly into the cell);

* drag the allowed software and configuration packages
  for this *selfservice* group into the central column;

* add as many groups as you want in the package;

* save the package and deploy the package on your selection of hosts;

* once the package is deployed, only allowed packages listed
  in the *selfservice* group(s) of which the :term:`User` is a member
  will be shown to the logged in :term:`User`;

.. note::

  If a group appears in multiple *selfservice* packages,
  then the rules are merged.

How to use the selfservice on the user station?
-----------------------------------------------

The self-service is accessible to users in the start menu under the name
:guilabel:`Self-Service software WAPT`.

It is also available directly in :file:`<base>\waptself.exe`

The login and password to enter when launching the selfservice
are the User's credentials (local or Active Directory credentials).

The self-service then displays a list of packages available for installation.

.. figure:: waptself.png
  :align: center
  :alt: Self Service

* the user can have more details on each package with the :guilabel:`+` icon;

* different filters are available for the user on the left side panel;

* the :guilabel:`Update Catalog` button is used to force a
  :command:`wapt-get update` on the wapt agent;

* the list of package categories is dsiplayed to the user.
  To add a category to the list, you must specify the category
  in the *categories* section of the :file:`control` file
  of the relevant package;

* the current task list of the wapt agent is available
  with the ::guilabel:`task bar` button;

* it is possible to change the language of the interface
  with the :guilabel:`configuration` button at the bottom left.

Customization
+++++++++++++

.. hint::

  Feature only available with WAPT **Enterprise**.

It is possible to change the logo that appears in the self-service interface
This will allow you to display the logo of your Organization for example.

To do this, simply place the logo you want in
:file:`<wapt>\\templates\\waptself-logo.png`

.. note::

	It is highly recommended to use a :file:`.PNG` file
  with a 200 * 150px resolution.
