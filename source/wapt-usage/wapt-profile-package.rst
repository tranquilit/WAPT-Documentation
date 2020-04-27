.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Using profile packages in WAPT
  :keywords: WAPT, console, profile, Active Directory

.. _wapt_profile_bundles:

.. versionadded:: 1.7 Enterprise

Using profile bundles in WAPT
===========================================

.. hint::

  Feature only available with WAPT **Enterprise**.


Working principle
-----------------

WAPT Enterprise offers Active Directory profile bundle functionnality.

It automates software installations based on your Active Directory Computer's Security Groups.

The expected behavior of that functionnality is an automatic installation of packages based
on their membership to AD Computer's Security Groups.

.. important::

    Active Directory computer's security groups contains Computers, **not Users**.

    .. figure:: profile-bundle/wapt-profile-bundle-computer-groups.png
      :align: center
      :alt: Active Directory computer group.

      Active Directory computer group.


    No such fonctionnality of user groups membership is implemented in WAPT



Creating profile bundle packages in WAPT console
-----------------------------------------------------

You can create *profile* bundle packages by clicking on :menuselection:`Bundles -> Create AD Profile`.

.. figure:: profile-bundle/wapt-profile-bundle-create-group1.png
  :align: center
  :alt: Right-click on OU to create unit bundle

  Create profile bundle.

.. important::

  Requirements :

  * The profile package name must **exactly** be the same as the AD Security group name.
  * The profile package name is case sensitive.

  Example :

  * AD Security group : ``HW_laptops``
  * WAPT profile bundle : ``HW_laptops``


A window opens and you are prompted to choose which packages
must be in **profile** bundle.

.. figure:: profile-bundle/wapt-profile-bundle-create-group2.png
  :align: center
  :alt: Adding packages to unit bundle

  Adding package to profile bundle.

Save the package and it will be uploaded to the WAPT server.
