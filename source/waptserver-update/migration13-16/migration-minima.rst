.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Migrating more easily from WAPT 1.3 to 1.6
  :keywords: upgrade, upgrading, WAPT, 1.3, 1.6, simple procedure, documentation

Migrating more easily from WAPT 1.3 to 1.6
==========================================

This procedure is simpler than a complete migration, but some non essential data
may be lost, breaking the chain of traceability.

* backup the WAPT files in:

  * Linux: :file:`/var/www/wapt/` or :file:`/var/www/html/wapt/`;

  * Windows: :file:`C:\\wapt\waptserver\\repository\\wapt`;

Installing and re-importing the WAPT packages
---------------------------------------------

If you are using a Windows based WAPT Server in 1.3.13, you must uninstall
your 1.3.13 version before installing the 1.6 version.

You may now follow the same procedure to do a
:ref:`normal installation of the WAPT Server <installing_WAPT_Server>`.

The WAPT Server must have the same DNS name as the previous WAPT Server
(or the same IP if your WAPT agents find their WAPT Server
using its IP address).

.. hint::

  If you want the :program:`waptupgrade` package to work, you will have
  to follow the procedure :ref:`to generate the necessary keys
  <key-regenerate>`.

  Stop at the section on **re-signing the packages on the repository**.

Once the installation has finished, you may re-import all the WAPT packages
that were saved using the :guilabel:`Import from file` button
in the :guilabel:`Private repository` tab.

This operation will re-sign all the WAPT packages.

Installing the new WAPT agent 1.6 on your computers
---------------------------------------------------

* :ref:`recreate the WAPT agent <create_WAPT_agent>`,
  which will automatically upload the :program:`waptupgrade` package;

* then, :ref:`update the GPO for deploying the WAPT agent <install_waptagent>`;

* the :program:`waptupgrade` package will then automatically install
  on the computers that already had the package and finally, the WAPT agent will
  automatically upgrade when the computer shuts down;
