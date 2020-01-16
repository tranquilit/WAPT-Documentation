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

  Currently, the agent has only been tested on High Sierra (version 10.13) and Mojave (10.14) while the latest version is Catalina (10.15). 
  Catalina may have introduced changes that could prevent the agent from working.

   
Registering the agent
+++++++++++++++++++++

* You may create and configure a wapt-get.ini file in /opt/wapt ( :ref:`wapt-get-ini` )

* You may need to add the following lines to your bash_profile file (~/.bash_profile). If it doesn't exist, you'll need to create it first.

.. code-block:: bash

   export LC_ALL=en_US.UTF-8
   export LANG=en_US.UTF-8

* Finally, execute the following command to register your machine :

.. code-block:: bash

   sudo wapt-get register