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
this package code.

.. code-block:: python
  :emphasize-lines: 29

  # -*- coding: utf-8 -*-
  from setuphelpers import *
  import re

  uninstallkey = []

  def is_kb_installed(hotfixid):
      installed_update = installed_windows_updates()
      if [kb for kb in installed_update if kb['HotFixID' ].upper() == hotfixid.upper()]:
          return True
      return False

  def waiting_for_reboot():
      # Query WUAU from the registry
      if reg_key_exists(HKEY_LOCAL_MACHINE,r"SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired") or \
          reg_key_exists(HKEY_LOCAL_MACHINE,r"SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending") or \
          reg_key_exists(HKEY_LOCAL_MACHINE,r'SOFTWARE\Microsoft\Updates\UpdateExeVolatile'):
          return True
      return False

  def install():
      kb_files = [
          'windows10.0-kb4522355-x64_af588d16a8fbb572b70c3b3bb34edee42d6a460b.msu',
          ]
      with EnsureWUAUServRunning():
        for kb_file in kb_files:
            kb_guess = re.findall(r'^.*-(KB.*)-',kb_file)
            if not kb_guess or not is_kb_installed(kb_guess[0]):
                print('Installing {}'.format(kb_file))
                run('wusa.exe "{}" /quiet /norestart'.format(kb_file),accept_returncodes=[0,3010,2359302,-2145124329],timeout=3600)
            else:
                print('{} already installed'.format(kb_file))

        if waiting_for_reboot():
            print('A reboot is needed!')

.. hint::

  The full list of Windows Installer Error Messages can be found
  by visiting `this page <https://docs.microsoft.com/en-us/windows/win32/msi/windows-installer-error-messages>`_.
