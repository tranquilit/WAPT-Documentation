.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Differentiating Administrators in WAPT
  :keywords: role level, WAPT, Certificate Authority, Code Signing,
             Administrator, Package Developer, Package Deployer, CA,
             documentation

.. versionadded:: 1.5 Enterprise

.. _new_crt_with_ca:

Differentiating the role level in WAPT
--------------------------------------

.. hint::

  Feature only available with WAPT Enterprise

Introduction
++++++++++++++++++++++++

WAPT offers the possibility to differentiate administrator roles based
on a :abbr:`PKI (Public Key Infrastructure)` to sign packages and actions.

.. hint::

  The following description of roles differentiation is temporary
  as it will evolve in the near future.

.. figure:: role-separation-schematics.png
  :align: center
  :alt: WAPT admin users roles differentiation

  WAPT admin users roles differentiation

There are three cases:

====================================================== =======================================================================================================
Private key + certificate types                        Key usages
====================================================== =======================================================================================================
Simple private key + certificate                       Allows authentication on WAPT console + interactions with WAPT agents
Developer private key + certificate                    Allows authentication on WAPT console + interactions with WAPT agents + package signing
Certificate Authority (CA) private key + certificate   Allows authentication + interactions + package signing + private key issuing
====================================================== =======================================================================================================

Common WAPT install will generate a CA private key by default,
allowing private key issuing for developers and package signing.

It is possible to emit a Certificate Authority for each subsidiaries.
It is then possible to issue a personal private key
and its corresponding certificate to each IT admins.

By looking at the above schematics, we can deduce the following conclusion:

* WAPT agents in HQ can be managed by HQ IT team
  and cannot be managed by subsidiaries IT teams;

* WAPT agents in the subsidiary having both certificates,
  from HQ and subsidiary, can be managed by local IT team and by HQ IT team;

The usage of an existing PKI is possible,
WAPT Console comes with a simple certificate generator.

Generating a new certificate
++++++++++++++++++++++++++++

.. figure:: role_separation-build-certificate.png
  :align: center
  :alt: Generating a new self-signed certificate

  Generating a new self-signed certificate

Generating the Certificate Authority (CA)
+++++++++++++++++++++++++++++++++++++++++

When installing WAPT, you are asked to create a :mimetype:`.pem` / :mimetype:`.crt`
pair by checking the boxes :guilabel:`Certificate CA` and :guilabel:`Code Signing`.

This crt/ pem pair will allow to sign WAPT packages and new certificates.

Generating a new certificate with the Certificate Authority
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

To create a new pem/ crt pair from the private key, click on
:guilabel:`Create a certificate`.

.. note::

  The new certificate will not be a self-signed certificate;

  This new certificate will be signed by the AC (the key generated
  at the time of the first installation of WAPT);

You must then fill in the :guilabel:`AC's certificate`
and the :guilabel:`AC's key`.

When generating the new pem/ crt pair, you have the option to choose whether
or not the new certificate will be a **Code Signing** type.

.. hint::

  For recall, a *Code Signing* certificate is reserved to individuals
  with the :term:`Administrator` role in the context of WAPT and a simple SSL
  certificate without the ``Code Signing`` attribute is reserved to individuals
  with the role of :term:`Package Deployer`.

  :term:`Administrators` will be authorized to sign packages
  that **CONTAIN** a :file:`setup.py` executable file (i.e. *base* packages).

  Individuals with the :term:`Package Deployer` role will be authorized
  to sign packages that **DO NOT CONTAIN** :file:`setup.py` executable file
  (i.e. *host*, *unit* and *group* packages).

.. figure:: role_separation-generate-non-code-signing-certicate.png
  :align: center
  :alt: Generating a certificate without the *Code Signing* attribute

  Generating a certificate without the *Code Signing* attribute

Keys and certificates that are **Not Code Signing** may be distributed
to individuals in charge of deploying packages on the installed base of
WAPT equipped devices.

Another team with certificates having the **Code Signing** attribute
will prepare the WAPT packages that contain applications that will need
to be configured according to the :term:`Organization`'s security guidelines
and the user customizations desired by her.

.. figure:: role_separation-generate-code-signing-certificate.png
  :align: center
  :alt: Generating a certificate with the *Code Signing* attribute

  Generating a certificate with the *Code Signing* attribute

Generating a new prm/ crt pair will also allow to formally identify
the individual who has signed a package by looking up the WAPT package
certificate's :abbr:`CN (Common Name)` attribute.

.. hint::

  The new certificates will not be *CA Certificates*, which means that they will
  not be authorized to sign other certificates.

  As a general rule, there is only one **CA Certificate** pem / crt pair per
  :term:`Organization`.

Deploying certificates of local IT admins on client
+++++++++++++++++++++++++++++++++++++++++++++++++++

Some Organisations will choose to let local IT administrators perform actions
on WAPT equipped devices by issuing them personnal certificates that will work
on the set of devices for which the local IT admins are responsible.

The headquarter IT admins will deploy the certificates of local IT admins
on the computers that local admins manage on their respective sites.

This way, local IT admins will not be able to manage computers located
in headquarters, but on their own sites only.

You will need to copy the certificates of allowed local IT admins
on client in :file:`C:\\program files(x86)\\wapt\\ssl`.

.. hint::

  Do not forget to restart the WAPT service on clients for them
  to use their new certificate. Open a command line :program:`cmd.exe` then:

  .. code-block:: bash

    net stop waptservice
    net start waptservice

If you want to deploy the certificates using WAPT, below is an example
of a package to deploy certificates on client computers.

.. code-block:: python

  # -*- coding: utf-8 -*-
  from setuphelpers import *

  uninstallkey = []

  def install():
    print(ur"Copy of AC's distant site")
    filecopyto('ca_distant.crt',makepath(install_location('WAPT_is1'),'ssl',))

  def audit():
    print('Auditing %s' % control.asrequirement())
    return "OK"

  if __name__ == '__main__':
    update_package()
