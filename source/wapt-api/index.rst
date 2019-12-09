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

..note::

  This documentation stub does not describe all the available
  :abbr:`APIs (Application Protocol Interfaces)`, but the most useful ones.

The file that lists all the available URLs :file:`/opt/wapt/waptserver/server.py`.

URLs are formed by calling the proper command from the WAPT Server, ex:
https://srvwapt/{command_path}.

upload_host
+++++++++++

Handle the upload of multiple host packages

Methods: HEAD or POST

Args:

Returns:
	Response: json message with keys:
				'success' (bool)
				'error_code' if success is False
				'msg' (str)
				'result' (data)
				'request_time' (float)

.. note::

   Requires basic authentication on the URL (username / password)

api/v3/packages
+++++++++++++++

:TODO:

/api/v3/upload_packages
+++++++++++++++++++++++

:TODO:

/api/v3/packages_delete
+++++++++++++++++++++++

:TODO:

/ping
+++++

:TODO:

/api/v3/trigger_wakeonlan
+++++++++++++++++++++++++

:TODO:

/api/v2/waptagent_version
+++++++++++++++++++++++++

:TODO:

/api/v3/trigger_cancel_task
+++++++++++++++++++++++++++

:TODO:

/api/v1/groups
++++++++++++++

:TODO:

/api/v3/get_ad_ou
+++++++++++++++++

:TODO:

/api/v3/hosts_delete
++++++++++++++++++++

:TODO:

/api/v1/hosts
+++++++++++++

:TODO:

/api/v1/host_data
+++++++++++++++++

:TODO:

/api/v3/hosts_for_package
+++++++++++++++++++++++++

:TODO:

/api/v1/usage_statistics
++++++++++++++++++++++++

:TODO:

/api/v3/host_tasks_status
+++++++++++++++++++++++++

:TODO:

/api/v3/trigger_host_action
+++++++++++++++++++++++++++

:TODO:

Using the WAPT agent API with WAPT packages
-------------------------------------------

install
+++++++

http://127.0.0.1:8088

Methods: GET

Args: list of WAPT packages

.. note::

   Requires basic authentication on the URL (username / password)

remove
++++++

package_download
++++++++++++++++

inventory
+++++++++

register
++++++++
