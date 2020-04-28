.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^


.. meta::
  :description: Installing WAPT Server with Ansible
  :keywords: Ansible, WAPT, install, server, documentation

.. _install_waptserver_ansible:

Installing WAPT Server with Ansible
+++++++++++++++++++++++++++++++++++

To avoid mistakes and automate your WAPT Server deployment,
we provide Ansible roles for WAPT Server installation.

You can explore the role source code by
`visiting Tranquil IT repository on Github <https://github.com/tranquilit/ansible.waptserver>`_.

Requirements
------------

* Debian Linux or CentOS hosts;

* a sudoers user on these hosts;

* Ansible 2.8;

Installing the Ansible role
---------------------------

* install ``tranquilit.waptserver`` Ansible role;

  .. code-block:: bash

    ansible-galaxy install tranquilit.waptserver

* to install the role elsewhere, use the *-p* subcommand like this;

  .. code-block:: bash

    ansible-galaxy install tranquilit.waptserver -p /path/to/role/directory/

Using the Ansible role
----------------------

* ensure you have a working ssh key deployed on your hosts,
  if not you can generate and copy one like below;

  .. code-block:: bash

    ssh-keygen -t ed25519
    ssh-copy-id -i id_ed25519.pub user@srvwapt.mydomain.lan
    ssh user@srvwapt.mydomain.lan -i id_ed25519.pub

* edit Ansible hosts inventory ( :file:`./hosts` ) and add the Linux hosts;

  .. code-block:: ini

    [srvwapt]
    srvwapt.mydomain.lan ansible_host=192.168.1.40

* create a playbook with the following content in :file:`./playbooks/wapt.yml`;

  .. code-block:: yaml

    - hosts: srvwapt
      roles:
        - { role: tranquilit.waptserver }

* run your playbook with the following command;

  .. code-block:: bash

    ansible-playbook -i ./hosts ./playbooks/wapt.yml -u user --become --become-method=sudo -K

**Congratulations, you have installed your WAPT server on your Linux server!**

Role variables
--------------

Available variables are listed below, along with default values
(see ``defaults/main.yml``):

* version of WAPT that will be installed from WAPT Deb/RPM repository;

  .. code-block:: yaml

    wapt_version: "1.8"

* version of PostgreSQL that will be installed from WAPT Deb/RPM repository;

  .. code-block:: yaml

    pgsql_version: "9.6"

* version of CentOS used for RPM repository address;

  .. code-block:: yaml

    centos_version: "centos7"

* ``launch_postconf`` defaults to True, it launches WAPT Server
  postconfiguration script silently;

  .. code-block:: yaml

    launch_postconf: True

Example Ansible playbook
""""""""""""""""""""""""

Here is an example of an Ansible playbook.

.. code-block:: yaml

  - hosts: srvwapt
    vars_files:
      - vars/main.yml
    roles:
      - tranquilit.waptserver
