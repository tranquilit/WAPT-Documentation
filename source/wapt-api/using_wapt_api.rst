.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^


.. meta::
 :description: Using the WAPT server APIs
 :keywords: API, Application Protocol Interface, WAPT, documentation

.. _using__wapt_api:

Using the WAPT server APIs
==========================

.. note::

  This documentation does not describe all the available
  :abbr:`APIs (Application Protocol Interfaces)`, it will however concentrate
  on the most useful ones.

All available URLs may be found in :file:`/opt/wapt/waptserver/server.py`.

URLs are formed by calling the proper command from the WAPT Server, ex:
:file:`https://srvwapt/{command_path}`.


.. hint::

  This documentation contains examples using Python code or curl.

API V1
------

/api/v1/hosts
+++++++++++++

* get registration data of one or several hosts:

  .. code-block:: python

     # Args:
     #     has_errors (0/1): filter out hosts with packages errors
     #     need_upgrade (0/1): filter out hosts with outdated packages
     #     groups (csvlist of packages): hosts with packages
     #     columns (csvlist of columns):
     #     uuid (csvlist of uuid): <uuid1[,uuid2,...]>): filter based on uuid
     #     filter (csvlist of field):regular expression: filter based on attributes
     #     not_filter (0,1):
     #     limit (int): 1000
     #     trusted_certs_sha256 (csvlist): filter out machines based on their trusted package certs

     # Returns:
     #     result (dict): {'records':[],'files':[]}
     #     query:
     #       uuid=<uuid>
     #     or
     #       filter=<csvlist of fields>:regular expression
     # """

* list all hosts. Available parameters are;

  * *reachable*

  * *computer_fqdn* ==> computer_name

  * *connected_ips*

  * *mac_addresses*

  This example shows a request with parameters:

  .. code-block:: python

    advanced_hosts_wapt = wgets('https://%s:%s@%s/api/v1/hosts?columns=reachable,computer_fqdn,connected_ips,mac_addresses&limit=10000' % (wapt_user,wapt_password,wapt_url))
    parsed = json.loads(advanced_hosts_wapt)
    print(json.dumps(parsed, indent=1, sort_keys=True))

  This example is a global request:

  .. code-block:: python

    hosts_wapt = wgets('https://%s:%s@%s/api/v1/hosts' % (wapt_user,wapt_password,wapt_url))
    parsed = json.loads(hosts_wapt)
    print(json.dumps(parsed, indent=1, sort_keys=True))

  .. hint::

    This is the same exemple with a simple html request:

    .. code-block:: batch

      https://admin:MYPASSWORD@srvwapt/api/v1/hosts

    This one just show request with reachable status, the computer name,
    its connected ips and its mac addresses. Display limit is 10000

     .. code-block:: batch

        https://admin:MYPASSWORD@srvwapt/api/v1/hosts?columns=reachable,computer_fqdn,connected_ips,mac_addresses&limit=10000

/api/v1/groups
++++++++++++++

* get all group packages. Group is found with section *group* in the package.

  .. code-block:: python

    group_wapt = wgets('https://%s:%s@%s/api/v1/groups' % (wapt_user,wapt_password,wapt_url))
    parsed = json.loads(group_wapt)
    print(json.dumps(parsed, indent=1, sort_keys=True))

  .. hint::

    This is the same exemple with a simple html request:

    .. code-block:: batch

      https://admin:MYPASSWORD@srvwapt/api/v1/groups

/api/v1/host_data
+++++++++++++++++

dmi
"""
* get :abbr:`DMI (Desktop Management Interface)` info for a host:

.. note::

    #
    #    Get additional data for a host
    #    query:
    #      uuid=<uuid>
    #      field=packages, dmi or softwares

Example: get *dmi* information of host which has UUID 14F620FF-DE70-9E5B-996A-B597E8F9B4AD:
https://srvwapt.ad.mydomain.fr/api/v1/host_data?uuid=14F620FF-DE70-9E5B-996A-B597E8F9B4AD&field=dmi

.. note::

  *dmi* is not the only available option. You can also lookup information using
  *installed_packages*, *wsusupdates* ou *installed_softwares*.

.. code-block:: python

    dmi_host_data_wapt = wgets('https://%s:%s@%s/api/v1/host_data?uuid=14F620FF-DE70-9E5B-996A-B597E8F9B4AD&field=dmi' % (wapt_user,wapt_password,wapt_url))
    #print(dmi_host_data_wapt)
    parsed = json.loads(dmi_host_data_wapt)
    print(json.dumps(parsed, indent=1, sort_keys=True))

.. hint::

  This is the same exemple with a simple html request:

  .. code-block:: batch

    https://admin:MYPASSWORD@srvwapt/api/v1/host_data?uuid=14F620FF-DE70-9E5B-996A-B597E8F9B4AD&field=dmi

installed_packages
""""""""""""""""""

Option *installed_packages* will list all packages installed on a specific host.

.. code-block:: python

  install_packages_data_wapt = wgets('https://%s:%s@%s/api/v1/host_data?uuid=14F620FF-DE70-9E5B-996A-B597E8F9B4AD&field=installed_packages' % (wapt_user,wapt_password,wapt_url))
  parsed = json.loads(install_packages_data_wapt)
  print(json.dumps(parsed, indent=1, sort_keys=True))

.. hint::

  This is the same exemple with a simple html request:

  .. code-block:: batch

    https://admin:MYPASSWORD@srvwapt/api/v1/host_data?uuid=14F620FF-DE70-9E5B-996A-B597E8F9B4AD&field=installed_packages

installed_softwares
"""""""""""""""""""

Option *installed_softwares* will list all softwares installed
on a specific host.

.. code-block:: python

  install_softwares_data_wapt = wgets('https://%s:%s@%s/api/v1/host_data?uuid=14F620FF-DE70-9E5B-996A-B597E8F9B4AD&field=installed_softwares' % (wapt_user,wapt_password,wapt_url))
  #print(install_softwares_data_wapt)
  parsed = json.loads(install_softwares_data_wapt)
  print(json.dumps(parsed, indent=1, sort_keys=True))

.. hint::

   This is the same exemple with a simple html request:

   .. code-block:: batch

      https://admin:MYPASSWORD@srvwapt/api/v1/host_data?uuid=14F620FF-DE70-9E5B-996A-B597E8F9B4AD&field=installed_softwares

wsusupdates
"""""""""""

Option *wsusupdates* will list all windows update installed on a specific host.

.. code-block:: python

  wsusupdates_data_wapt = wgets('https://%s:%s@%s/api/v1/host_data?uuid=14F620FF-DE70-9E5B-996A-B597E8F9B4AD&field=wsusupdates' % (wapt_user,wapt_password,wapt_url))
  #print(wsusupdates_data_wapt)
  parsed = json.loads(wsusupdates_data_wapt)
  print(json.dumps(parsed, indent=1, sort_keys=True))

.. hint::

  This is the same exemple with a simple html request:

  .. code-block:: batch

    https://admin:MYPASSWORD@srvwapt/api/v1/host_data?uuid=14F620FF-DE70-9E5B-996A-B597E8F9B4AD&field=wsusupdates

/api/v1/usage_statistics
++++++++++++++++++++++++

Get usage statistics from the server.

.. hint::

  This API is useful if you have several wapt servers and you want
  to know how many hosts are there.

.. code-block:: python

  usage_statistics_wapt =  wgets('https://%s:%s@%s/api/v1/usage_statistics' % (wapt_user,wapt_password,wapt_url))
  #print(usage_statistics_wapt)
  parsed = json.loads(usage_statistics_wapt)
  print(json.dumps(parsed, indent=1, sort_keys=True))

.. hint::

  This is the same exemple with a simple html request:

  .. code-block:: batch

    https://admin:MYPASSWORD@srvwapt/api/v1/usage_statistics

API V2
------

/api/v2/waptagent_version
+++++++++++++++++++++++++

Display :program:`waptagent.exe` version on the server.

.. code-block:: python

  waptagent_version =  wgets('https://%s:%s@%s/api/v2/waptagent_version' % (wapt_user,wapt_password,wapt_url))
  parsed = json.loads(waptagent_version)
  print(json.dumps(parsed, indent=1, sort_keys=True))

.. hint::

   This is the same exemple with a simple html request:

  .. code-block:: batch

    https://admin:MYPASSWORD@srvwapt/api/v2/waptagent_version

API V3
------

/api/v3/packages
++++++++++++++++

List packages on the repository, get control file on package.

.. code-block:: python

  packages_wapt =  wgets('https://%s:%s@%s/api/v3/packages' % (wapt_user,wapt_password,wapt_url))
  parsed = json.loads(packages_wapt)
  print(json.dumps(parsed, indent=1, sort_keys=True))


.. hint::

  This is the same exemple with a simple html request:

  .. code-block:: batch

    https://admin:MYPASSWORD@srvwapt/api/v3/packages

/api/v3/known_packages
++++++++++++++++++++++

List all packages with last *signed_on* information.

.. code-block:: python

  known_packages_wapt =  wgets('https://%s:%s@%s/api/v3/known_packages' % (wapt_user,wapt_password,wapt_url))
  parsed = json.loads(known_packages_wapt)
  print(json.dumps(parsed, indent=1, sort_keys=True))

.. hint::

  This is the same exemple with a simple html request:

  .. code-block:: batch

    https://admin:MYPASSWORD@srvwapt/api/v3/known_packages

/api/v3/trigger_cancel_task
+++++++++++++++++++++++++++

Cancel a running task.

.. code-block:: python

  trigger_cancel_task =  wgets('https://%s:%s@%s/api/v3/trigger_cancel_task' % (wapt_user,wapt_password,wapt_url))
  parsed = json.loads(trigger_cancel_task)
  print(json.dumps(parsed, indent=1, sort_keys=True))

/api/v3/get_ad_ou
+++++++++++++++++

List :abbr:`OU (Organisational Unit)` seen by hosts and displayed
in the WAPT console.

.. code-block:: python

  get_ad_ou =  wgets('https://%s:%s@%s/api/v3/get_ad_ou' % (wapt_user,wapt_password,wapt_url))
  parsed = json.loads(get_ad_ou)
  print(json.dumps(parsed, indent=1, sort_keys=True))


.. hint::

  This is the same exemple with a simple html request:

  .. code-block:: batch

    https://admin:MYPASSWORD@srvwapt/api/v3/get_ad_ou

/api/v3/get_ad_sites
++++++++++++++++++++

List Active Directory sites.

.. code-block:: python

  get_ad_sites =  wgets('https://%s:%s@%s/api/v3/get_ad_sites' % (wapt_user,wapt_password,wapt_url))
  parsed = json.loads(get_ad_sites)
  print(json.dumps(parsed, indent=1, sort_keys=True))

.. hint::

  This is the same exemple with a simple html request:

  .. code-block:: batch

    https://admin:MYPASSWORD@srvwapt/api/v3/get_ad_sites

/api/v3/hosts_for_package
+++++++++++++++++++++++++

List hosts with a specific package installed
https://srvwapt.ad.domain.fr/api/v3/hosts_for_package?package=demo-namepackage

.. code-block:: python

  hosts_for_package =  wgets('https://%s:%s@%s/api/v3/hosts_for_package?package=demo-namepackage' % (wapt_user,wapt_password,wapt_url))
  parsed = json.loads(hosts_for_package)
  print(json.dumps(parsed, indent=1, sort_keys=True))

.. hint::

  This is the same exemple with a simple html request:

  .. code-block:: batch

    https://admin:MYPASSWORD@srvwapt/api/v3/hosts_for_package?package=demo-namepackage

/api/v3/host_tasks_status
+++++++++++++++++++++++++

List tasks on a particular host.

Example with host uuid:
https://srvwapt.ad.domain.fr/api/v3/host_tasks_status?uuid=14F620FF-DE70-9E5B-996A-B597E8F9B4AD

.. code-block:: python

  host_tasks_status =  wgets('https://%s:%s@%s/api/v3/host_tasks_status?uuid=14F620FF-DE70-9E5B-996A-B597E8F9B4AD' % (wapt_user,wapt_password,wapt_url))
  parsed = json.loads(host_tasks_status)
  print(json.dumps(parsed, indent=1, sort_keys=True))

.. hint::

  This is the same exemple with a simple html request:

  .. code-block:: batch

    https://admin:MYPASSWORD@srvwapt/api/v3/host_tasks_status?uuid=14F620FF-DE70-9E5B-996A-B597E8F9B4AD

.. attention::

   **Next API are with POST method**.

/api/v3/upload_packages
+++++++++++++++++++++++

.. todo::

   Tests

/api/v3/upload_hosts
++++++++++++++++++++

.. todo::

   Tests

/api/v3/change_password
+++++++++++++++++++++++

Change admin password [only this account]. Request must be a python dictionnary *{}*.
Keys must be:

* user

* password

* new_password

.. code-block:: bash

  curl --insecure -X POST --data-raw '{"user":"admin","password":"OLDPASSWORD","new_password":"NEWPASSWORD"}' -H "Content-Type: application/json" "https://admin:OLDPASSWORD@srvwapt/api/v3/change_password"

/api/v3/login
+++++++++++++

Initialize a connection to the server.

.. code-block:: bash

  curl --insecure -X POST --data-raw '{"user":"admin","password":"MYPASSWORD"}' -H "Content-Type: application/json" "https://srvwapt/api/v3/login"

  {"msg": "Authentication OK", "result": {"edition": "enterprise", "hosts_count": 6, "version": "1.7.4", "server_domain": "ad.domain.fr", "server_uuid": "32464dd6-c261-11e8-87be-cee799b43a00"}, "success": true, "request_time": 0.03377699851989746}

.. hint::

   We can make a connection by html form than POST:
   https://admin:MYPASSWORD@srvwapt/api/v3/get_ad_sites

/api/v3/packages_delete
+++++++++++++++++++++++

Delete package with a precise version. Request must be in python list *[]*.
It can takes several packages separated by commas *,*.

Example:

.. code-block:: bash

  curl --insecure -X POST --data-raw '["demo-libreoffice-stable_5.4.6.2-3_all.wapt"]' -H "Content-Type: application/json" "https://admin:MYPASSWORD@srvwapt/api/v3/packages_delete"

/api/v3/reset_hosts_sid
+++++++++++++++++++++++

There is several possibilities:
https://srvwapt.ad.domain.fr/api/v3/reset_hosts_sid
will reinitialize all host connections.

For the POST method:

Syntax is: ``--data-raw``: a dictionnary list with ``uuids``as keys and the UUID of the hosts as values.

.. code-block:: bash

   curl --insecure -X POST --data-raw '{"uuids":["114F620FF-DE70-9E5B-996A-B597E8F9B4C"]}' -H "Content-Type: application/json" "https://admin:MUPASSWORD@srvwapt/api/v3/reset_hosts_sid"

   {"msg": "Hosts connection reset launched for 1 host(s)", "result": {}, "success": true, "request_time": null}[

.. hint::

  If you want several hosts:

  .. code-block:: bash

    curl --insecure -X POST --data-raw '{"uuids":["114F620FF-DE70-9E5B-996A-B597E8F9B4C","04F98281-7D37-B35D-8803-8577E0049D15"]}' -H "Content-Type: application/json" "https://admin:MYPASSWORD@srvwapt/api/v3/reset_hosts_sid"

    {"msg": "Hosts connection reset launched for 2 host(s)", "result": {}, "success": true, "request_time": null}

/api/v3/trigger_wakeonlan
+++++++++++++++++++++++++

If hosts are WakeOnLan enabled, this API is useful.

Syntax is :file:`--data-raw`: a dictionnary with key *uuids*
and a list of host uuids.

.. code-block:: bash

  curl --insecure -X POST --data-raw '{"uuids":["04F98281-7D37-B35D-8803-8577E0049D15"]}' -H "Content-Type: application/json" "https://admin:MYPASSWORD@srvwapt/api/v3/trigger_wakeonlan"

  {"msg": "Wakeonlan packets sent to 1 machines.", "result": [{"computer_fqdn": "win10-1809.ad.domain.fr", "mac_addresses": ["7e:c4:f4:9a:87:2d"], "uuid": "04F98281-7D37-B35D-8803-8577E0049D15"}], "success": true, "request_time": null}

.. hint::

  If you want several hosts:

  .. code-block:: bash

    curl --insecure -X POST --data-raw '{"uuids":["04F98281-7D37-B35D-8803-8577E0049D15","14F620FF-DE70-9E5B-996A-B597E8F9B4AD"]}' -H "Content-Type: application/json" "https://admin:MYPASSWORD@srvwapt/api/v3/trigger_wakeonlan"

    {"msg": "Wakeonlan packets sent to 2 machines.", "result": [{"computer_fqdn": "win10-1803.ad.domain.fr", "mac_addresses": ["02:4f:25:74:67:71"], "uuid": "14F620FF-DE70-9E5B-996A-B597E8F9B4AD"}, {"computer_fqdn": "win10-1809.ad.alejeune.fr", "mac_addresses": ["7e:c4:f4:9a:87:2d"], "uuid": "04F98281-7D37-B35D-8803-8577E0049D15"}], "success": true, "request_time": null}

/api/v3/hosts_delete
++++++++++++++++++++

.. code-block:: python

    """Remove one or several hosts from Server DB and optionnally the host packages

    Args:
        uuids (list): list of uuids to delete
        filter (csvlist of field:regular expression): filter based on attributes
        delete_packages (bool): delete host's packages
        delete_inventory (bool): delete host's inventory

    Returns:
        result (dict):
    """

If you want to delete a host from the inventory:

.. code-block:: bash

  curl --insecure -X POST --data-raw '{"uuids":["04F98281-7D37-B35D-8803-8577E0049D15"],"delete_inventory":"True","delete_packages":"True"}' -H "Content-Type: application/json" "https://admin:MYPASSWORD@srvwapt/api/v3/hosts_delete"

  {"msg": "1 files removed from host repository\n1 hosts removed from DB", "result": {"files": ["/var/www/wapt-host/04F98281-7D37-B35D-8803-8577E0049D15.wapt"], "records": [{"computer_fqdn": "win10-1809.ad.domain.fr", "uuid": "04F98281-7D37-B35D-8803-8577E0049D15"}]}, "success": true, "request_time": null}

If you do not want to delete in the inventory server:

.. code-block:: bash

   curl --insecure -X POST --data-raw '{"uuids":["04F98281-7D37-B35D-8803-8577E0049D15"],"delete_inventory":"False","delete_packages":"False"}' -H "Content-Type: application/json" "https://admin:MYPASSWORD@srvwapt/api/v3/hosts_delete"

   {"msg": "0 files removed from host repository\n1 hosts removed from DB", "result": {"files": [], "records": [{"computer_fqdn": "win10-1809.ad.domain.fr", "uuid": "04F98281-7D37-B35D-8803-8577E0049D15"}]}, "success": true, "request_time": null}

/api/v3/trigger_host_action
+++++++++++++++++++++++++++

.. todo::

	Tests

/upload_waptsetup
+++++++++++++++++

.. code-block:: python

   # Upload waptsetup

   #Handle the upload of customized waptagent.exe into wapt repository

   ### NE MARCHE PAS
   #curl --insecure -X POST -H  "Content-Type: multipart/form-data" -F 'data=@waptagent.exe' "https://admin:MYPASSWORD@srvwapt/upload_waptsetup"

/ping
+++++

Ping get general information from a WAPT server.

.. code-block:: python

  # https://srvwapt.ad.domain.fr/ping
  # Liste les infos du serveur

  ping_wapt =  wgets('https://%s:%s@%s/ping' % (wapt_user,wapt_password,wapt_url))
  parsed = json.loads(ping_wapt)
  print(json.dumps(parsed, indent=1, sort_keys=True))
