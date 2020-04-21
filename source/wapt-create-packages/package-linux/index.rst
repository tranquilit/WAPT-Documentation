.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
    :description: linux package
    :keywords: linux, WAPT, package, documentation

.. _linux_packaging:

Simple linux package
====================

Before starting, we assume severaly conditions, here :

* you have a graphical interface on your linux.
* you installed vscode package from our repo.
* your user is named "youruser" and is part of sudoers

create a base template from you linux computer
----------------------------------------------

* start up a Command Line utility;

* create a WAPT package template;

  .. code-block:: bash

    wapt-get make-template <nom_du_paquet>

  .. warning::

	  Do not launch this command as root or with sudo.


  When you create a template, there will be several files in the folder :file:`.vscode` inside your package folder :

  * settings.json

  * launch.json

  Example with VLC:

  .. code-block:: bash

    wapt-get make-template "tis-vlc"

    Using config file: /opt/wapt/wapt-get.ini
    Template created. You can build the WAPT package by launching
    /opt/wapt//wapt-get.py build-package /home/youruser/waptdev/tis-vlc-wapt
    You can build and upload the WAPT package by launching
    /opt/wapt//wapt-get.py build-upload /home/youruser/waptdev/tis-vlc-wapt

  .. hint::

    All packages are stored in your user 's home.

 VSCode loads up and opens package project.

  .. figure:: vscode_vlc.png
    :align: center
    :alt: VSCode opening with focus on the *setup* file

    VSCode opening with focus on the *setup* file

* check the *control* file content;

  You have to give a **description** to you package, give the **os_target** and the
  **version** of you package.

  .. hint::

  	**os_target** for unix is *linux*

  .. warning::

    *version* in you control file must start at 0, not version of the software, we don't know precisely from apt/yum repo which version will be.

  Original *control* file

  .. literalinclude:: control_origin.txt
    :emphasize-lines: 2

  Modified *control* file

  .. literalinclude:: control_modified.txt
    :emphasize-lines: 2,6,7

  .. note::

    It is to be noted that a sub-version *-1* has been added.
    It is the packaging version of WAPT package.

    It allows the Package Developer to release several WAPT package versions
    of the same software.


* make changes to the code in the :file:`setup.py` file accordingly;

  .. code-block:: python

    :emphasize-lines: 8
    # -*- coding: utf-8 -*-
    from setuphelpers import *

    uninstallkey = []

    def install():
        apt_install('vlc')

* save the package;

Managing the uninstallation
---------------------------


* make changes to the :file:`setup.py` file with an uninstall ;

 .. code-block:: python

   def uninstall():
   apt_remove('vlc')


* launch a :guilabel:`remove` from VSCode :guilabel:`Run Configurations`;

  .. image:: remove_package-linux.png
    :align: center
    :alt: After uninstallation, the software is correctly removed

  After uninstallation, the software is correctly removed

  We can notice the correct uninstallation by launching
  :command:`dpkg -l | grep vlc` command.



.. hint::

  In the :command:`uninstall()` function, it is not possible to call for files
  included inside the WAPT package. To call files from the package,
  it is necessary to copy/ paste the files in a temporary directory
  during package installation.

Managing the session-setup
--------------------------

* make changes to the :file:`setup.py` file with an session-setup ;

  In this example, you'll need a :file:`vlcrc` file in your package to copy in home user.
  :guilabel:`ensure_dir` function and :guilabel:`filecopyto` is from **setuphelpers**,
  first one will test if path exists, second one will copy your file from wapt package to its destination.

  .. code-block:: python

    def session-setup():
      vlcdir = os.path.join(os.environ['HOME'], '.config', 'vlc')
      ensure_dir(vlcdir)
      filecopyto('vlcrc',vlcdir)


* launch a :guilabel:`session-setup` from VSCode :guilabel:`Run Configurations`;

  .. image:: remove_package-linux.png
    :align: center
    :alt: After uninstallation, the software is correctly removed


Build and upload the package
----------------------------

Once the installation and the de-installation are configured and tested
and the package is customized to your satisfaction, you may build and upload
your new WAPT package onto your WAPT repository.

From a Linux environment, you have to get your :mimetype:`.pem` / :mimetype:`.crt` key on it with a :program:`WinSCP` or :program:`rsync`.
Usually, this couple is in  :file:`C:\\private` on your windows computer which created private/public key.
Then, give path of certificate in  :file:`/opt/wapt/wapt-get.ini` .

.. code-block:: bash

  sudo vim /opt/wapt/wapt-get.ini

Give path to your certificate :

.. code-block:: bash

  personnal_certificate_path=/opt/wapt/private/mykey.crt

Then launch  a :guilabel:`build-upload` from VSCode :guilabel:`Run Configurations`

.. image:: build_upload_package-linux.png
  :align: center
  :alt: When everything is ready, upload your package

Give password of private key then admin/password of your ::guilabel:`waptconsole`.
Your package is in your private repository on your WAPT server.
