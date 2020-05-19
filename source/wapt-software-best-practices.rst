.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
    :description: Applying best practices to packaging software
    :keywords: WAPT, packaging, best practice, documentation

.. _software_packaging_best_practices:

Applying best practices to packaging software
=============================================

.. note::

  `_benwa <https://www.reddit.com/user/_benwa/>`_ is a system administrator
  and he has authorized Tranquil IT to republish his excellent rant on reddit
  `Developers, you can make sysadmins happier <https://www.reddit.com/r/sysadmin/comments/g6d5wx/developers_you_can_make_sysadmins_happier/>`_.

Environnement variables
-----------------------

* Environmental variables `have been around since DOS <https://en.wikipedia.org/wiki/Environment_variable#DOS>`_.
  They can make your (and my) life easier.

Program directories
-------------------

* Not every system uses ``C:\`` as the main drive. Some enterprises
  use folder redirection, and relocate the Documents folder.
  Some places in the world don't speak English and their directories
  reflect that. **Use those environmental variables to make
  your programs "just work"**:

  * ``%SystemDrive%`` is the drive where ``%SystemRoot%`` is located.
    You most likely don't need to actually know this;

  * ``%SystemRoot%`` is where the Windows directory is located.
    You hopefully don't care about this. Leave the Windows directory alone;

  * ``%ProgramFiles%`` is where you should place your program files,
    preferable in a ``Company\Program`` structure;

  * ``%ProgramFiles(x86)%`` is where you should place your 32-bit program files.
    Please update them for 64-bit. 32-bit will eventually be unsupported,
    and business will be waiting for you to get your shit together
    for far longer than necessary;

  * ``%ProgramData%`` is where you should store data that isn't user specific,
    but still needs to be written to by users (Users don't have write access
    to this folder either).

    Your program shouldn't require administrator rights
    to run as you shouldn't have us writing to the ``%ProgramFiles%`` directory.
    Also, don't throw executables in here.

  * ``%Temp%`` is where you can process temporary data.
    Place that data within a unique folder name (maybe a generated GUID perhaps)
    so you don't cause an incompatibility with another program.
    Windows will even do the cleanup for you. Don't put temporary
    data in in ``%ProgramData%`` or ``%ProgramFiles%``;

  * ``%AppData%`` is where you can save the user running your program settings.
    This is a fantastic location that can by synced with a server and used
    to quickly and easily migrate a user to a new machine and keep
    all of their program settings. Don't put giant or ephemeral files here.

    You could be the cause of a very slow login if you put the wrong stuff here
    and a machine needs to sync it up. **DON'T PUT YOUR PROGRAM FILES HERE**.
    The business decides what software is allowed to run, not you and a bunch
    of users who may not know how their company's environment is set up;

  * ``%LocalAppData%`` is where you can put bigger files that are specific
    to a user and computer. You don't need to sync up a thumbnail cache.
    They won't be transferred when a user migrates to a new machine,
    or logs into a new VDI station, or terminal server.
    **DON'T PUT YOUR PROGRAM FILES HERE EITHER**;

.. note::

  More and more of you software editors offer *portable* versions
  of your software that will install in and run from ``%AppData%``
  or ``%LocalAppData%``. Your aim is to let users install software
  even though they are not Local Administrators and you market that as a feature,
  although it is more of a security NOGO. Even worse, you tend to make it
  difficult to find the proprer :mimetype:`MSI` that would allow
  your customers to correctly install your software in ``%ProgramFiles%``.
  Please, make it easy to find your :mimetype:`MSI` that will install
  in ``%ProgramFiles%``, this way you'll make your customer AppLock
  and Software Restriction Policies work well and their sysadmins happy.

  You can get these directory paths through `API calls <https://docs.microsoft.com/en-us/windows/win32/shell/known-folders>`_
  as well if you don't/can't use environmental variables.

Logs
----

* Use the `Windows Event Log <https://docs.microsoft.com/en-us/windows/win32/eventlog/event-logging>`_ for logging.
  It'll handle the rotation for you and a sysadmin can forward those logs
  or do whatever they need to. You can even make your own little area
  just for your program.

Error codes
-----------

* Use `documented Error Codes <https://docs.microsoft.com/en-us/windows/win32/debug/system-error-codes>`_
  when exiting your program.

Printing
--------

* Use the `Windows printing API <https://docs.microsoft.com/en-us/windows/win32/printdocs/printdocs-printing>`_
  and do not use direct printing in your program.

Distribution
------------

* Distribute your program in `MSI <https://docs.microsoft.com/en-us/windows/win32/msi/installer-function-reference>`_.
  It is the standard for Windows installation files (even though Microsoft
  sometimes doesn't use it themselves).

* `Sign your installation file and executables <https://docs.microsoft.com/en-us/windows/win32/appxpkg/how-to-sign-a-package-using-signtool>`_.
  It's how we know it's valid and can whitelist in `AppLocker <https://docs.microsoft.com/en-us/powershell/module/applocker/?view=win10-ps>`_
  or other policies.

.. note::

  Applocker and `Software Restriction Policies <https://dev.tranquil.it/samba/en/samba_config_client/client_SRP.html>`_
  can be very effective and the **management of these policies
  can be made simpler with WAPT**.

Update
------

* Want to have your application update for you? That can be fine if the business
  is okay with it. You can create a scheduled task or service that runs elevated
  to allow for this without granting the user admin rights. I like the way
  Chrome Enterprise does it: gives a GPO to set update settings, the max version
  it will update to (say 81.* to allow all minor updates automatically
  and major versions are manual), and a service. They also have a GPO
  to prevent user-based installs;

.. note::

  WAPT is designed for businesses that don't allow users to run software updates,
  which is the policy often chosen in large security conscious enterprises.

Version numbers
---------------

* Use `semantic versioning <https://semver.org/>`_ (should go in the version property
  in the installer file and in the Add/Remove Programs list, not in the application title)
  and have a `changelog <https://keepachangelog.com/>`_. You can also have
  your installer download at a predictable location to allow for automation.
  A published update path is nice too;

.. note::

  If you apply this practice, then you will make system administrators
  who deploy your software updates using the
  :ref:`WAPT function def_update() <envdev_setup>` **very happy**!!

GPO
---

* ADMX templates are dope;

.. note::

  We completely agree with you _benwa on this at Tranquil IT. If developers
  advise their customers to use GPOs to deploy their software or system
  or users settings, then, **they must know that GPOs are not fully reliable**.

  Instead, package your software, your system and user configurations using WAPT.
  A :file:`setup.py` is so much easier than an :mimetype:`xml` file
  for system admins to audit before deploying.

  WAPT packages can be applied recursively to trees of Organisational Units,
  so your WAPT package will behave in production exactly as a GPO would,
  **just much easier**.

License dongles
---------------

* USB license dongles are a sin. Use a regular software or network license.
  I'm sure there are off the shelf ones so you don't have to reinvent the wheel;

.. note::

  You can make your software accept a licence key as a parameter
  in your :mimetype:`msi` executable.

  WAPT can be used to assign licence keys to individual workstations
  at install using a :ref:`method that ensures that the licence key can not
  be read during transport <encryting_sensitive_data_in_package>`.

  Then, if you want your software to call home to check on the validity
  of the licence, make the routine work with
  :ref:`proxies <proper_use_of_proxy_in_software>`.

Networking
----------

* Don't use that damn custom IPv4 input field. Use FDQNs. IPv6 had been around
  since 1998 and will work with your software if you just give it a chance;

* The Windows Firewall (can't really say much about third party ones)
  is going to stay on. Know the difference between an incoming and outgoing rule.
  Most likely, your server will need incoming. Most likely, you clients
  won't even need an outgoing. Set those up at install time, not launch time.
  Use Firewall Groups so it's easy to filter. Don't use Any rules if you can help it.
  The goal isn't to make it work, it's to make it work securely.
  If you don't use version numbers in your install path, you might not even have
  to remake those rules after every upgrade;

.. _proper_use_of_proxy_in_software:

* Proxies are good for hygiene and proxies are now a default security feature
  not just in corporate IT environments, but even on small networks. Making your
  software not compatible with proxies will require the network administrators
  of your customer to make and maintain special rules in their firewall,
  just for you. It is easy to code your software to work with proxies,
  so please do!

PDFs
----

* Don't ship a software that requires allowing javascript to run in PDF readers.
  Business logic should be run before outputting to a PDF, not after.

.. note::

  :mimetype:`PDF` files is the file format people use by default
  to exchange documents. PDF readers are meant to display documents,
  not execute unsigned programs.
