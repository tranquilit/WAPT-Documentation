.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Replicating a repository to preserve the bandwidth
                on remote sites
  :keywords: multiple repository, WAPT, replication, replicate,
             bandwidth, Syncthing

Replicating a repository to preserve the bandwidth on remote sites
==================================================================

When WAPT is used on bandwidth limited remote sites, it makes sense to have
a local device that replicates the main WAPT repository to reduce
the network bandwidth consumed when deploying updates on your remote devices.

With remote repositories, WAPT remains a solution with a low operating cost
because you don't have to implement high bandwidth
fiber links to take advantage of WAPT.

.. figure:: replication_diagram.png
    :align: center
    :alt: Replicating WAPT repositories

    Replicating WAPT repositories

It works as follows:

  * a small form factor and no maintenance appliance with the role
    of secondary repository is deployed on the local network
    of each remote site;

  * the remote repository replicates the packages from the main repository
    and other repositories;

  * the WAPT clients connect in priority with the repository
    that is the closest to them, the local repository;

.. hint::

  The former method used to sync repositories was Syncthing. 
  
  You can find the old documentation here : :ref:`syncthing_usage`


Introducing WAPT Agent replication role
---------------------------------------

Starting with WAPT 1.7.6, repository replication can be enabled using WAPT agent installed on an existing machine or a dedicated appliance or VM.

The replication role is deployed through a WAPT package that enables Nginx web server and configures scheduling, packages types, packages sync, and much more.


Enabling replication on WAPT Agent 
++++++++++++++++++++++++++++++++++

To enable replication on an existing agent (Linux/Windows) you need to deploy a WAPT package

:TODO:

WAPT Agent replication configuration
++++++++++++++++++++++++++++++++++++

WAPT Agent replication configuration is set in :file:`wapt-get.ini` :

==================================== ======================= ======================================================
Options                              Example value           Definition
==================================== ======================= ======================================================
enable_remote_repo                   True                    Enables remote repository sync
                                                             connections.

local_repo_path                      /var/www/wapt/          Set local repository path

local_repo_time_for_sync_start       22:30                   Set sync start time

local_repo_time_for_sync_stop        05:30                   Set sync stop time

local_repo_sync_task_period          25                      Set sync period 

local_repo_limit_bandwidth           2                       Set sync allowed bandwidth 

remote_repo_dirs                     wapt,waptwua,wapt-host  Set synced folders
==================================== ======================= ======================================================


WAPT Server need to be aware of repository sync :file:`waptserver.ini` :

==================================== ======================= ======================================================
Options                              Example value           Definition
==================================== ======================= ======================================================
remote_repo_support                  True                    Enables remote repository sync server side (sync.json)
==================================== ======================= ======================================================