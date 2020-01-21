.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Deploying the WAPT agent on MacOS
  :keywords: waptagent, MacOS, deployment, deploy, deploying, documentation, WAPT

.. _install_waptagent_macos:

Deploying the WAPT agent for MacOS
==================================

.. attention::

  Currently, the agent has only been tested on `High Sierra <https://en.wikipedia.org/wiki/MacOS_High_Sierra>`_
  (version 10.13) and `Mojave <https://en.wikipedia.org/wiki/MacOS_Mojave>`_ (10.14)
  while the latest MacOS version is `Catalina <https://en.wikipedia.org/wiki/MacOS_Catalina>`_
  (10.15). Catalina may have introduced changes that could prevent the agent
  from working.

Registering the agent
+++++++++++++++++++++

* create and configure a :file:`wapt-get.ini` file in :file:`/opt/wapt`
  ( :ref:`wapt-get-ini` ). An example of what it should look like is present
  further down on this page : you may use it after changing
  the parameters to suit your needs;

* finally, execute the following command on your MacOS to register your machine:

.. code-block:: bash

   sudo wapt-get register

Example of a wapt-get.ini file
++++++++++++++++++++++++++++++

.. code-block:: ini

   [global]
   repo_url=https://waptserver.mydomain.lan/wapt
   send_usage_report=1
   use_hostpackages=1
   wapt_server=https://waptserver.mydomain.lan
   use_kerberos=0
   check_certificates_validity=1
   verify_cert=/opt/wapt/ssl/verify.crt
   personal_certificate_path=/opt/wapt/ssl/personal_certificate.crt
   dnsdomain=
   max_gpo_script_wait=180
   pre_shutdown_timeout=180
   hiberboot_enabled=0
   host_profiles=
   [wapt-templates]
   repo_url=https://store.wapt.fr/wapt
   verify_cert=1
