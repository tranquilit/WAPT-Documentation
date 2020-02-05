.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
    :description: Configuring the Organization's DNS for WAPT
    :keywords: DNS, WAPT, A field, documentation

.. _srv_dns:

Configuring the Organization's DNS for WAPT
-------------------------------------------

.. note::

  **DNS configuration is not strictly required,
  but it is very strongly recommended**.

In order to make make your WAPT setup easier to manage, it is strongly
recommended to configure the :term:`DNS` server to include :term:`A field`
or :term:`CNAME field` as below:

* *srvwapt.mydomain.lan*;

* *wapt.mydomain.lan*;

Replace *mydomain.lan* with your network's :term:`DNS` suffix.

These DNS fields will be used by WAPT agents to locate the WAPT Server
and their WAPT repositories closest to them.

Configuring DNS entries in Microsoft RSAT.
------------------------------------------

* The *A* field must point to the WAPT Server IP address;

.. figure:: dns-configure-alias.png
   :align: center
   :alt: Configuration of the A field in Windows RSAT

   Configuration of the A field in Windows RSAT

You can now install the WAPT Server on your favorite operating system:

* :ref:`install the WAPT Server on GNU / Linux Debian <install_base_debian>`;

* :ref:`install the WAPT Server on CentOS / RedHat <install_base_centos>`;

* :ref:`install the WAPT Server on Windows <wapt-server_win_install>`;
