.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Changes between versions 1.3 and 1.6 and consequences
  :keywords: WAPT, documentation, changes, 1.3.13, 1.5/1.6, consequences,
             PostgreSQL, MongoDB, Nginx, Websockets, UUID, Code Signing

.. _wapt_changes_1-3_1-5:

Changes between versions 1.3 and 1.6 and consequences
=====================================================

PostgreSQL has replaced MongoDB in WAPT
---------------------------------------

The database :program:`MongoDB` has been replaced by :program:`PostgreSQL`
with JSON support.

The consequence is that **Administrators that have developed reports
based on MongoDB will have to adapt their queries.**

Nginx is now the only supported web server in WAPT
--------------------------------------------------

Introducing Websockets in WAPT brings large benefits:

* status updates from WAPT agents are instantaneous in the WAPT console;

* when the :term:`Administrator` launches immediate actions, it is no longer
  the WAPT Server that connects to the WAPT agent; the WAPT agent establishes
  and maintains a permanent connection with the WAPT Server;

* the Websockets avoid having to have a local listening port on the clients,
  improving the global security of WAPT equipped Organizations;

* since it is the WAPT agent that initiates and maintains a connection
  with the WAPT Server, connections travel through proxies and firewalls
  in a standard manner;

:program:`Nginx` is the only web server capable of handling
a very large quantity of Websockets. This technology is not something
completely trivial to implement and maintain.

As a consequence, **support for IIS and Apache in WAPT is abandoned**.

Signature hashes are sha256 instead of sha1
-------------------------------------------

Control sums for the list of files in the WAPT package and the signature
of the attributes in the :file:`control` file are now sha256 hashed
instead of sha1 hashed to satisfy security requirements
of cyberdefense agencies.

As a consequence, **all packages must be re-signed and the :file:`Packages`
index files of all repositories must be regenerated**.

A script allows to massively re-sign all packages on the WAPT Server.

The host packages are now named after the UUID of the host
----------------------------------------------------------

In versions <= 1.3.xx, host packages are named with
the :abbr:`FQDN (Fully Qualified Domain Name)` of the client host.

This poses some problems if the host is joined to another domain,
or if the host is not joined to a domain, yet goes from a network to another
with different DHCP settings.

In version >= 1.5, the *host* packages are named after the UUID
of the client host, thus resolving the problems described above.

As a consequence, **host packages must be re-created and re-signed**.

A script on the WAPT Server allows to do this operation automatically.

Code Signing attribute for signing base packages
------------------------------------------------

To differentiate between the roles of :term:`Package Deployer`
and :term:`Package Developer`, the WAPT agent verifies the **Code Signing**
attribute of the certificate that has signed the package.

If the package contains python executable code, i.e. a :file:`setup.py` file,
then the package must be signed with a certificate having the **Code Signing**
attribute. **Otherwise, the package will not install**.

As a consequence, **it is necessary to generate and deploy a Code Signing
Certificate on the WAPT equipped hosts**, and re-sign *base* packages
(i.e. software packages) with a **Code Signing** certificate.

The certificate is deployed during the upgrade of the WAPT agent.
