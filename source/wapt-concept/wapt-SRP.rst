.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Disrupting Microsoft's plan for forcing you to go Corporate licensing
  :keywords: WAPT, Software Restriction Policies, SRP, WDAC,
             Windows Defender Application Control, Applocker, doumentation

.. _wapt_working_with_srp:

Disrupting Microsoft's plan to force you to go Corporate licensing
==================================================================

One **fantastic side benefit** that can be obtained from WAPT is enforcing
a concept that has traditionally been called :abbr:`SRP (Software Restriction Policies)`
on Windows systems.

**SRPs can complement, and even replace costly and sometimes ineffective
anti-virus software. SRPs work on the very simple principle of allowing
only known and trusted programs to run, while forbidding any other executable.
Allowed programs are just a signed list of paths
(absolute paths or paths validating a set of rules) leading to binaries
that have themselves been signed by a trusted Authority,
either by the operating system manufacturer, by a well known software editor,
or ideally by your own Organisation.**

**Basically, what the admin does not know does not run, SIMPLE!!**

*SRPs* work most effectively if the following two principles are applied:

* the user logs without administration rights because anyone with admin rights
  to their local device can subvert Software Restriction Policies;

* the host has been freshly reimaged from a trusted source, updated
  and is therefore free from any virus or malware program;

.. note::

  The only known drawback to the concept of *Software Restriction Policies*
  is that system administrators need to be good listeners of the needs
  of their users and be quick to cycle a solid solution into production
  when a legitimate user need arises.

SRPs since Windows7
-------------------

SRPs have existed in Professional Edition since Windows XP.
They can be managed by setting :abbr:`GPO (Group Policy Object)` with
the :abbr:`RSAT (Remote Server Administration Tool)` console
in an Active Directory Environment.

In Windows7 and Windows8 Enterprise version, SRPs are called *Applocker*
and come with some additional features over simple SRPs.
*Applocker* rules are deployed using GPO.

SRPs with Windows10 and beyond
------------------------------

In Windows10, SRPs and *Applocker* are replaced with a thing called
WDAC or `Windows Defender Application Control <https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-application-control/windows-defender-application-control>`_.

We believe this move demonstrates the underlying strategy from Microsoft
to try to move all non corporate Windows users to its Azure cloud platform,
while making pay exorbitant amounts per desktop to allow corporate customers,
who can not adopt a GAFAM cloud for sovereign reasons,
to keep their own systems for managing their fleets of users, passwords,
desktops, software and configurations.

WDAC policies can only be created on computers beginning
with Windows 10 Enterprise or Windows Server 2016 and above.

WDAC rules can be applied to computers running any edition of Windows 10
or Windows Server 2016.

Group Policy can be used to deploy WDAC policies only to **Windows 10
Enterprise edition** or Windows Server 2016 and above.

The WDAC rules can be managed via Mobile Device Management (MDM)
and WAPT can be your MDM of choice to deploy WDAC rules
on your fleets of workstations.

Why WAPT is the WDAC companion system that will rule them all?
--------------------------------------------------------------

*Applocker* had been created to improve on the concept of SRPs
for the following main reasons:

* making software restriction policies version aware because hash rules
  quickly become invalidated as application updates are released;

* making the process of creating policies easier with a rule generation wizard;

* making easier the import and export of rule sets, which allows to create
  a set of rules and then export them to a file
  that can be imported onto another computer (ex: computers that are not
  domain members and therefore not subject to a centralized set
  of Group Policy rules);

So, if we think of WAPT as a surrogate for GPOs that can apply scheduled audits
for inspecting registry hives and insuring that checksums have not changed,
we can have the following benefits:

* corporate entities can **avoid paying the Microsoft Enterprise subscription
  for Windows 10 and stay with the Windows 10 Professional** edition
  because WDAC rules can be managed using WAPT instead of GPOs
  in Active Directory;

* the telemetry in Windows10 Professional can be mostly tamed using
  off-she-shelf WAPT packages and firewall and proxy rules;

* entities can insure *Software Restriction Policies* **compliance on devices
  that are not joined to a domain**;

* *Software Restriction Policies* and WDAC rules and checks **can be embedded
  into WAPT packages so that policies can be easily audited**;

* fleet wide **SRP reporting can be easily setup** using WAPT's native reporting
  framework and tools;

* *Software Restriction Policies* and WDAC rules can de facto be **safely
  imported from one computer and exported to another** so long it is running
  a WAPT agent equipped with the proper certificates;
