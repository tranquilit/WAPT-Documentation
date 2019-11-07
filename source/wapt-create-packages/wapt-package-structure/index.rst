.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: WAPT package structure
  :keywords: setup.py, WAPT, control, icon.png, certificate.crt,
             manifest.sha256,  wapt.psproj, package identity, identification,
             documentation, signature.sha256

.. _structure_wapt-package:

WAPT package structure
======================

A WAPT package is a zip file containing several things:

.. figure:: ../../wapt-common-resources/wapt-package-structure.png
  :align: center
  :alt: WAPT package structure

  WAPT package structure

* a file :file:`setup.py`;

* one or several binary files;

* some additional optional files;

* a :file:`control` file in the :file:`WAPT` folder;

* a :file:`icon.png` file in the :file:`WAPT` folder;

* a :file:`certificate.crt` file in the folder :file:`WAPT`;

* a :file:`manifest.sha256` file in the folder :file:`WAPT`;

* a :file:`signature.sha256` file in the folder :file:`WAPT`;

* a :file:`wapt.psproj` file in the folder :file:`WAPT`;

.. _structure_control:

The *control* file
------------------

The :file:`control` file is the identity card of a package.

.. code-block:: ini

    package           : tis-firefox-esr
    version           : 62.0-0
    architecture      : all
    section           : base
    priority          : optional
    maintainer        : Administrateur
    description       : Firefox Web Browser French
    description_fr    : Navigateur Web Firefox Français
    description_es    : Firefox Web Browser
    depends           :
    conflicts         :
    maturity          : PROD
    locale            : fr
    target_os         : windows
    min_os_version    :
    max_os_version    :
    min_wapt_version  : 1.6.2
    sources           :
    installed_size    :
    impacted_process  : firefox.exe
    audit_schedule    :
    editor            : Mozilla
    keywords          : Navigateur
    licence           : MPL
    homepage          : https://www.mozilla.org/en-US/firefox/organizations/
    signer            : Tranquil IT
    signer_fingerprint: 459934db53fd804bbb1dee79412a46b7d94b638737b03a0d73fc4907b994da5d
    signature         : MLOzLiz0qCHN5fChdylnvXUZ8xNJj4rEu5FAAsDTdEtQ(...)hsduxGRJpN1wLEjGRaMLBlod/p8w==
    signature_date    : 20170704-164552
    signed_attributes : package,version,architecture,section,priority,maintainer,description,depends,conflicts,maturity,locale,min_os_version,max_os_version,min_wapt_version,sources,installed_size,signer,signer_fingerprint,signature_date,signed_attributes

.. tabularcolumns:: |\X{2}{12}|\X{5}{12}|\X{5}{12}|

======================= =========================================== ===========================================
Settings                Description                                 Example value
======================= =========================================== ===========================================
``package``             Package name                                tis-geogebra

``version``             Package version, can not                    5.0.309.0-0
                        contain more than 5 delimiters

``architecture``        Processor architecture                      x64

``section``             Package type (``host``,                     base
                        ``group``, ``base``,
                        ``orga-unit``)

``priority``            Package install priority
                        (optional, not used as of 1.5.15)           Not mandatory for the moment

``maintainer``          Author of the package                       Arnold Schwarzenegger terminator@mydomain.lan

``description``         Package description that will appear        The Graphing Calculator for Functions,
                        in the console and on the web interface     Geometry, Algebra, Calculus, Statistics and 3D

``description_fr``      Localized description of the package        Calculatrice graphique

``depends``             Packages that must be installed             tis-java
                        before installing the package

``conflicts``           Packages that must be uninstalled           tis-graph
                        before installing the package

``maturity``            Maturity level (BETA, DEV, PROD)            PROD

``locale``              Language environment for the package        fr,en,es

``target_os``           Accepted Operating System for the package   windows

``min_os_version``      Minimum version of Windows for the package  6.0
                        to be seen by the WAPT agent

``max_os_version``      Maximum version of Windows for the package  8.0
                        to be seen by the WAPT agent

``min_wapt_version``    WAPT's minimal version for the package      1.3.8
                        to work properly

``sources``             Path to the SVN location of the package     https://srv-svn.mydomain.lan/sources/tis-geogebra-wapt/trunk/
                        (:command:`source` command)

``installed_size``      Minimum required free disk space            254251008
                        to install the package

``impacted_process``    Indicates a list of impacted processes      firefox.exe
                        when installing a package

``audit_schedule``      Periodicity of execution of the audit       60
                        function in the WAPT package

``editor``              Editor of the software package              Mozilla

``license``             Reference of the software license           GPLV3

``keywords``            Set of keywords describing the WAPT package Productivity,Text Processor

``homepage``            Official homepage of the software           https://wapt.fr
                        embedded in the WAPT package

``signer``              CommonName (CN) of the package's signer     Tranquil IT

``signer_fingerprint``  Fingerprint of the certificate holder's     2BAFAF007C174A3B00F12E9CA1E74956
                        signature

``signature``           SHA256 hash of the package                  MLOzLiz0qCHN5fChdylnvXUZ8xNJj4rEu5FAAsDTdEtQ(...)hsduxGRJpN1wLEjGRaMLBlod/p8w==

``signature_date``      Date when the package was signed            20180307-230413

``signed_attributes``   List of package's attributes                package, version, architecture, section, priority, maintainer, description,
                        that are signed                             depends, conflicts, maturity, locale, min_os_version, max_os_version,
                                                                    min_wapt_version, sources, installed_size, signer, signer_fingerprint,
                                                                    signature_date, signed_attributes
======================= =========================================== ===========================================

.. note::

  If the :file:`control` file contains special characters, the :file:`control`
  file must be saved in **UTF-8 (No BOM)** format.

.. figure:: accent-in-ctrl.png
  :align: center
  :alt: PyScripter - UTF-8 (No BOM)

  PyScripter - UTF-8 (No BOM)

Fields details
++++++++++++++

package
"""""""

**WAPT package name, without any accent, nor space,
nor any special or uppercase character**.

version
"""""""

Preferably, always start with the packaged software version split by points
(*.*) and finish with the WAPT packaging version separated
by a dash (*-*) character.

architecture
""""""""""""
.. versionadded:: 1.5

Defines whether the package may be installed on x64 or x32 processor
equipped computers.

.. note::

  A x64 package will be invisible for a WAPT agent installed on a x86 machine.

Allowed values:

* **x86**: the package is designed for 32bit computers;

* **x64**: the package is designed for 64bit computers;

* **all**: the package is designed for 32bit or 64bit computers;

section
"""""""

* **host**: host package;

* **group**: group package;

* **base**: software package;

* **unit**: :abbr:`OU (Organizationnal Unit)` package;

priority
""""""""

This option is not supported at this time. That field will be used
to define package installation priority. This feature will become useful
to define mandatory security updates.

maintainer
""""""""""

Defines the WAPT package creator.

.. note::

  To define the WAPT package creator's email address may be useful.

description
"""""""""""

Describes the functionality of the package that will appear in the console,
on the local web interface http://127.0.0.1:8088 and in :code:`wapt-get`
command lines.

.. hint::

  Adding a field ``description_fr`` or ``description_es`` allows you
  to internationalize the description of your package.
  If the language does not exist, the WAPT agent will use
  the default language description.

depends
"""""""

Defines the packages that must be installed before, for example *tis-java*
is a dependency for the *LibreOffice* package and *tis-java* must be installed
before *LibreOffice*.

Several dependencies may be defined by splitting them with commas (*,*).

example:

.. code-block:: bash

  depends: tis-java,tis-firefox-esr,tis-thunderbird

conflicts
"""""""""

Works as the opposite of *depends*.

*conflicts* defines package(s) that must be removed before installing a package,
for example *tis-firefox* must be removed before the package *tis-firefox-esr*
is installed, or *OpenOffice* must be removed before *LibreOffice* is installed.

Several conflicts may be defined by splitting them with commas (*,*).

maturity
""""""""

.. versionadded:: 1.5.1.19

Defines the maturity of a package.

By default, WAPT gents will see packages flagged as *PROD*
and packages with an empty maturity.

For a computer to see packages with different maturity levels, you will have
to configure the *maturities* atrtibute in :file:`wapt-get-ini`

locale
""""""

.. versionadded:: 1.5.1.19

Defines the language of the WAPT package.

A WAPT agent will see by default packages that are configured
for its language environment and packages with no language specified.

For a computer to see a package in another language, you will have
to configure the *locales* in :file:`wapt-get.ini`.

.. code-block:: bash

   locales = fr,en,es

The language filled in the field must be in
`ISO 639-1 <https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes>`_
format.

target_os
"""""""""

.. versionadded:: 1.5.1.18

Defines the Operating System for the package.

A WAPT agent will see by default packages that are configured
for its operating system and packages with no operating system specified.

The operating systems in the field *target_os* must be *windows* or left empty.

min_os_version
""""""""""""""

.. versionadded:: 1.3.9

Defines the minimal `Windows Operating System Version <https://msdn.microsoft.com/en-us/library/windows/desktop/ms724832(v=vs.85).aspx>`_.
For example, this attribute may be used to avoid installing
on WindowsXP packages that only work on Windows7 and above.

max_os_version
""""""""""""""

.. versionadded:: 1.3.9

Defines the maximal `Windows Operating System Version <https://msdn.microsoft.com/en-us/library/windows/desktop/ms724832(v=vs.85).aspx>`_.
For example, this attribute may be used to install on Windows7
more recent versions of a software that are no more supported on Windows XP.

min_wapt_version
""""""""""""""""

.. versionadded:: 1.3.8

WAPT minimum version to install a package

.. note::

  With functionalities in WAPT evolving, some functions that you may have
  used in old packages may become obsolete with newer versions of WAPT agents.

sources
"""""""

Defines a SVN repository, for example:

* https://svn.mydomain.lan/sources/tis-geogebra-wapt/trunk/

* https://svn.mydomain.lan/sources/tis-geogebra-wapt/trunk/

This method allows to version a package and collaboratively work on it.

.. hint::

  Package versioning is particularly useful when several people create
  packages in a collaborative way. This function is also useful to trace
  the history of a package if you are subject to Regulations in your industry.

installed_size
""""""""""""""

Defines the required minimum free disk space to install the package.

Example:

.. code-block:: bash

  installed_size: 254251008

The testing of available free disk space is done on the :file:`C:\\Program Files`
folder.

The value set in *installed_size* must be in bytes.

.. hint::

  To convert storage values to bytes, visit http://bit-calculator.com/.

impacted_process
""""""""""""""""

.. versionadded:: 1.5.1.18

Indicates processes that are impacted when installing a package.

Example:

.. code-block:: bash

  impacted_process : firefox.exe,chrome.exe,iexplorer.exe

This field is used by the functions :command:`install_msi_if_needed`
and :command:`install_exe_if_needed` if *killbefore* has not been filled.

*impacted_process* is also used when uninstalling a package.
This allows to close the application if the application is running
before being uninstalled.

audit_schedule
""""""""""""""

.. versionadded:: 1.6

Periodicity of execution of audit checks.

Example:

.. code-block:: bash

  audit_schedule : 60

The periodicity may be indicated in several ways:

* an integer (in minutes);

* an integer followed by a letter (*m* = minutes, *h* = hours, *d* = days,
  *w* = weeks);

editor
""""""

.. versionadded:: 1.6

Software editor of the binaries embedded in the WAPT base package.

Example:

.. code-block:: bash

  editor: Mozilla

The values may be used as filters in the WAPT console and with the self-service.

keywords
""""""""

.. versionadded:: 1.6

Keyword list to categorize the WAPT package.

Example:

.. code-block:: bash

  keywords: editeur,bureautique,tableur

The values may be used as filters in the WAPT console and with the self-service.

licence
"""""""

.. versionadded:: 1.6

Reference of the software license for the embedded software binaries.

Example:

.. code-block:: bash

  licence: GPLV3

The values may be used as filters in the WAPT console and with the self-service.

homepage
""""""""

.. versionadded:: 1.6

Official homepage of the software binaries embedded in the WAPT package.

Example:

.. code-block:: bash

  homepage: https://wapt.fr

The values may be used as filters in the WAPT console and with the self-service.

signer
""""""

Automatically filled during package signature.

:abbr:`CN (Common Name)` of the certificate. It is typically
the signer's full name.

signer_fingerprint
""""""""""""""""""

Automatically filled during package signature.

Private key fingerprint of the package signer.

signature
"""""""""

Automatically filled during package signature.

Signature of the attributes of the package.

signature_date
""""""""""""""

Automatically filled during package signature.

Date when the attributes of the package have been signed.

signed_attributes
"""""""""""""""""

Automatically filled during package signature.

List of the package's attributes that are signed

.. _setuppy:

The *setup.py* file
-------------------

import setuphelpers
+++++++++++++++++++

That line is found at the beginning of every WAPT package:

.. code-block:: python

   from setuphelpers import *

The package imports all setuphelpers functions.

*Setuphelpers* is a WAPT library that offers many methods
to more easily develop highly functional packages.

uninstallkey list
+++++++++++++++++

We then find:

.. code-block:: python

  uninstallkey = ['tisnaps2','Mozilla Firefox 45.6.0 ESR (x86 fr)']

We associate here a list of *uninstall keys* to the package.
When a package is removed, the WAPT agent looks up the *uninstallkey*
in the registry associated to the package. This *uninstallkey* will indicate
to WAPT the actions to trigger to remove the software.

Even if there is no *uninstallkey* for a software,
it is mandatory to declare an empty *uninstallkey* array:

.. code-block:: python

  uninstallkey = []

Function install()
++++++++++++++++++

Then comes the :file:`setup.py` function declaration.

It is the recipe of the WAPT package,
the set of instructions that will be executed.

.. code-block:: python

  def install():
      run('"install.exe" /S')

The *wapt.psproj* file
----------------------

Package project file :file:`wapt.psproj` is found in the WAPT folder.

It's the PyScripter project file for the WAPT package.

To edit a package with :program:`PyScripter`, just open the file.

The *icon.png* file
-------------------

The :file:`icon.png` icon file is located in the WAPT folder.

It associates an icon to the package.

That icon will appear in the local web interface of WAPT
self-service (http://127.0.0.1:8088).

.. hint::

  The icon must be a 48px per 48px PNG file.

The *manifest.sha256* file
--------------------------

The :file:`manifest.sha256` manifest file is located in the WAPT folder.

It contains the sha256 fingerprint of every file in the WAPT package.

The *control* file
------------------

The :file:`signature` signature file is located in the WAPT folder.

It contains the signature of the :file:`manifest.sha256` file.

On installing a package, :program:`wapt-get` checks:

* that the signature of :file:`manifest.sha256` matches the actual
  :file:`manifest.sha256` file (the agent will verify the public certificates
  in :file:`C:\\Program Files (x86)\\wapt\\ssl` );

* that the sha256 fingerprint of each file is identical to the fingerprint
  in the :file:`manifest.sha256` file;

Other files
-----------

Other files may be embedded in the WAPT package. For example:

* an installer beside your :file:`setup.py`
  to be called in your :program:`setup.py`;

* an answer file to pass on to the software installer;

* a license file;
