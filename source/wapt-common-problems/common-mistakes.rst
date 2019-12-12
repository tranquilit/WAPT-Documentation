.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Common mistakes
  :keywords: WAPT, documentation, mistakes

Common mistakes
===============

Using a network drive to store and deliver WAPT packages
--------------------------------------------------------

The standard way WAPT works is with a secure web server delivering WAPT packages
to the WAPT Clients.

Tranquil IT advises against using a network drive for delivering
WAPT packages for several reasons:

* a web server is extremely easy to setup, secure, maintain, backup and monitor;

* to work correctly, a WAPT package needs to be self-contained.
  Indeed, we do not know if the network will be available at the time
  of the installation launch (for example if we have a waptexit that starts
  when the workstation is shutting down on a network
  with 802.1x user authentication, there will no longer be a network available
  at the time of installation). The self-contained nature of WAPT makes it
  more deterministic than other deployment solutions;

* network congestion may result from downloading large packages
  on large fleets of devices because you have less control over bandwidth
  rates or you may not be able to finish a partial download;

* this method breaks or at least weakens the security framework of WAPT;

* this method does not allow you to expose your repositories to internet
  for your traveling personnel;

.. attention::

  Even though WAPT *can work* independently of the transport mode,
  **Tranquil IT will not officially support using a network drive to store
  and deliver WAPT packages**.
