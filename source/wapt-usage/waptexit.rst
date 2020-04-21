.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
   :description: Using WAPTExit
   :keywords: WAPT, shutdown, shutting down, documentation

.. _waptexit:

Using WAPTExit
==============

:program:`waptexit` allows to upgrade and install WAPT packages
when a host is shutting down, at the user's request, or at a scheduled time.

The mechanism is simple. If packages are waiting to be upgraded,
they'll be installed.

.. hint::

  When to use WAPTexit?

  The WAPTexit method is very effective in most situation because it does
  not require the intervention of the :term:`User` or the :term:`Administrator`.

.. figure:: waptexit.png
  :align: center
  :alt: WAPTexit window

  WAPTexit window

  WAPTexit

.. raw:: html

  <iframe width="560" height="315" src="https://www.youtube.com/embed/vjFgpxrWESk?rel=0&amp;showinfo=0" frameborder="0" allowfullscreen></iframe>

:program:`waptexit` executes by default on shutdown;
it is installed by default with the WAPT agent.

The behavior of :program:`waptexit` is customizable in
:file:`C:\\Program Files (x86)\\wapt\\wapt-get.ini`.

Manually triggering the execution of WAPTexit
---------------------------------------------

By creating a desktop shortcut, one can allow users to launch upgrades
by themselves at a time that is convenient to them simply by clicking
the :guilabel:`WAPTexit` icon.

The behavior of :program:`waptexit` is customizable in
:file:`C:\\Program Files (x86)\\wapt\\wapt-get.ini`.

Triggering WAPTexit with a scheduled task
-----------------------------------------

One can deploy a GPO or a WAPT package that will trigger WAPTexit
at a pre-scheduled time.

**Triggering WAPTexit with a scheduled task is best suited for servers
that are not shutdown frequently.**

You may adapt the procedure describing how to deploy the WAPT agent
to :ref:`trigger the WAPTexit.exe script at the time
of your choosing <deploy_waptagent_with_GPO>`.

.. hint::

  You can use the following script for your scheduled task, adapted to your need
  (**Enterprise only**):

  .. code-block:: python

    waptpython -c "from waptenterprise.waptservice.enterprise import start_waptexit;
    start_waptexit('',{'only_priorities':False,'only_if_not_process_running':True,
    'install_wua_updates':False,'countdown':300},'schtask')"

.. warning::

  All running software that are upgraded may be killed with possible loss of data.
  WAPTexit may fail to upgrade a software program if a software
  that you are upgrading is in the ``impacted_process`` list
  of the :file:`control` file of one of the software you are trying to upgrade.
  See :ref:`below <impacted_process>` for more information.

  The method of trigerring WAPTexit at a scheduled time
  is the least recommended method for desktops. It is better
  to let WAPTexit execute at shutdown or on user request.

Avoiding the cancellation of upgrades
-------------------------------------

To disable the interruption of the installation of updates you can
run :program:`waptexit` with the argument:

.. code-block:: bash

  waptexit.exe -allow_cancel_upgrade = True

Otherwise :program:`waptexit` will take the value indicated in
:file:`C:\\Program Files (x86)\\wapt\\wapt-get.ini`:

.. code-block:: ini

   [global]
   allow_cancel_upgrade = False

If this value is not indicated in
:file:`C:\\Program Files (x86)\\wapt\\wapt\\wapt-get.ini`,
then the default value will be **10**.

Increase the trigger time in waptexit
-------------------------------------

To specify the wait time before the automatic start of the installations
you can start :program:`waptexit` with the argument:

.. code-block:: bash

  waptexit.exe -waptexit_countdown = 10000

Otherwise :program:`waptexit` will take the value indicated
in the configuration :file:`C:\\Program Files (x86)\\wapt\\wapt-get.ini`:

.. code-block:: ini

   [global]
   waptexit_countdown = 25

If this value is not indicated in
:file:`C:\\Program Files (x86)\\wapt\\wapt\\wapt-get.ini`,
then the default value will be **1**.

.. _impacted_process:

Do not interrupt user activity
------------------------------

To tell WAPT not to run an :command:`upgrade` of running software
on the machine (*impacted_process* attribute of the package), you can run
:program:`waptexit` with the argument:

.. code-block:: batch

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

To tell WAPT to only upgrade high priority packages,
you can run :program:`waptexit` with the argument:

.. code-block:: batch

  waptexit.exe -priorities = high

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
