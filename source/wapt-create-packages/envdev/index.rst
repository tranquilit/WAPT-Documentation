.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^


.. meta::
  :description: Setting up your WAPT development and test environment
  :keywords: setup.py, WAPT, control, icon.png, certificate.crt,
             manifest.sha256, signature.sha256, wapt.psproj, package identity,
             identification, documentation

.. _envdev_setup:

Setting up your WAPT development and test environment
=====================================================

Prerequisites
-------------

.. attention::

  * it is **required** to be a :term:`Local Administrator` of the machine
    to use WAPT's integrated environment for developing WAPT packages;

  * we advise you to create/ edit packages in a fully controlled environment
    that is safe and *disposable*;

  * the usage of a disposable virtual machine (like Virtualbox) is recommended;

Make sure that you have your private key stored on the development computer
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

In the WAPT console, the fields *private key* and *prefix* must be filled.

Install the *tis-pyscripter* WAPT package
+++++++++++++++++++++++++++++++++++++++++

* import the *tis-pyscripter* package in your local repository and install it
  on your development computer;

Recommendations regarding the test environment
----------------------------------------------

The recommended method to correctly test your WAPT packages is to use
a representative sample of machines in your inventory. So the more heterogeneous
your installed base of machines, the larger your sample must be.

This method consists of testing the installation of the package
on as many plateforms and configurations as possible,
so to improve its reliability, before the WAPT package is transfered
to production repositories.

Testing method
++++++++++++++

Operating systems and architectures
"""""""""""""""""""""""""""""""""""

* Windows XP;

* Windows 7;

* Windows 10;

* Windows Server 2008 R2;

* Windows Server 2012 and R2;

* x86;

* x64;

* Physical and virtual machines;

* laptops;

.. hint::

  When possible, RC and Beta version of Operating Systems should be tested
  (ex: Windows 10 Creators Update).

State of Windows Updates
""""""""""""""""""""""""

* **Microsoft Windows machine without any Windows update installed**:
  the objective is to detect Windows updates that are required for the software
  to work properly and to adapt the WAPT package accordingly;

* **Microsoft Windows machine with all the latest Windows updates**:
  the objective is to detect Windows updates that break the package
  and to adapt the WAPT package accordingly;

State of software installations
"""""""""""""""""""""""""""""""

* **Machines with many installed packages**: the objective is to detect
  a possible dependency with an existing application;

* **Machines with many installed packages**: the objective is to detect
  a possible conflict with an existing application;

* **Install older versions of the software**: it is possible that
  the software installer does not support uninstalling a previous version
  of the software, in this case, the WAPT package will have to remove
  older versions of the software before installing the new version;
