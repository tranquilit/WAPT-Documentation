.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Using the reporting functions in WAPT
  :keywords: WAPT, console, reporting, SQL, query, PostgreSQL, documentation

.. _wapt_reporting:

.. versionadded:: 1.7 Enterprise

Using the reporting functions in WAPT
=====================================

.. hint::

  Feature only available with WAPT **Enterprise**.

Working principle
-----------------

WAPT **Enterprise** offers advanced reporting capabilities.

Indeed, who better than you to know what you want in your report.

With WAPT we offer to write your own SQL queries to display the result
in the wapt console.

WAPT query Designer
-------------------

The query designer offers you the ability to edit your own queries
on the WAPT PostgreSQL database.

To create a new report, click on
:menuselection:`Reporting --> Design Mode --> New query`.

.. figure:: wapt_console-report-design.png
  :align: center
  :alt: Designing a query in WAPT reporting

  Designing a query in WAPT reporting

.. hint::

 * to rename a query, press the :kbd:`F2` key;

 * in the top banner, you can write your SQL query;

To edit / modify / save your reports:

* the :guilabel:`Reload queries` button is used to reload queries saved
  on the server, for example, if a colleague has just edited a new query;

* the :guilabel:`New query` button will add a new blank query to the list;

* the :guilabel:`Delete query` button will delete the selected
  query from the WAPT server;

* the :guilabel:`Export to Excel` button will export
  the result of your query to a spreadsheet;

* the :guilabel:`Save queries` button will save your query to the WAPT server;

* the :guilabel:`Duplicate` button will duplicate an existing query
  to avoid writing a request from scratch;

* the :guilabel:`Execute` button executes the selected query;

.. note::

 * the queries are saved in the PostgreSQL WAPT database;

 * the shortcut :kbd:`CTRL+space` allows you to build your queries
   more effectively;

Query examples
++++++++++++++

* Computers list:

.. code-block:: sql

  select computer_name,os_name,os_version,os_architecture,serialnr from hosts order by 4,3,1

* Computers MAC addresses and IP:

.. code-block:: sql

  select distinct unnest(mac_addresses) as mac,
  unnest(h.connected_ips) as ipaddress,  computer_fqdn,h.description,
  h.manufacturer||' '||h.productname as model,
  h.serialnr,h.computer_type
  from hosts h
  order by 1,2,3

* Windows versions:

.. code-block:: sql

  select host_info->'windows_version' as windows_version,

  os_name as operating_system,
  count(os_name) as nb_hosts
  from hosts
  group by 1,2

You can also find several more examples of queries
on `Tranquil IT's Forum <https://forum.tranquil.it/viewforum.php?f=18&sid=b2a0081dd9a8adb5c57386974d691c6d>`_.
Feel free to post your own queries on the same forum with an explanation
of what your query does, ideally with a screen capture or a table showing
a sample of your query result.

Normalizing software names
--------------------------

Sometimes, the version of the software or its architecture are an integral part
of the software name. When they register with the WAPT Server inventory, they
appear as different software whereas they are just one software for us humans.

To solve this problem, we propose to standardize the name
of the software with WAPT.

.. figure:: wapt_console-report-normalize.png
  :align: center
  :alt: Normalizing the name of software

  Normalizing the name of software

* click :guilabel:`Normalize Software Names` in the :guilabel:`Tools` menu;

* select the software to standardize,
  for example, all different version of Adobe Flash Player;

* on the column :guilabel:`normalized`, press :kbd:`F2` to assign
  a standardized name to the selected software. Then press :kbd:`Enter`;

.. note::

  * to select several programs, select them with the :kbd:`shift-up/down`
    key combination;

  * you can also indicate a software like *windows update* or *banned*
    (Press :kbd:`spacebar` in the corresponding column);

* press on :guilabel:`Import` to load the changes from the server;

* press on :guilabel:`Write` to save your changes;

You can now run your queries on this standardized name.

Video demonstration
-------------------

.. raw:: html

   <iframe width="560" height="315" src="https://www.youtube.com/embed/UjBfelmJyKo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
