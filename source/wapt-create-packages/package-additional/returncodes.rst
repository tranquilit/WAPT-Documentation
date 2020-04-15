.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Working with non standard return codes
  :keywords: WAPT, success, error, installation, documentation

.. _returncodes:

Working with non standard return codes
======================================

Return codes are used to feed back information on whether
a software has installed correctly.

In Windows, the standard successfull return code is [0].

If you know that your WAPT packages installs correctly, yet you still get
a return code other than [0], then you can explicitly tell WAPT to ignore
the error code by using the parameter ``accept_returncodes``.

You can find out how to use the ``accept_returncodes`` parameter by exploring
this :ref:`section of the WAPT documentation <accept_returncodes_example>`.

.. hint::

  The full list of Windows Installer Error Messages can be found
  by visiting `this page <https://docs.microsoft.com/en-us/windows/win32/msi/windows-installer-error-messages>`_.
