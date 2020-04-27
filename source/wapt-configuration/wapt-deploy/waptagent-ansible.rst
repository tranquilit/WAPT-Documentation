.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Deploying the Linux WAPT Agent with Ansible
  :keywords: waptagent, linux, deployment, deploy, Ansible, documentation, WAPT

.. _install_waptagent_ansible:

Deploying the Linux WAPT Agent with Ansible
===========================================

To avoid mistakes and automate your WAPT agents deployment on Linux,
we provide Ansible roles for installing WAPT agents on:

* Debian;

* Ubuntu;

* RHEL;

* CentOS;

You can explore the role source code
`by visiting this link on Github <https://github.com/tranquilit/ansible.waptagent>`_.

Requirements
------------

* Debian Linux or CentOS hosts;

* a sudoers user on these hosts;

* Ansible 2.8;

Installing the Ansible role
---------------------------

* install ``tranquilit.waptagent`` Ansible role;

  .. code-block:: bash

    ansible-galaxy install tranquilit.waptagent

* to install the role elsewhere, use the *-p* subcommand like this;

  .. code-block:: bash

    ansible-galaxy install tranquilit.waptagent -p /path/to/role/directory/

Using the Ansible role
----------------------

* ensure you have a working ssh key deployed on your hosts,
  if not you can generate and copy one like below;

  .. code-block:: bash

    ssh-keygen -t ed25519
    ssh-copy-id -i id_ed25519.pub user@computer1.mydomain.lan
    ssh user@computer1.mydomain.lan -i id_ed25519.pub

* edit Ansible hosts inventory ( :file:`./hosts` ) and add the Linux hosts;

  .. code-block:: ini

    [computers]
    computer1.mydomain.lan ansible_host=192.168.1.50
    computer1.mydomain.lan ansible_host=192.168.1.60

* create a playbook with the following content
  in :file:`./playbooks/deploywaptagent.yml`;

  .. code-block:: yaml

    - hosts: computers
      roles:
        - { role: tranquilit.waptagent }

* ensure all variables are correctly set
  (see :ref:`install_waptagent_ansible_vars`);

  * ``wapt_server_url``;

  * ``wapt_repo_url``;

  * ``wapt_crt``;

.. important::

  Variables configuration is important as it will configure the behavior
  of the WAPT.

  You **must** replace the default certificate with your Code-Signing
  public certificate.

* run your playbook with the following command;

.. code-block:: bash

  ansible-playbook -i ./hosts ./playbooks/deploywaptagent.yml -u user --become --become-method=sudo -K

**Congratulations, you have installed your WAPT agent on your Linux hosts!**

Role variables
--------------

Available variables are listed below, along with default values
(see ``defaults/main.yml``).

WAPT agent variables
++++++++++++++++++++

* version of WAPT that will be installed from WAPT Deb/RPM repository;

.. code-block:: yaml

  wapt_version: "1.8"

* version of CentOS used for RPM repository address;

.. code-block:: yaml

  centos_version: "centos7"

.. _install_waptagent_ansible_vars:

wapt-get.ini variables
++++++++++++++++++++++

The ``wapt_server_url`` parameter points to your WAPT server and is used
by default for the ``wapt_repo_url``.

.. code-block:: yaml

  wapt_server_url: "https://srvwapt.mydomain.lan"
  wapt_repo_url: "{{ wapt_server_url }}/wapt/"

You can override it like so:

.. code-block:: yaml

  wapt_server_url: "https://wapt.landomain.lan"
  wapt_repo_url: "https://wapt.otherdomain.com/wapt/"

Certificate filename located in :file:`files/` subdirectory of the role:

.. code-block:: yaml

  wapt_crt: "wapt_ca.crt"

Example Ansible playbook
""""""""""""""""""""""""

Here is an example of an Ansible playbook.

.. code-block:: yaml

  - hosts: hosts
    vars_files:
      - vars/main.yml
    roles:
      - tranquilit.waptagent
