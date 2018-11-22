.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Recompiling WAPT from source
  :keywords: Python, WAPT, virtualenv, CodeTyphon, Lazarus, InnoSetup,
             documentation

Recompiling WAPT from source
============================

.. todo::

  Review this section

WAPT components
---------------

Python environment

* Python 2.7.13;

* client python libraries in :file:`requirements.txt`;

* server python libraries in :file:`requirements-server.txt`;

Creating a development environment with virtualenv:

With a clean Windows installed:

* install python2.7.12 from https://www.python.org/ftp/python/2.7.12/python-2.7.12.msi;

* upgrade :program:`python-setuptools`:

.. code-block:: bash

    c:\python27\python -m pip install -U pip setuptools

* create a development environment with ``virtualenv``;

.. code-block:: bash

    mkdir c:\tranquilit
    git clone git@github.com:tranquilit/WAPT.git (ou git clean -fxd ...)
    cd c:\tranquilit\wapt init_workdir.bat

Build environment on Debian Linux
---------------------------------

.. code-block:: bash

    mkdir ~/tranquilit/
    cd ~/tranquilit/
    git clone git@github.com:tranquilit/WAPT.git
    cd ~/tranquilit/wapt/waptserver/deb
    python createdeb.py
    cd ~/tranquilit/wapt/waptrepo/deb
    python createdeb.py

CodeTyphon/ Lazarus environment
-------------------------------

Base FPC + lazarus (in practice, we install CodeTyphon):

* fpc 2.7.1 Rev 27327;

* lazarus SVN Rev 44546;

WAPT relies on the following third-party freepascal/ lazarus librairies:

* pl_indy: http://www.pilotlogic.com/sitejoom/index.php/wiki/85-wiki/codetyphon-studio/ct-packages/271-pl-indy;

* superobject: https://code.google.com/p/superobject/;

* virtualtrees: http://www.pilotlogic.com/sitejoom/index.php/85-wiki/codetyphon-studio/ct-packages/301-pl-virtualtrees
  and https://svn.code.sf.net/p/lazarus-ccr/svn/components/virtualtreeview-new/trunk/;

* python4delphi: https://code.google.com/p/python4delphi/;

* delphizmq: https://github.com/bvarga/delphizmq;

* JCL: http://wiki.delphi-jedi.org/wiki/JCL_Installation;

* thmtlport: https://svn.code.sf.net/p/lazarus-ccr/svn/components/thtmlport;

Tranquil IT packages
--------------------

* pltis_python4delphi: https://github.com/tranquilit/pltis_python4delphi;

* pltis_utils: https://github.com/tranquilit/pltis_utils: subset of libraries
  from JEDI JCL project adapted to lazarus;

* pltis_sogrid: https://github.com/tranquilit/pltis_sogrid;

* pltis_superobject: https://github.com/tranquilit/pltis_superobject;

Building WAPT with CodeTyphon 4.8

CodeTyphon is a Lazarus with many embeddd librairies, making
this Integrated Development Environment (IDE) highly functional.

* download CodeTyphon 4.8 (a copy is available on
  https://wapt.tranquil.it/wapt/mirror/CodeTyphonIns48.zip);

* unzip to :file:`C:`;

* check that neither cygwin nor git are in your global PATH. If yes, remove them
  at least temporarily for the initial compilation of codeTyphon.
  There are conflicts with :program:`sh` or :program:`make` between CodeTyphon
  and these Tools;

* launch :file:`C:\CodeTyphonIns\install.bat`;

* choose option 0;

* launch Codetyphon center;

* launch :program:`Typhon-IDE /Typhon32 - Build BigIDE`;

* launch the :program:`BigIDE` from CodeTyphon center;

Install Git or TortoiseGit

Checkout the project and its components:

.. code-block:: bash

  cmd.exe
  mkdir c:\tranquilit
  git clone https://github.com/tranquilit/WAPT.git
  git clone https://github.com/tranquilit/pltis_utils.git
  git clone https://github.com/tranquilit/pltis_superobject.git
  git clone https://github.com/tranquilit/pltis_sogrid.git
  git clone https://github.com/tranquilit/pltis_python4delphi.git
  git clone https://github.com/tranquilit/delphizmq.git
  svn co https://svn.code.sf.net/p/lazarus-ccr/svn/components/thtmlport thtmlport

Installing Tranquil IT packages in CodeTyphon

* launch :program:`CodeTyphon`;

* :menuselection:`Package --> Open a package file` (.lpk);

Open in sequence the following packages and compile them:

* :file:`pltis_utils.lpk`;

* :file:`pltis_superobject.lpk`;

* :file:`pltis_sogrid.lpk` (installation in CodeTyphon IDE required);

* :file:`pltis_python4delphi.lpk` (installation in CodeTyphon IDE required);

* :file:`pltis_delphizmq.lpk`;

* :file:`thtmlport\package\htmlcomp.lpk`;

* :file:`<WAPT>\apt-get\pltis_wapt.plk`;

Compile the binaries
---------------------

* :file:`C:\tranquilit\wapt\wapt-get\waptget.lpr`;

* :file:`C:\tranquilit\wapt\waptconsole\waptconsole.lpr`;

* :file:`C:\tranquilit\wapt\wapttray\wapttray.lpr`;

* :file:`C:\tranquilit\wapt\waptexit\waptexit.lpr`;

* :file:`C:\tranquilit\wapt\waptdeploy\waptdeploy.lpr`;

* :file:`C:\tranquilit\wapt\waptserver\postconf\waptserverpostconf.lpr`;

Create the installers
---------------------

* install Innosetup from
  http://www.jrsoftware.org/download.php/ispack-unicode.exe

The :file:`.iss` files are located in :file:`C:\tranquilit\wapt\waptsetup` ;

The :program:`waptsetup` installer includes the python libraries,
the command line tool :program:`wapt-get`, the local webservice
:program:`waptservice`, the packaging tool and the WAPT console
:program:`waptconsole`.

The file :file:`waptserver.iss` allows to build an installer that includes
a Nginx web server in front and the Flask webservice :program:`waptserver.py`.

The :file:`waptstarter` installer only includes the local webservice and
the command line tool :program:`wapt-get`. It does not include the WAPT console
:program:`waptconsole`, nor the packaging tools.

:menuselection:`Right-click on the .iss file --> Compile ` will compile
an installer with :program:`InnoSetup`.

or using the command line:

.. code-block:: bash

  "C:\Program Files (x86)\Inno Setup 5\ISCC.exe" C:\tranquilit\wapt\waptsetup\waptsetup.iss

The installer's global parameters are defined with #define in the file header.

If you do not sign the installers, you may comment
the lines :code:`#define signtool ..`.
