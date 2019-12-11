.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^


.. meta::
 :description: Using the WAPT server APIs
 :keywords: API, Application Protocol Interface, WAPT, documentation

.. _using_the_wapt_api:

Using the WAPT API
==================

.. note::

  This documentation stub does not describe all the available
  :abbr:`APIs (Application Protocol Interfaces)`, but the most useful ones.

The file that lists all the available URLs :file:`/opt/wapt/waptserver/server.py`.

URLs are formed by calling the proper command from the WAPT Server, ex:
https://srvwapt/{command_path}.


example with Python code or curl
================================


API V1
------


/api/v1/hosts
+++++++++++++


.. code-block:: python


   # """Get registration data of one or several hosts

   # Args:
   #     has_errors (0/1): filter out hosts with packages errors
   #     need_upgrade (0/1): filter out hosts with outdated packages
   #     groups (csvlist of packages) : hosts with packages
   #     columns (csvlist of columns) :
   #     uuid (csvlist of uuid): <uuid1[,uuid2,...]>): filter based on uuid
   #     filter (csvlist of field):regular expression: filter based on attributes
   #     not_filter (0,1):
   #     limit (int) : 1000
   #     trusted_certs_sha256 (csvlist): filter out machines based on their trusted package certs

   # Returns:
   #     result (dict): {'records':[],'files':[]}

   #     query:
   #       uuid=<uuid>
   #     or
   #       filter=<csvlist of fields>:regular expression
   # """


    # Liste tous les hôtes avec en paramètre : la disponibilité du poste : reachable, le nom du poste : computer_fqdn, les ip du poste : connected_ips et les adresses mac : mac_addresses.

    advanced_hosts_wapt = wgets('https://%s:%s@%s/api/v1/hosts?columns=reachable,computer_fqdn,connected_ips,mac_addresses&limit=10000' % (wapt_user,wapt_password,wapt_url))
    parsed = json.loads(advanced_hosts_wapt)
    print(json.dumps(parsed, indent=1, sort_keys=True))


.. code-block:: python

    hosts_wapt = wgets('https://%s:%s@%s/api/v1/hosts' % (wapt_user,wapt_password,wapt_url))
    parsed = json.loads(hosts_wapt)
    print(json.dumps(parsed, indent=1, sort_keys=True))



/api/v1/groups
++++++++++++++


 Liste tous les paquets qui ont une section group

 .. code-block:: python


    group_wapt = wgets('https://%s:%s@%s/api/v1/groups' % (wapt_user,wapt_password,wapt_url))
    parsed = json.loads(group_wapt)
    print(json.dumps(parsed, indent=1, sort_keys=True))



/api/v1/host_data
+++++++++++++++++

dmi
"""

 .. code-block:: python


    #    
    #    Get additional data for a host
    #    query:
    #      uuid=<uuid>
    #      field=packages, dmi or softwares

    #exemple : connaitre les paramètre dmi de la machine qui a pour uuid 14F620FF-DE70-9E5B-996A-B597E8F9B4CB :
    #https://srvwapt-alj.ad.alejeune.fr/api/v1/host_data?uuid=14F620FF-DE70-9E5B-996A-B597E8F9B4CB&field=dmi

    #dmi peut être remplacé par installed_packages, wsusupdates ou installed_softwares.
 
    dmi_host_data_wapt = wgets('https://%s:%s@%s/api/v1/host_data?uuid=14F620FF-DE70-9E5B-996A-B597E8F9B4CB&field=dmi' % (wapt_user,wapt_password,wapt_url))
    #print(dmi_host_data_wapt)
    parsed = json.loads(dmi_host_data_wapt)
    print(json.dumps(parsed, indent=1, sort_keys=True))


installed_packages
""""""""""""""""""

.. code-block:: python

    install_packages_data_wapt = wgets('https://%s:%s@%s/api/v1/host_data?uuid=14F620FF-DE70-9E5B-996A-B597E8F9B4CB&field=installed_packages' % (wapt_user,wapt_password,wapt_url))
    parsed = json.loads(install_packages_data_wapt)
    print(json.dumps(parsed, indent=1, sort_keys=True))


installed_softwares
"""""""""""""""""""

.. code-block:: python

    install_softwares_data_wapt = wgets('https://%s:%s@%s/api/v1/host_data?uuid=14F620FF-DE70-9E5B-996A-B597E8F9B4CB&field=installed_softwares' % (wapt_user,wapt_password,wapt_url))
    #print(install_softwares_data_wapt)
    parsed = json.loads(install_softwares_data_wapt)
    print(json.dumps(parsed, indent=1, sort_keys=True))


wsusupdates
"""""""""""
    
.. code-block:: python

    wsusupdates_data_wapt = wgets('https://%s:%s@%s/api/v1/host_data?uuid=14F620FF-DE70-9E5B-996A-B597E8F9B4CB&field=wsusupdates' % (wapt_user,wapt_password,wapt_url))
    #print(wsusupdates_data_wapt)
    parsed = json.loads(wsusupdates_data_wapt)
    print(json.dumps(parsed, indent=1, sort_keys=True))




/api/v1/usage_statistics    
++++++++++++++++++++++++

.. code-block:: python

    usage_statistics_wapt =  wgets('https://%s:%s@%s/api/v1/usage_statistics' % (wapt_user,wapt_password,wapt_url))
    #print(usage_statistics_wapt)
    parsed = json.loads(usage_statistics_wapt)
    print(json.dumps(parsed, indent=1, sort_keys=True))



API V2 
------


/api/v2/waptagent_version
+++++++++++++++++++++++++


Affiche la version du waptagent.exe sur le serveur

.. code-block:: python

    waptagent_version =  wgets('https://%s:%s@%s/api/v2/waptagent_version' % (wapt_user,wapt_password,wapt_url))
    parsed = json.loads(waptagent_version)
    print(json.dumps(parsed, indent=1, sort_keys=True))


API V3
------


/api/v3/packages
++++++++++++++++

Liste les paquets sur le dépôt, récupère les fichiers control des paquets.

.. code-block:: python


    packages_wapt =  wgets('https://%s:%s@%s/api/v3/packages' % (wapt_user,wapt_password,wapt_url))
    parsed = json.loads(packages_wapt)
    print(json.dumps(parsed, indent=1, sort_keys=True))



/api/v3/known_packages
++++++++++++++++++++++

Liste tous les noms de paquet avec la dernière date de signature

.. code-block:: python


    known_packages_wapt =  wgets('https://%s:%s@%s/api/v3/known_packages' % (wapt_user,wapt_password,wapt_url))
    parsed = json.loads(known_packages_wapt)
    print(json.dumps(parsed, indent=1, sort_keys=True))






/api/v3/trigger_cancel_task
+++++++++++++++++++++++++++

Voir avec Hubert 

.. code-block:: python


    trigger_cancel_task =  wgets('https://%s:%s@%s/api/v3/trigger_cancel_task' % (wapt_user,wapt_password,wapt_url))
    parsed = json.loads(trigger_cancel_task)
    print(json.dumps(parsed, indent=1, sort_keys=True))






/api/v3/get_ad_ou
+++++++++++++++++

Liste les OU récupérées

.. code-block:: python


    get_ad_ou =  wgets('https://%s:%s@%s/api/v3/get_ad_ou' % (wapt_user,wapt_password,wapt_url))
    parsed = json.loads(get_ad_ou)
    print(json.dumps(parsed, indent=1, sort_keys=True))




/api/v3/get_ad_sites
++++++++++++++++++++
  
Liste les sites Active Directory

.. code-block:: python


    get_ad_sites =  wgets('https://%s:%s@%s/api/v3/get_ad_ou' % (wapt_user,wapt_password,wapt_url))
    parsed = json.loads(get_ad_sites)
    print(json.dumps(parsed, indent=1, sort_keys=True))
 



/api/v3/hosts_for_package
+++++++++++++++++++++++++

Liste les machines/hotes qui ont le paquet en paramètre de l'api :
https://srvwapt-alj.ad.alejeune.fr/api/v3/hosts_for_package?package=alj-profmig-pro


.. code-block:: python


    hosts_for_package =  wgets('https://%s:%s@%s/api/v3/hosts_for_package?package=alj-profmig-pro' % (wapt_user,wapt_password,wapt_url))
    parsed = json.loads(hosts_for_package)
    print(json.dumps(parsed, indent=1, sort_keys=True))




/api/v3/host_tasks_status
+++++++++++++++++++++++++

exemple où l'uuid est celui du paquet machine:
https://srvwapt-alj.ad.alejeune.fr/api/v3/host_tasks_status?uuid=14F620FF-DE70-9E5B-996A-B597E8F9B4CB

Liste toutes les taches d'une machine

.. code-block:: python


    host_tasks_status =  wgets('https://%s:%s@%s/api/v3/host_tasks_status?uuid=14F620FF-DE70-9E5B-996A-B597E8F9B4CB' % (wapt_user,wapt_password,wapt_url))
    parsed = json.loads(host_tasks_status)
    print(json.dumps(parsed, indent=1, sort_keys=True))



#API avec Méthode POST

/api/v3/upload_packages
+++++++++++++++++++++++


.. todo::

   faire des tests



/api/v3/upload_hosts
++++++++++++++++++++

.. todo::

   faire des tests


/api/v3/change_password
+++++++++++++++++++++++

Change le mot de passe de compte admin [uniquement], la requête doit être en format dictionnaire python {} avec en clé : admin, password et new_password.
Exemple :

.. code-block:: python

    curl --insecure -X POST --data-raw '{"user":"admin","password":"calimero2020","new_password":"calimero2018"}' -H "Content-Type: application/json" "https://admin:calimero2020@srvwapt-alj/api/v3/change_password"



/api/v3/login
+++++++++++++

Initialise une connexion au serveur

.. code-block:: python    

   curl --insecure -X POST --data-raw '{"user":"admin","password":"calimero2018"}' -H "Content-Type: application/json" "https://srvwapt-alj/api/v3/login"

    {"msg": "Authentication OK", "result": {"edition": "enterprise", "hosts_count": 6, "version": "1.7.4", "server_domain": "ad.alejeune.fr", "server_uuid": "32464dd6-c261-11e8-87be-cee799b43a00"}, "success": true, "request_time": 0.03377699851989746}

Il est possible de se connecter aussi par form html plutot qu'un POST : 
https://admin:calimero2020@srvwapt-alj/api/v3/get_ad_sites



/api/v3/packages_delete
+++++++++++++++++++++++

Supprime un paquet dans une version preécise, la requête doit etre en format liste python [] et peut accepter plusieurs paquets. 
   
Exemple :

.. code-block:: python

   curl --insecure -X POST --data-raw '["alj-libreoffice-stable_5.4.6.2-3_all.wapt"]' -H "Content-Type: application/json" "https://admin:calimero2018@srvwapt-alj/api/v3/packages_delete

   
Si plusieurs paquets :

.. code-block:: python

   curl --insecure -X POST --data-raw '["alj-libreoffice-stable_5.4.6.2-3_all.wapt","alj-libreoffice-stable_5.4.6.2-2_all.wapt"]' -H "Content-Type: application/json" "https://admin:calimero2018@srvwapt-alj/api/v3/packages_delete



/api/v3/reset_hosts_sid
+++++++++++++++++++++++

Plusieurs choses possibles :
https://srvwapt-alj.ad.alejeune.fr/api/v3/reset_hosts_sid va réinitialiser la connexion de tous les postes

Pour la méthode POST :
Syntaxe attendue dans  --data-raw : un dictionnaire avec en clé "uuids" avec pour valeur, une liste d'uuid des hotes (paquets machines) 

.. code-block:: python

   curl --insecure -X POST --data-raw '{"uuids":["114F620FF-DE70-9E5B-996A-B597E8F9B4C"]}' -H "Content-Type: application/json" "https://admin:calimero2018@srvwapt-alj/api/v3/reset_hosts_sid"

{"msg": "Hosts connection reset launched for 1 host(s)", "result": {}, "success": true, "request_time": null}[

Si plusieurs postes :


.. code-block:: python

   curl --insecure -X POST --data-raw '{"uuids":["114F620FF-DE70-9E5B-996A-B597E8F9B4C","04F98281-7D37-B35D-8803-8577E0049D15"]}' -H "Content-Type: application/json" "https://admin:calimero2018@srvwapt-alj/api/v3/reset_hosts_sid"

{"msg": "Hosts connection reset launched for 2 host(s)", "result": {}, "success": true, "request_time": null}


/api/v3/trigger_wakeonlan
+++++++++++++++++++++++++

Si le(s) poste(s) est/sont configuré(s) pour, lance un wekonlan

Syntaxe attendue dans  --data-raw : un dictinnaire avec en clé "uuids" avec pour valeur, une liste d'uuid des hotes (paquets machines) 

.. code-block:: python

    curl --insecure -X POST --data-raw '{"uuids":["04F98281-7D37-B35D-8803-8577E0049D15"]}' -H "Content-Type: application/json" "https://admin:calimero2018@srvwapt-alj/api/v3/trigger_wakeonlan"

{"msg": "Wakeonlan packets sent to 1 machines.", "result": [{"computer_fqdn": "win10-1809.ad.alejeune.fr", "mac_addresses": ["7e:c4:f4:9a:87:2d"], "uuid": "04F98281-7D37-B35D-8803-8577E0049D15"}], "success": true, "request_time": null}

Exemple avec plusieurs postes :

.. code-block:: python

   curl --insecure -X POST --data-raw '{"uuids":["04F98281-7D37-B35D-8803-8577E0049D15","14F620FF-DE70-9E5B-996A-B597E8F9B4CB"]}' -H "Content-Type: application/json" "https://admin:calimero2018@srvwapt-alj/api/v3/trigger_wakeonlan"

{"msg": "Wakeonlan packets sent to 2 machines.", "result": [{"computer_fqdn": "win10-1803.ad.alejeune.fr", "mac_addresses": ["02:4f:25:74:67:71"], "uuid": "14F620FF-DE70-9E5B-996A-B597E8F9B4CB"}, {"computer_fqdn": "win10-1809.ad.alejeune.fr", "mac_addresses": ["7e:c4:f4:9a:87:2d"], "uuid": "04F98281-7D37-B35D-8803-8577E0049D15"}], "success": true, "request_time": null}




/api/v3/hosts_delete
++++++++++++++++++++


.. code-block:: python

    """Remove one or several hosts from Server DB and optionnally the host packages

    Args:
        uuids (list) : list of uuids to delete
        filter (csvlist of field:regular expression): filter based on attributes
        delete_packages (bool) : delete host's packages
        delete_inventory (bool) : delete host's inventory

    Returns:
        result (dict):

    """



## Totalement effacer :

.. code-block:: python

   curl --insecure -X POST --data-raw '{"uuids":["04F98281-7D37-B35D-8803-8577E0049D15"],"delete_inventory":"True","delete_packages":"True"}' -H "Content-Type: application/json" "https://admin:calimero2018@srvwapt-alj/api/v3/hosts_delete"



{"msg": "1 files removed from host repository\n1 hosts removed from DB", "result": {"files": ["/var/www/wapt-host/04F98281-7D37-B35D-8803-8577E0049D15.wapt"], "records": [{"computer_fqdn": "win10-1809.ad.alejeune.fr", "uuid": "04F98281-7D37-B35D-8803-8577E0049D15"}]}, "success": true, "request_time": null}


## Sans effacer de l'inventaire :

.. code-block:: python

   curl --insecure -X POST --data-raw '{"uuids":["04F98281-7D37-B35D-8803-8577E0049D15"],"delete_inventory":"False","delete_packages":"False"}' -H "Content-Type: application/json" "https://admin:calimero2018@srvwapt-alj/api/v3/hosts_delete"

{"msg": "0 files removed from host repository\n1 hosts removed from DB", "result": {"files": [], "records": [{"computer_fqdn": "win10-1809.ad.alejeune.fr", "uuid": "04F98281-7D37-B35D-8803-8577E0049D15"}]}, "success": true, "request_time": null}


/api/v3/trigger_host_action
+++++++++++++++++++++++++++

.. todo::

	Tests


/upload_waptsetup
+++++++++++++++++



.. code-block:: python

   # Upload le waptsetup

   #Handle the upload of customized waptagent.exe into wapt repository
   
   
   ### NE MARCHE PAS
   #curl --insecure -X POST -H  "Content-Type: multipart/form-data" -F 'data=@waptagent.exe' "https://admin:calimero2018@srvwapt-alj/upload_waptsetup"



/ping
+++++


.. code-block:: python


   # https://srvwapt-alj.ad.alejeune.fr/ping
   # Liste les infos du serveur
   
       ping_wapt =  wgets('https://%s:%s@%s/ping' % (wapt_user,wapt_password,wapt_url))
       parsed = json.loads(ping_wapt)
       print(json.dumps(parsed, indent=1, sort_keys=True))
    
