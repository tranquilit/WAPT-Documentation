.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. note::

  Those actions must be run on WAPT Server.

In the list of shared folders (:guilabel:`Shares`):

    * add a shared folder with :menuselection:`Add a Share`;

    * fill in the path to the directory to be shared,
      ex: :file:`/var/www/wapt/`;

    * in the scroll-down menu :menuselection:`Directory Type --> Only Send`;

    * in the scroll-down menu :menuselection:`File Recovery Order
      --> Older First`;

    * redo the same operation for wapt-host: :file:`/var/www/wapt-host/`;

* add the remote repository to WAPT Server's Syncthing:

    Once Syncthing has been installed on the main and remote repositories,
    recover the remote repository's
    ID (:menuselection:`Actions --> Show My ID`).

    This unique identifier appears like

    .. code-block:: bash

      DSINDDC-23ORDNM-PAK6FCL-ZJAKNCH-61GWXAT-77PC3JM-RZ4PPYP-K1QERAV

    On the main repository, in the list of remote devices
    (:guilabel:`Other Devices`):

      * add the remote repository with :menuselection:`Add a Device`;

      * fill in the ID of the remote repository;

      * tick the checkbox for the shared folder :guilabel:`wapt`
        and :guilabel:`wapt-host`;

    On the remote repository, follow these steps:

      * the remote device receives a Syncthing notification that it has
        been approved and added to the main device's replication schedule;

      * the client receives a popup form asking to accept the synchronized
        shares :file:`wapt` and :file:`wapt-host`;

The replication is now operational.
