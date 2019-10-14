.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^


Use WAPT API
=================

This documentation does not refer to all the available URLs of APIs but the most useful ones.



Use the wapt server API
----------------------------------

The file that lists all the available URLs is here: :file:`/opt/wapt/waptserver/server.py`

We then described some specific urls that may be useful to you.

upload_host
++++++++++++++++++++

https://srvwapt/upload_host

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
++++++++++++++++++++

TODO ... Liste le package

/api/v3/upload_packages
++++++++++++++++++++++++++++++++++++++++

/api/v3/packages_delete
++++++++++++++++++++++++++++++++++++++++

/ping
++++++++++++++++++++++++++++++++++++++++

/api/v3/trigger_wakeonlan
+++++++++++++++++++++++++++++++++++

/api/v2/waptagent_version
+++++++++++++++++++++++++++++++++++

/api/v3/trigger_cancel_task
+++++++++++++++++++++++++++++++++++

/api/v1/groups
+++++++++++++++++++++++++++++++++++

/api/v3/get_ad_ou
+++++++++++++++++++++++++

/api/v3/hosts_delete
++++++++++++++++++++++++++++++++++++++++++++++++++

/api/v1/hosts
++++++++++++++++++++++++++++++++++++++++++++++++++

/api/v1/host_data
++++++++++++++++++++++++++++++++++

/api/v3/hosts_for_package
++++++++++++++++++++++++++++++++++++

/api/v1/usage_statistics
++++++++++++++++++++++++++++++++++++

/api/v3/host_tasks_status
+++++++++++++++++++++++++++++++

/api/v3/trigger_host_action
+++++++++++++++++++++++++++++++


Use the wapt agent API
----------------------------------


install
++++++++++++++++++++

http://127.0.0.1:8088

Methods: GET

Args: list wapt package 

.. note::

   Requires basic authentication on the URL (username / password)
   
   
remove   
++++++++++++++

package_download
++++++++++++++++++++++

inventory
++++++++++++++

register
+++++++++++++++
