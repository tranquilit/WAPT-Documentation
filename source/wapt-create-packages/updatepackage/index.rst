.. Reminder for header structure:
   Niveau 1: ====================
   Niveau 2: --------------------
   Niveau 3: ++++++++++++++++++++
   Niveau 4: """"""""""""""""""""
   Niveau 5: ^^^^^^^^^^^^^^^^^^^^

.. meta::
    :description: Updating automatically a software package
    :keywords: WAPT, documentation, automatic update

Updating automatically a software package
=========================================

.. note::

  This part of the documentation is for advanced users of WAPT.

Why is it useful to do that?
----------------------------

*update_package* functions are very practical, they allow to gain
a lot of time when it is time to update a WAPT package with the most recent
version of a piece of software.

Working principle
-----------------

The *update_package* function will:

* fetch online the latest version of the software;

* download the latest version of the software binaries;

* remove old versions of the software binaries;

* update the version number of the software in the :file:`control` file;

If you base your *install* function on the version number inside
the :file:`control` file, then you do not even need to modify
your :file:`setup.py`.

You just have to do your usual Quality Assurance tests
before you :command:`build-upload` your new package.

Example
-------

Here is the *update_package* script for :program:`firefox-esr`
as an example:

.. code-block:: python

  def update_package():
        """ You can do a CTRL F9 in pyscripter to update the package """
        import re,requests,urlparse,glob

        url = requests.head('https://download.mozilla.org/?product=firefox-esr-latest&os=win&lang=fr',proxies={}).headers['Location']
        filename = urlparse.unquote(url.rsplit('/',1)[1])

        if not isfile(filename):
            print('Downloading %s from %s'%(filename,url))
            wget(url,filename)

        exes = glob.glob('*.exe')
        for fn in exes:
            if fn != filename:
                remove_file(fn)

        # updates control version from filename, increment package version.
        control = PackageEntry().load_control_from_wapt ('.')
        control.version = '%s-0'%(re.findall('Firefox Setup (.*)esr\.exe',filename)[0])
        control.save_control_to_wapt('.')

    if __name__ == '__main__':
        update_package()

You may launch the *update_package* script by pressing :kbd:`F9`
in :program:`PyScripter`.

You will find many inspiring examples of *update_package* scripts in packages
hosted in the `Tranquil IT store <https://store.wapt.fr/>`_.
