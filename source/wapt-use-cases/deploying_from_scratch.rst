.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
    :description: Simplifying the imaging of your workstations
    :keywords: WAPT, documentation, master, cloning, MDT, Fog

.. _wapt_ghosting_hosts:

Simplifying the imaging of your workstations
============================================

We observe that many companies and administrations include software
and configurations in the Windows images they deploy on their fleets of machines.

**If you use WAPT, lose this habit now and forever! Why?**

* Each time you make a new image, you waste a lot of time installing software
  and configuring it. You are very limited in the user configurations
  that you will be able to include in your image.

* each time you make a new image, if you are serious about it,
  you will have to keep track of the changes in a text document,
  a spreadsheet, or a change management tool. It's a very heavy
  and thankless burden. And you know as well as I do,
  what's ungrateful is usually badly done!

* finally, if you introduce in your image security configurations,
  network configurations, or configurations to limit the intrusion
  of Windows telemetry, these configurations can disrupt the normal functioning
  of WAPT, it will complicate future diagnostics, and it will discourage you
  from using an efficacious tool very capable of freeing up your time.

What do you suggest to do then?
-------------------------------

Tranquil IT recommends:

* to make only one raw image per OS type with `MDT <https://docs.microsoft.com/
  en-us/configmgr/mdt/>`_ or `Fog <https://fogproject.org/>`_
  (win10, win2016, etc) without any configuration or software.
  **Put only the system drivers** you need for your image deployment
  in the MDT or Fog directories provided for this purpose;

* to configure your WAPT server to register hosts with a random UUID
  to avoid :ref:`UUID Bios or FQDN conflicts <create_WAPT_agent>`;

* to create as many Organizational Units as you have machine types
  in the *CN=Computers* OU (ex: *standard_laptop*, *hardened_laptop*,
  *workstations*, *servers*, etc) in your Active Directory;

* to configure your Active Directory to distribute the WAPT Agent GPO
  to the different Host Organizational Units; This way, you can opt for
  fine grained configurations of your :file:`waptagent.ini` for the hosts
  attached to each OU.

...note::

  Alternatively, you may include a generic WAPT agent in your OS image.

* to properly configure your DHCP to redirect the PXE
  to the correct system images;

* to properly configure your MDT or Fog to register the machine
  in the correct Organizational Unit of your Active Directory;

* to create as many WAPT security configuration packages
  as you have Organizational Units created above. Thus, you will be able
  to apply different security profiles depending on the type of machine.
  These packages will include the desired security configurations
  (telemetry suppression, firewall configuration, etc);

.. hint::

  To save you time, you can base your security configuration strategy
  on security WAPT packages already available in the WAPT Store,
  you will only need to complete them according to your organization's
  specific security requirements.

* to create in the *CN=Computers* OU as many Organizational Units
  as there are types of computer usage in your organization (*accounting*,
  *point_of_sale*, *engineering*, *sedentary_sales*, etc);

* to create generic WAPT packages of your software applications
  with their associated configurations;

.. note::

  To save you time and effort, you can import many proven WAPT packages
  from Tranquil IT's public stores or subscribe to Tranquil IT's private stores.

* to associate the WAPT packages created above with the Organizational Units
  of the typologies of computer use;

How does the scenario work?
---------------------------

* you receive or the IT manager at the remote site receives
  a new machine in its box;

.. hint::

  Alternatively, you choose or the IT manager at the remote site chooses
  to switch an existing machine from win7 to win10. You will either have,
  or he will have previously backed up the user directory(s)
  to a network drive or another convenient storage media;

* you configure MDT or Fog with the machine's MAC address so that
  it gets the right system image through DHCP and is positioned
  in the right Organizational Unit at the end of the cloning process;

* the expected system image is downloaded on the machine in masked time,
  the machine is placed in the right Organizational Unit;

* the WAPT agent registers the machine with the WAPT server,
  it appears in the WAPT console;

.. hint::

  If your machines are from a win7 to win10 update, then you will remove
  the old win7 machines from the WAPT inventory as they will be duplicated
  due to your choice of random UUID configuration; these machines will be easy
  to find in the WAPT console because they will be marked as win7
  with the same MAC address or the same FQDN as your new machine in win10;
  after removing the win7, your inventory will be clean and up to date
  in your WAPT console;

* the WAPT agent detects that it is in an Organizational Unit that requires
  a particular software set and a particular security configuration;

* the WAPT Agent downloads and executes software packages
  and security configuration packages in hidden time;
  the WAPT Agent automatically removes delegated rights that are rendered useless
  after joining the domain to prevent them from being subsequently exploited
  in an unauthorized manner;

* either by group of machines or machine by machine, you finalize
  the configuration of the machines by assigning specific WAPT packets to them;

.. hint::

  If you want, you can even leave the final configuration step to your users
  by configuring WAPT self-service for them (printer configurations,
  special software needs, etc).

Conclusion
----------

With little effort, you now have full control over a fleet of several hundreds
or even thousands of geographically dispersed machines. All your installations
are documented, your users work with adequate rights and you benefit
from a clear visibility on your users' tools and uses.
In this way, the past is no longer an imponderable burden for you
and an obstacle to your future projects.

because
