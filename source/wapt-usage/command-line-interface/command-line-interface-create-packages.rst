.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
    :description: Using the Command Line to create WAPT packages
    :keywords: command line, WAPT, CLI, create packages, make-template,
               make-host-template, make-group-template, list-registry, sources,
               build-package, sign-package, build-upload, duplicate, edit,
               upload-package, update-packages, documentation

.. _wapt_cli_create_package:

Using the Command Line to create WAPT packages
----------------------------------------------

wapt-get make-template
++++++++++++++++++++++

The :command:`wapt-get make-template <msi or exe file> <package name>`
command allows to create a package template from a MSI or an EXE installer.

You will find the complete procedure for :ref:`creating WAPT packages
<creating_WAPT_packages>`.

.. hint::

  * If you have previously installed *tis-waptdev* package on your development
    computer, :program:`PyScripter` editor will launch automatically
    and open the package in development mode.

The command :code:`wapt-get make-template C:\\Users\\User\\Downloads\\tightvnc-2.8.5-gpl-setup-64bit.msi tis-tightvnc`
returns:

.. code-block:: bash

  Template created. You can build the WAPT package by launching
    C:\Program Files (x86)\wapt\wapt-get.exe build-package C:\waptdev\tis-tightvnc-wapt
  You can build and upload the WAPT package by launching
    C:\Program Files (x86)\wapt\wapt-get.exe build-upload C:\waptdev\tis-tightvnc-wapt

wapt-get make-host-template
+++++++++++++++++++++++++++

The :command:`wapt-get make-host-template <host FQDN>` command creates an empty
WAPT host package from a template.

The command :code:`wapt-get make-host-template host01.mydomain.lan` returns:

.. code-block:: bash

  Template created. You can build the WAPT package by launching
    C:\Program Files (x86)\wapt\wapt-get.exe build-package C:\waptdev\host01.mydomain.lan-wapt
  You can build and upload the WAPT package by launching
    C:\Program Files (x86)\wapt\wapt-get.exe build-upload C:\waptdev\host01.mydomain.lan-wapt

wapt-get make-group-template
++++++++++++++++++++++++++++

The :command:`wapt-get make-group-template <name of group>` command creates
an empty WAPT group package from a template.

The command :code:`wapt-get make-group-template accounting` returns:

.. code-block:: bash

  Template created. You can build the WAPT package by launching
    C:\Program Files (x86)\wapt\wapt-get.exe build-package C:\waptdev\accounting-wapt
  You can build and upload the WAPT package by launching
    C:\Program Files (x86)\wapt\wapt-get.exe build-upload C:\waptdev\accounting-wapt

wapt-get list-registry
++++++++++++++++++++++

The :command:`wapt-get list-registry <keyword>` command lookups a keyword
in software installed by WAPT on the computer.

The output of :command:`list-registry` is a table listing *uninstall keys*
for each software corresponding to the search term.

The command :code:`wapt-get list-registry firefox` returns:

.. code-block:: bash

  UninstallKey                           Software                               Version             Uninstallstring
  ---------------------------------------------------------------------------------------------------------------------------------------------------------
  Mozilla Firefox 45.5.0 ESR (x64 fr)    Mozilla Firefox 45.5.0 ESR (x64 fr)    45.5.0              "C:\Program Files\Mozilla Firefox\uninstall\helper.exe"

wapt-get sources
++++++++++++++++

The :command:`wapt-get sources <package name>` command downloads sources
from a source code management platform like Git or SVN.

The command :code:`wapt-get sources tis-firefox` returns nothing;

.. _build_package:

wapt-get build-package
++++++++++++++++++++++

The :command:`wapt-get build-package <path to the package>` command builds
a WAPT package and signs it with the private key of the :term:`Administrator`.

.. note::

  The path to the private key, the default prefix and the default development
  path must be properly set in the :file:`wapt-get.ini` file.

The command :code:`wapt-get sources tis-firefox` returns: :

.. code-block:: bash

  Building  C:\waptdev\tis-tightvnc-wapt

  Package tis-tightvnc (=2.8.5.0-0) content:
   setup.py
   tightvnc-2.8.5-gpl-setup-64bit.msi
   WAPT\control
   WAPT\wapt.psproj
  ...done. Package filename C:\waptdev\tis-tightvnc_2.8.5.0-0_all.wapt
  Signing C:\waptdev\tis-tightvnc_2.8.5.0-0_all.wapt

  7-Zip [64] 16.04 : Copyright (c) 1999-2016 Igor Pavlov : 2016-10-04

  Open archive: C:\waptdev\tis-tightvnc_2.8.5.0-0_all.wapt
  --
  Path = C:\waptdev\tis-tightvnc_2.8.5.0-0_all.wapt
  Type = zip
  Physical Size = 1756459

  Updating archive: C:\waptdev\tis-tightvnc_2.8.5.0-0_all.wapt

  Items to compress: 0

  Files read from disk: 0
  Archive size: 1755509 bytes (1715 KiB)
  Everything is Ok
  Package C:\waptdev\tis-tightvnc_2.8.5.0-0_all.wapt signed : signature :
  mOQINvKGfmcW4nu05aVc8MJqMtXdPv5I0qo5zCfMkIWvEeYYDDfnZLakPkXiqptiqcNbCdY8vOPs
  qFMqwSMYUyKJ8d3DHEk8kdlIldkLsiAejkdsoiZDKlEFVCJgdKI13x4FcPfoZNw5DFPzmCZKbgkU
  pWvGbGFwUx/3d9zcliciN82F0FveC6C0mqoh5A==

  You can upload to repository with
    C:\Program Files (x86)\wapt\wapt-get.exe upload-package "C:\waptdev\tis-tightvnc_2.8.5.0-0_all.wapt"

wapt-get sign-package
+++++++++++++++++++++

The :command:`wapt-get sign-package <path to the package>` command signs
a package with the private key of the :term:`Administrator`.

.. attention::

  :command:`sign-package` does not rename the WAPT package with the chosen
  prefix of the :term:`Organization`.

The command :code:`wapt-get sign-package C:\\waptdev\\smp-7zip_16.4.0.0-1_all.wapt`
returns:

.. code-block:: bash

  Signing C:\waptdev\smp-7zip_16.4.0.0-1_all.wapt

  7-Zip [64] 16.04 : Copyright (c) 1999-2016 Igor Pavlov : 2016-10-04

  Open archive: C:\waptdev\smp-7zip_16.4.0.0-1_all.wapt
  --
  Path = C:\waptdev\smp-7zip_16.4.0.0-1_all.wapt
  Type = zip
  Physical Size = 2857855

  Updating archive: C:\waptdev\smp-7zip_16.4.0.0-1_all.wapt

  Items to compress: 0

  Files read from disk: 0
  Archive size: 2856021 bytes (2790 KiB)
  Everything is Ok
  Package C:\waptdev\smp-7zip_16.4.0.0-1_all.wapt signed : signature :
  lAxMJBKlnZLFQG81Rwb80+cB6XHcNjazmVJI7+PLLcPfFkFVC5wojyMPVMKhUrjrSlWomj85L8CY
  gZv/FsVspUij45TcikukbF8Rr+jy6saHskg42XINqZWCnP28k4bkIREdzYIkuKDABfr15gt3ecuN
  E21ZU/SI8BtXOX/80w9hpbP6ivCzTaYZZk18dhLDzV04xM9QwPSZ2mjQspbVklpm2NL4F6gb5b9D
  EwMjus74/MNc6BZeKtMcFcE3Ft18ROAJeF5hLws24jjCv6Gjjus+zlGlepWK0M2p7rIdvmC1BWB/
  Y6e1mQpSoisAvhOpATFPqNJca/QTMANKiTD3OA==

wapt-get build-upload
+++++++++++++++++++++

The :command:`wapt-get build-upload <path to the package>` command builds
and uploads a WAPT package onto the main WAPT repository.

.. hint::

  By passing the *-i* argument to :command:`build-upload`, the WAPT packaging
  version number is incremented before upload, so to avoid having to modify
  manually the :file:`control` file.

The command :code:`wapt-get -i build-upload C:\\waptdev\\tis-tightvnc-wapt`
returns:

.. code-block:: bash

  Building  C:\waptdev\tis-tightvnc-wapt
  Package tis-tightvnc (=2.8.5.0-1) content:
   setup.py
   tightvnc-2.8.5-gpl-setup-64bit.msi
   WAPT\control
   WAPT\wapt.psproj
  ...done. Package filename C:\waptdev\tis-tightvnc_2.8.5.0-1_all.wapt
  Signing C:\waptdev\tis-tightvnc_2.8.5.0-1_all.wapt

  7-Zip [64] 16.04 : Copyright (c) 1999-2016 Igor Pavlov : 2016-10-04

  Open archive: C:\waptdev\tis-tightvnc_2.8.5.0-1_all.wapt
  --
  Path = C:\waptdev\tis-tightvnc_2.8.5.0-1_all.wapt
  Type = zip
  Physical Size = 1756458

  Updating archive: C:\waptdev\tis-tightvnc_2.8.5.0-1_all.wapt

  Items to compress: 0

  Files read from disk: 0
  Archive size: 1755509 bytes (1715 KiB)
  Everything is Ok
  Package C:\waptdev\tis-tightvnc_2.8.5.0-1_all.wapt signed : signature :
  FVn2yx77TwUHaDauSPHxJZiPAyMQe4PqLF5n6wY9YPAwY4ijHe6NgDFrexXf8ZYbHAiNa5b8V/Qj
  wTVHiqpbXnZotiVIGrJDhgbaLwZ9CK6pfWiflC4126nx6PMF3T1i6w0R0NOE2wJpOSRYESk7lDUz
  9CPfzJCLcOXwh0F5eZc96wbkDkSbpn1f+x5tOlvyy/FW2m8RbZQhJcO21j9gGX7It0QNecaOxXgz
  qkZZKBDNASOBYAF22M1+zHb59DWQ63Q8yMj5t5szEUTkGtQNG6vZz3gb9Yraq361BIGaBDYUM31j
  ZgpaHvP0vdK3c1x1mhyhC7q6eZ/UCW5tETTCiA==

  Uploading files...
  WAPT Server user :admin
  WAPT Server password :
  Status : OK, tis-tightvnc_2.8.5.0-1_all.wapt uploaded, 1 packages analysed

wapt-get duplicate
++++++++++++++++++

The :command:`wapt-get duplicate <package source> <package new_duplicate>`
command duplicates a package downloaded from the repository
and opens it as a :program:`PyScripter` project.

The command :code:`wapt-get duplicate tis-firefox tis-firefox-custom` returns:

.. code-block:: bash

  Package duplicated. You can build the new WAPT package by launching
    C:\Program Files (x86)\wapt\wapt-get.exe build-package C:\waptdev\tis-firefox-custom-wapt
  You can build and upload the new WAPT package by launching
    C:\Program Files (x86)\wapt\wapt-get.exe build-upload C:\waptdev\tis-firefox-custom-wapt

wapt-get edit
+++++++++++++

The :command:`wapt-get edit <package name>` command downloads
and edits a WAPT package.

The command :code:`wapt-get edit tis-firefox` returns:

.. code-block:: bash

  Package edited. You can build and upload the new WAPT package by launching
    C:\Program Files (x86)\wapt\wapt-get.exe -i build-upload C:\waptdev\tis-firefox-wapt

wapt-get edit-host
++++++++++++++++++

The :command:`wapt-get edit-host <host FQDN>` command edits a WAPT *host*
package.

wapt-get upload-package
+++++++++++++++++++++++

The :command:`wapt-get upload-package <path to the package>` command uploads
a package onto the main WAPT repository.

The command :code:`wapt-get upload-package C:\\waptdev\\tis-tightvnc_2.8.5.0-1_all.wapt`
returns:

.. code-block:: bash

  WAPT Server user :admin
  WAPT Server password :
  tis-tightvnc_2.8.5.0-1_all.wapt uploaded, 1 packages analysed
  result: OK

wapt-get update-packages
++++++++++++++++++++++++

The :command:`wapt-get update-packages <path to folder>` command scans
a local repository and creates the :file:`Packages` index file.

The command :code:`wapt-get update-packages D:\\Data\\WAPT` returns:

.. code-block:: bash

  Packages filename : D:\waptdev\Packages
  Processed packages :
    D:\Data\WAPT\groupe_base.wapt
    D:\Data\WAPT\tis-firefox_50.1.5.0-0_all.wapt
    D:\Data\WAPT\tis-tightvnc_2.8.5.0-1_all.wapt
    D:\Data\WAPT\tis-7zip_16.4.0.0-1_all.wapt
    D:\Data\WAPT\tis-mumble_3.14-3_all.wapt
    D:\Data\WAPT\tis-noforcereboot_1.0-1_all.wapt
  Skipped packages :
