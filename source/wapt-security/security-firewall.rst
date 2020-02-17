.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
    :description: Configuring authentication against Active Directory
    :keywords: Firewall, WAPT, security, Kerberos, documentation

.. _firewall_wapt_secure:

Firewall configuration for WAPT Server
+++++++++++++++++++++++++++++++++++++++++++++++++++

WAPT Server firewall configuration is essential and should be the first step towards achieving better security in WAPT.

As WAPT aims to be secure by desingn, by doing so a minimal set of ports are needed to be opened compared to other solutions.

You will find in the following documentation firewall command to improve WAPT security.

Data-flow diagram of WAPT
""""""""""""""""""""""""""

.. figure:: diagramme_flux.png
   :align: center
   :alt: Data-flow diagram of WAPT

As you can see, only ports 80 and 443 must be opened for ingoing connections as WAPT works with websockets.


Firewall configuration for WAPT on Debian Linux
"""""""""""""""""""""""""""""""""""""""""""""""

By default on Debian Linux, no firewall rules applies. You can disable ufw and install firewalld instead :

.. code-block:: bash

    ufw disable
    apt update
    apt -y install firewalld

We can now apply sample firewall configuration :

.. code-block:: bash

    systemctl start firewalld
    systemctl enable firewalld
    firewall-cmd --zone=public --add-port=80/tcp --permanent    
    firewall-cmd --zone=public --add-port=443/tcp --permanent
    systemctl restart firewalld


Firewall configuration for WAPT on CentOS Linux
"""""""""""""""""""""""""""""""""""""""""""""""

Sample firewalld configuration to apply on WAPT server 

.. code-block:: bash

    systemctl start firewalld
    systemctl enable firewalld
    firewall-cmd --zone=public --add-port=80/tcp --permanent    
    firewall-cmd --zone=public --add-port=443/tcp --permanent
    systemctl restart firewalld