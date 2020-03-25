.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
  :description: Encrypting data in a WAPT package
  :keywords: WAPT, encrypt, cipher, sensitive data, password, documentation

Encrypting some sensitive data contained in a WAPT package
==========================================================

.. note::

  This part of the documentation is not recommended
  for users starting with WAPT.

What is the purpose for doing that?
-----------------------------------

With WAPT, the integrity of the package is ensured. A package whose content
has been modified without being re-signed will systematically be refused
by the WAPT client.

On the other hand, the content of a WAPT package is not encrypted
and will be readable by everyone. This technical model of transparency
brings nevertheless many benefits.

This can be annoying in the case of a package that contains a password,
a license key, or any sensitive or confidential data.

Fortunately, **we have a solution**!

Working principle of encrypting portions of the content of a WAPT package
-------------------------------------------------------------------------

When a WAPT agent registers with the WAPT server, it generates
a private key/ public certificate pair
in :file:`C:\\Program Files (x86)\\wapt\\private`.

* The certificate is sent to the server with the inventory when the WAPT client
  is first registered;

* The private key is kept by the agent and is only readable locally by
  :term:`Local Administrators`;

We will therefore encrypt the sensitive data contained inside the package
with the certificate belonging to the machine.

During installation, the WAPT agent will be able to decrypt the sensitive data
using its private key.

With this mode of operation, the WAPT server and secondary repositories
have no knowledge of the sensitive data.

Practical case
--------------

You will find here an example of a WAPT package where we encrypt a string
of text in an :command:`update_package` function and then decrypt this text
in the :command:`install` function.

In this example, the :command:`update_package` function allows us to browse
the WAPT server database to retrieve the certificate from each machine
and then encrypt the sensitive text with it.

The encrypted text for each machine is then stored in a :file:`encrypt-txt.json`
file at the root of the package.

During the installation of the package, the WAPT agent will take the encrypted
text and decrypt it with its private key.

.. code-block:: python

    # -*- coding: utf-8 -*-
    from setuphelpers import *
    import json
    from waptcrypto import SSLCertificate
    import waptguihelper

    uninstallkey = []

    def install():
        encryptlist = json.loads(open('encrypt-txt.json','r').read())
        if WAPT.host_uuid in encryptlist:
            host_key = WAPT.get_host_key()
            encrypttxt = host_key.decrypt(encryptlist[WAPT.host_uuid].decode('base64')).decode('utf-8')
            print( ur'Here is the deciphered text:  %s' % encrypttxt)
        else:
            error('%s not found in encrypt-txt.json' % WAPT.host_uuid)

    def update_package():
        urlserver = inifile_readstring(makepath(install_location('WAPT_is1'),'wapt-get.ini'),'global','wapt_server').replace('https://','')
        encrypttxt = str(raw_input('Enter the text to be encrypted :').encode('utf-8'))
        encryptlist = {}
        credentials_url = waptguihelper.login_password_dialog('Credentials for wapt server',urlserver,'admin','')
        data = json.loads(wgets('https://%s:%s@%s/api/v1/hosts?columns=host_certificate&limit=10000' % (credentials_url['user'],credentials_url['password'],urlserver)))
        for value in data['result']:
            if value['host_certificate']:
                host_cert=SSLCertificate(crt_string=value['host_certificate'])
                encryptlist[value['uuid']]=host_cert.encrypt(encrypttxt).encode('base64')
                print value['computer_fqdn'] + ':' + value['uuid'] + ':' + encryptlist[value['uuid']]
        open('encrypt-txt.json','w').write(json.dumps(encryptlist))

    if __name__ == '__main__':
        update_package()

.. attention::

  The python output (log install of the package) is readable by the users
  on the machine, so **you should not display the decrypted text
  with a :command:`print` during installation**.
