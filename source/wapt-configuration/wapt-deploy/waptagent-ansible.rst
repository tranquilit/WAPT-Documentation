.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Deploying the WAPT Agent on Linux
  :keywords: waptagent, linux, deployment, deploy, deploying, documentation, WAPT

.. _install_waptagent_ansible:

Deploying the WAPT Agent with Ansible
=====================================

To avoid mistakes and automate your WAPT agents deployment, we provide Ansible roles for WAPT agent installation on :

* Debian
* Ubuntu
* RHEL
* CentOS.

You can explore the role source code here : `tranquilit.waptagent <https://github.com/tranquilit/ansible.waptagent>`_.

Requirements
-----------------------

* Debian Linux or CentOS hosts
* a sudoers user on these hosts
* Ansible 2.8

Install Ansible role
-------------------------

* install ``tranquilit.waptagent`` Ansible role

.. code-block:: bash

  ansible-galaxy install tranquilit.waptagent


* to install the role elsewhere, use the command like this

.. code-block:: bash

  ansible-galaxy install tranquilit.waptagent -p /path/to/role/directory/


Using Ansible role
--------------------------

* ensure you have a working ssh key deployed on your hosts, if not you can generate and copy one like so :

.. code-block:: bash

    ssh-keygen -t ed25519
    ssh-copy-id -i id_ed25519.pub user@computer1.mydomain.lan
    ssh user@computer1.mydomain.lan -i id_ed25519.pub


* edit Ansible hosts inventory ( :file:`./hosts` ) and add the Linux hosts :

.. code-block:: ini

    [computers]
    computer1.mydomain.lan ansible_host=192.168.1.50
    computer1.mydomain.lan ansible_host=192.168.1.60


* create a playbook with the following content in :file:`./playbooks/deploywaptagent.yml` :

.. code-block:: yaml

    - hosts: computers
      roles:
        - { role: tranquilit.waptagent }

* ensure all variables are correctly set (see :ref:`install_waptagent_ansible_vars`) :

  * ``wapt_server_url``
  * ``wapt_repo_url``
  * ``wapt_crt``

.. important::

    Variables configuration is important as it will configure WAPT agent behavior.

    You **must** replace default certificate by your Code-Signing public cert.



* run your playbook with the following command :

.. code-block:: bash

    ansible-playbook -i ./hosts ./playbooks/deploywaptagent.yml -u user --become --become-method=sudo -K


* that's it WAPT agent is installed on your hosts !


Role variables
------------------------------

Available variables are listed below, along with default values (see ``defaults/main.yml``):

WAPT agent vars
++++++++++++++++++++++

WAPT version that will be installed from WAPT Deb/RPM repository

.. code-block:: yaml

    wapt_version: "1.8"

CentOS version used for RPM repository address

.. code-block:: yaml

    centos_version: "centos7"


.. _install_waptagent_ansible_vars:

wapt-get.ini vars
++++++++++++++++++++++++++++++++

``wapt_server_url`` points to your WAPT server and is used by default for the ``wapt_repo_url``.

.. code-block:: yaml

    wapt_server_url: "https://srvwapt.mydomain.lan"
    wapt_repo_url: "{{ wapt_server_url }}/wapt/"


You can override it like so :

.. code-block:: yaml

    wapt_server_url: "https://wapt1.landomain.com"
    wapt_repo_url: "https://wapt2.otherdomain.com/wapt/"


Certificate filename located in :file:`files/` subdirectory of the role :

.. code-block:: yaml

    wapt_crt: "wapt_ca.crt"


Example playbook
""""""""""""""""""""""""""""""""""""""

Here is an example of an Ansible playbook

.. code-block:: yaml

    - hosts: hosts
      vars_files:
        - vars/main.yml
      roles:
        - tranquilit.waptagent
