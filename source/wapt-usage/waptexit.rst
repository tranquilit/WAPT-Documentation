.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
   :description: Using WAPTExit
   :keywords: WAPT, shutdown, shutting down, documentation

.. _waptexit:

Using WAPTExit
==============

:program:`waptexit` allows to upgrade and install WAPT packages
when a host is shutting down.

The mechanism is simple. If packages are waiting to be upgraded,
they'll be installed at shutdown.

.. hint::

  When to use WAPTexit?

  The WAPTexit method is very effective in most situation because it does
  not require the intervention of the :term:`User` or the :term:`Administrator`
  and it happens at a time when the User normally no longer needs the computer.

.. figure:: waptexit.png
  :align: center
  :alt: WAPTexit window

  WAPTexit window

  WAPTexit

.. raw:: html

  <iframe width="560" height="315" src="https://www.youtube.com/embed/vjFgpxrWESk?rel=0&amp;showinfo=0" frameborder="0" allowfullscreen></iframe>

:program:`waptexit` is a local group policy script executing at shutdown;
it is installed by default with the WAPT agent.

The behavior of :program:`waptexit` is customizable in
:file:`C:\\Program Files (x86)\\wapt\\wapt-get.ini`.

Manually triggering the execution of WAPTexit
---------------------------------------------

By creating a desktop shortcut, we can allow users to launch upgrades
by themselves at a time that is convenient to them simply by clicking
the :guilabel:`WAPTexit` icon.

The behavior of :program:`waptexit` is customizable in
:file:`C:\\Program Files (x86)\\wapt\\wapt-get.ini`.

Avoiding the cancellation of upgrades
-------------------------------------

To disable the interruption of the installation of updates you can
run :program:`waptexit` with the argument:

.. code-block:: bash

  waptexit.exe -allow_cancel_upgrade=True

Otherwise :program:`waptexit` will take the value indicated in
:file:`C:\\Program Files (x86)\\wapt\\wapt-get.ini`:

.. code-block:: ini

   [global]
   allow_cancel_upgrade = 0

If this value is not indicated in
:file:`C:\\Program Files (x86)\\wapt\\wapt\\wapt-get.ini`,
then the default value will be **10**.

Increase the trigger time in waptexit
-------------------------------------

To specify the waiting time before the automatic start of the installations
you can start :program:`waptexit` with the argument:

.. code-block:: bash

  waptexit.exe -waptexit_countdown=10000

Otherwise :program:`waptexit` will take the value indicated
in the configuration :file:`C:\\Program Files (x86)\\wapt\\wapt-get.ini`:

.. code-block:: ini

   [global]
   waptexit_countdown = 25

If this value is not indicated in
:file:`C:\\Program Files (x86)\\wapt\\wapt\\wapt-get.ini`,
then the default value will be **1**.

Do not interrupt user activity
------------------------------

To tell WAPT not to run an :command:`upgrade` of running software
on the machine (*impacted_process* attribute of the package), you can run
:program:`waptexit` with the argument:

.. code-block:: bat

  waptexit.exe -only_if_not_process_running=True

Otherwise :program:`waptexit` will take the value indicated in
:file:`C:\\Program Files (x86)\\wapt\\wapt-get.ini`:

.. code-block:: ini

   [global]
   upgrade_only_if_not_process_running = True

If this value is not indicated in
:file:`C:\\Program Files (x86)\\wapt\\wapt\\wapt-get.ini`,
then the default value will be **False**.

Launching the installation of packages with a special level of priority
-----------------------------------------------------------------------

To tell WAPT to run only the installations of packages with high priority,
you can run :program:`waptexit` with the argument:

.. code-block:: bat

  waptexit.exe -priorities=high

Otherwise :program:`waptexit` will take the value indicated in
:file:`C:\\Program Files (x86)\\wapt\\wapt-get.ini`:

.. code-block:: ini

   [global]
   upgrade_priorities = high

If this value is not indicated in
:file:`C:\\Program Files (x86)\\wapt\\wapt\\wapt-get.ini`, then the default value
will be **Empty** (no filter on priority).

Customizing WAPTexit
--------------------

It is possible to customize waptexit by placing the image you want
in :file:`C:\\Program Files (x86)\\wapt\\templates\\waptexit-logo.png`.

Registering/ unregistering WAPTexit
-----------------------------------

To register or unregister :program:`waptexit` in local shutdown group strategy
scripts, use:

* to enable :program:`waptexit` at host shutdown:

.. code-block:: bash

   wapt-get add-upgrade-shutdown

* to disable :program:`waptexit` at host shutdown:

.. code-block:: bash

   wapt-get remove-upgrade-shutdown
