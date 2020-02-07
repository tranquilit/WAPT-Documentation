.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Working with multiple repositories
  :keywords: multi-repositories, business applications, licenced applications,
             license restricted software, self-service applications

.. _work_multiple_repos:

Working with multiple repositories
==================================

Multi-repository is now supported by WAPT.
This functionality is useful in several use cases:

* to use a secondary private repository, hosting business application packages,
  independently of your main repository;

* to have remote repositories closer to users in a multi-site
  architecture scenario;

* to allow the usage of an open repository and a secondary repository
  with restricted access (licensed software..);

.. figure:: multirepo_diagram.png
    :align: center
    :alt: Multi-repository WAPT architecture

    Multi-repository WAPT architecture

.. attention::

  When using repositories with different signers, the additional signer's
  public certificates must be added to :file:`C:\\Program Files (x86)\\wapt\\ssl`.
  You then must deploy WAPT agent with both keys.

  Please refer to the documentation to :ref:`create
  the WAPT agent <create_WAPT_agent>`.

Configuring the WAPT agents
---------------------------

* *repositories* parameter:

  The parameter *repository* in the ``[global]`` section of the
  :file:`wapt-get.ini` file allows to set several options for
  package repositories, for example *private* and *tranquilit* sections here,
  where their settings are set in additional sections of that file.

  .. code-block:: bash

    repositories=private,tranquilit

* settings of secondary repositories

  .. code-block:: ini

    [private]
    repo_url=https://srvwapt.mydomain.lan/wapt

    [tranquilit]
    repo_url=https://wapt.tranquil.it/wapt

  With that configuration, WAPT clients will now see packages
  from the main repository and from the secondary repository.

  The WAPT agents will look for updates on both repositories.

  .. code-block:: bash

    wapt-get search

  Packages from the secondary repository will also be visible
  using the web interface http://127.0.0.1:8088 on WAPT equipped devices.

Configuring the WAPT console with several private repositories
--------------------------------------------------------------

After having configured the WAPT agent for using multiple repositories,
we can make the two repositories show up in the WAPT console.

To do so, modify :file:`%appdata%\local\waptconsole\waptconsole.ini` file:

.. code-block:: ini

  [private]
  repo_url=https://srvwapt.mydomain.lan/wapt

  [tranquilit]
  repo_url=https://wapt.tranquil.it/wapt
