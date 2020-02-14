.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
    :description: Using the Audit functions
    :keywords: audit, WAPT, personalize

Using the Audit functions
=========================

.. note::

  This feature is available in the **Enterprise** version.

Why auditing?
-------------

The audit function allows to make regular checks to desktop configurations
and to centralize the results of these checks in the WAPT console.
This feature allows you to ascertain that your installed base of machines
matches your set of conformity rules over time.

For example you can:

* regularly check the list of local administrators on the desktops;

* ascertain over time the correct configuration of a critical software;

* regularly check the presence of the correct version of a piece of software;

* ascertain the security settings of a workstation;

The :command:`audit` function benefits from the depth and the breadth
of python libraries for unmatched levels of precision and finesse
for your auditing needs.

Working principle of the audit function
---------------------------------------

The :command:`audit` tasks are launched once after every :command:`upgrade`,
then regularly as defined with the ``audit_schedule`` value.

To manually launch an audit check, you may also use the following command:

.. code-block:: bash

  C:\Program Files (x86)\wapt\wapt-get.exe audit

.. note::

  By default, the audit function will not launch if the audit is note necessary.

  To force the execution, you may launch the following command:

  .. code-block:: bash

    C:\Program Files (x86)\wapt\wapt-get.exe audit -f

  Calling this function will launch the :command:`audit` scripts present
  in each WAPT package installed on the machine.

WAPT saves in its local database :file:`C:\\Program Files (x86)\\wapt\\waptdb.sqlite`
the audit scripts of all installed WAPT packages.

Output example of :code:`wapt-get audit`:

.. code-block:: bash

  Auditing tis-disable-ipv6 ...
  Skipping audit of tis-disable-ipv6(=1.0-6), returning last audit from 2018-09-25T11:20:58.426000
  tis-disable-ipv6 -> OK
  Auditing tis-disable-js-adobe ...
  Skipping audit of tis-disable-js-adobe(=13), returning last audit from 2018-09-25T11:20:58.502000
  tis-disable-js-adobe -> OK
  Auditing tis-disable-js-chrome ...
  Skipping audit of tis-disable-js-chrome(=3), returning last audit from 2018-09-25T11:20:58.566000
  tis-disable-js-chrome -> OK
  Auditing tis-disable-office-dde ...
  Skipping audit of tis-disable-office-dde(=1.0-2), returning last audit from 2018-09-25T11:20:58.615000
  tis-disable-office-dde -> OK
  Auditing tis-sysmon ...
  Skipping audit of tis-sysmon(=8.0-12), returning last audit from 2018-09-25T11:20:58.722000
  tis-sysmon -> OK
  Auditing tis-java ...
  OK: Uninstall Key {26A24AE4-039D-4CA4-87B4-2F32180181F0} in Windows Registry.
  OK: Uninstall Key {26A24AE4-039D-4CA4-87B4-2F64180181F0} in Windows Registry.
  tis-java -> OK

.. note::

  In the example above, the audit script had already been executed
  for *tis-disable-js-chrome* and *tis-disable-ipv6* ... but not for *tis-java*.

How to write the audit function
--------------------------------

The :command:`audit` script is defined in the package's :file:`setup.py`
with a function :command:`def audit()`:

Example:

.. code-block:: python

    def audit():
        if not registry_readstring(HKEY_LOCAL_MACHINE,makepath('SYSTEM','CurrentControlSet','Services','USBSTOR'),'Start'):
            print(r"La key HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBSTOR\Start n'existe pas")
            return "ERROR"
        valuestart = registry_readstring(HKEY_LOCAL_MACHINE,makepath('SYSTEM','CurrentControlSet','Services','USBSTOR'),'Start')
        if int(valuestart) != 4 :
            print("La valeur de Start n'est pas 4 , Start=%s " % valuestart )
            return "WARNING"
        print(ur"La valeur de Start est bien est bien égal a 4")
        return "OK"

.. hint::

  This example ascertains that USB storage is not allowed on the workstation.

The audit function returns one of these 3 values:

* **OK**;

* **WARNING**;

* **ERROR**;

.. attention::

  With the :command:`audit` function, it is not possible to use files
  that are contained in the WAPT packages.

  To use files embedded in the WAPT package that will be used for an audit,
  you must first copy the file(s) in a temporary folder
  during package installation.

Planning an audit
-----------------

The :command:`audit` tasks are launched once after every :command:`upgrade`,
then regularly as defined with the ``audit_schedule`` value.

The value is contained in the control file of your package.

By default, if :command:`audit_schedule` is empty, the audit task will need
to be launched manually or from teh WAPT console.

Otherwise, the periodicity may be indicated in several ways:

* an integer (in minutes);

* an integer followed by a letter (m = minutes, h = hours , d = days ,
  w = weeks);

Default behavior of the audit function
--------------------------------------

By default, the only audit function checks the presence of UninstallKey
for its WAPT package.

This way, WAPT ascertains that the software is still present
on the host, according to the host configuration.
