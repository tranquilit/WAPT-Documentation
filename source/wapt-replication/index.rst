.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Replicating repositories and working with multiple repositories
  :keywords: multi-repo, multi-repositories, replicate, replication, bandwidth

.. _wapt_multi-repositories:

Replicating repositories and working with multiple repositories
===============================================================

Large infrastructure with remote sites and subsidiaries sometimes requires services
to be replicated locally to avoid bandwidth congestion.

.. figure:: repository_header.png
    :align: center
    :alt: Replication and multiple repositories

    Repository replication and multiple repositories



WAPT offers the possibility to replicate its repositories on local agents, directly
managed through WAPT Console. WAPT agents can be configured to automatically select the best
repository based on a set of rules.

You'll find in this part of the documentation how to implement
such architectures.

.. toctree::
  :maxdepth: 1

  wapt-replicate-to-multiple-repositories/index.rst


Speaking of repositories, its sometimes usefull to configure two or more repositories for different usage (prod,dev,licensed).

.. toctree::
  :maxdepth: 1

  wapt-work-with-repositories/index.rst


Deprecated configurations
--------------------------

.. toctree::
  :maxdepth: 1

  wapt-replicate-to-multiple-repositories/syncthing_usage.rst