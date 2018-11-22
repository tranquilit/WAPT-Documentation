.. Reminder for header structure :
   Niveau 1 : ====================
   Niveau 2 : --------------------
   Niveau 3 : ++++++++++++++++++++
   Niveau 4 : """"""""""""""""""""
   Niveau 5 : ^^^^^^^^^^^^^^^^^^^^

.. meta::
    :description: Presentation of cryptographic processes
    :keywords: Cybersecurity, WAPT, documentation, signature, authentication

.. _wapt_crypto_principles:

Presentation of cryptographic processes
=======================================

+------------------------+----------------+
| Date                   | |today|        |
+------------------------+----------------+
| Written by             | Hubert TOUVET  |
+------------------------+----------------+
| Applicable for WAPT    | >= 1.5.0.17    |
+------------------------+----------------+
| Version of the Document| 1.5.0.17-0     |
+------------------------+----------------+

.. contents:: :local:

Cryptographic processes are used in the following activities:

* signature and verification of the **files contained in a package**;

* signature and verification of the **attributes of a package**;

* signature and verification of **instantaneous actions** on the WAPT Clients;

* signature of inventories and **status of WAPT clients**;

* authentication of the WAPT client Websocket connections on the server;

* HTTPS communication between the WAPT clients and the WAPT Server;

* HTTPS communication between the WAPT console and the WAPT Server;

* HTTPS communication between the WAPT clients and the WAPT repositories;

Folders and files referenced in this document
---------------------------------------------

* :file:`<WAPT>`: WAPT installation folder.
  By default :file:`%Program Files (x86)%\WAPT`;

* :file:`<WAPT>\wapt-get.ini`: WAPT client configuration file
  (:program:`wapt-get` and :program:`waptservice`);

* :file:`<WAPT>\ssl`: default directory for signed actions
  and trusted certificates;

* :file:`<WAPT>\ssl\server`: default directory for storing
  HTTPS server certificates (pinning);

* :file:`<WAPT>\private`: default certificate directory
  for signing the inventory and the Websocket connections;

* :file:`%LOCALAPPDATA%\waptconsole\waptconsole.ini`: configuration file
  for the console and package development actions for the :program:`wapt-get`
  tool;

* :file:`%appdata%\waptconsole\ssl`: default trusted certificate directory
  for importing packages from an external repository (i.e. *package templates*);

Actors
------

* **Organization**

  it is the realm of responsibility within which WAPT is used;

* **Certificate Authority**

  it is the entity that keeps the keys that have been used to sign certificates
  for the :term:`Package Developers` and the HTTPS servers;

* **Administrators**

  they have a personal RSA key and a certificate that has been signed
  by the :term:`Certificate Authority` of the :term:`Organization`;
  they also have a login and a password for accessing the WAPT console;

* **WAPT clients**

  realm of Windows PCs that the :term:`Organization` has allowed
  the :term:`Administrators` to manage with WAPT. The Windows clients are joined
  to the :term:`Organization`'s Active Directory domain;

* **Internal WAPT repositories**

  it is one or several Linux/ Nginx servers that deliver signed WAPT packages
  to WAPT clients using the HTTPS protocol;

* **WAPT Server**

  it is the Linux / Nginx/ PostgreSQL /WAPT server that the :term:`Organization`
  uses to keep the inventory of WAPT equipped devices.

  By default, the WAPT Server also plays the role
  of an internal WAPT Repository. The WAPT Server has a machine account
  in the :term:`Organization`'s Active Directory.

* **external WAPT repositories**

  it is a public WAPT repository that the :term:`Package Developers` may use
  to import packages designed by other :term:`Organizations`,
  under the condition that they check the adequacy of the WAPT package
  in regards the internal policies on security and safety;

* **Active Directory Server**

  server that manages the :term:`Organization`'s domain;

Summary of crypto modules present in WAPT
-----------------------------------------

On the client side of WAPT (WAPT 1.5.0.12):

* **Python 2.7.13** standard *ssl* module linked on
  :program:`OpenSSL 1.0.2j 26 Sep 2016`: used for the HTTPS connections between
  the WAPT clients and the WAPT server;

* **cryptography==1.9** linked on :program:`openssl 1.1.0f`: used for all
  RSA crypto operations such as key generations, X509 certificate generations
  and signature verifications;

* **kerberos-sspi==0.2** and **requests-kerberos==0.11.0**: used for
  authenticating the WAPT client on its first registering on the WAPT Server;

* **pyOpenSSL==17.0.0**: used to recover the WAPT Server certificate chain;

* **certifi==2017.4.17**: used as base for the Root Authorities certificates;

* **Openssl 1.0.2l** dll: used in waptcommon.pas written with
  the FPC Indy library and the TIdSSLIOHandlerSocketOpenSSL class;

On the server side of WAPT:

* **nginx/1.10.2**: configured for TLS1.2,
  cipher 'EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH';

* **python 2.7.5** standard *ssl* module linked on
  :program:`OpenSSL 1.0.1e-fips 11 Feb 2013`;

* **cryptography==1.9** linked on :program:`OpenSSL 1.0.1e-fips 11 Feb 2013`:
  used for all RSA crypto operations such as key generations, X509 certificate
  generations and signature verifications;

Key and certificate management for the Administrator
----------------------------------------------------

Context
+++++++

Packages and actions done by an :term:`Administrator` are signed
so that only Trusted Administrators are authorized to manage the devices.

The WAPT :term:`Administrator` holds:

* a private 2048 bit *RSA* key that has been encrypted
  by the aes-256-cbc algorithm;

* a *X509* certificate signed by an :term:`Certificate Authority` trusted by
  the :term:`Organization`;

.. note::

  The process for creating the keys and signing, distributing and revocating
  the certificates are of the responsibility of the :term:`Organization`
  using WAPT; that process is beyond the functional perimeter of WAPT.

  However, to make the testing of WAPT easy, WAPT offers a function to generate
  a RSA key and its corresponding X509 certificate:

  * the generated RSA key is 2048bit long, encrypted with aes-256-cbc,
    encoded in PEM format and saved with a *.pem* extension;

  * the certificate is either self-signed, or signed by a Trusted Authority
    from whom we have received a key and a PEM formated certificate;

  * if the certificate is self-signed, then its *KeyUsage* attribute contains
    the *keyCertSign* flag;

  * if the :term:`Administrator` is authorized by the :term:`Organization`
    to sign packages that contain python code (the presence of a
    :file:`setup.py` file is detected in the package), the *extendedKeyUsage*
    attribute of the certificate contains the **CodeSigning** flag;

  * the *X509* certificate is encoded and handed over to the
    :term:`Administrator` in PEM format with a *.crt* extension;

Validity of the Administrator's certificate
+++++++++++++++++++++++++++++++++++++++++++

For WAPT version up to 1.5.0.12, WAPT agent does not verify the revocation
state of the :term:`Administrator`'s certificate during the process
of verifying the package, the attributes or the actions
of the :term:`Administrator`.

It only checks the dates of validity (*notValidBefore*/ *notValidAfter*
attributes). The certificate is valid if (**Now** >= *notValidBefore* and
**Now** <= *notValidAfter*).

Authorizing the Administrator's certificate to sign a package
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

The certificate used by the WAPT console to sign packages and actions
is defined with the *personal_certificate_path* parameter in the section
``[global]`` of the file :file:`%LOCALAPPDATA%\waptconsole\waptconsole.ini`.

WAPT asks the :term:`Administrator` for his password and then searches
a private key (encoded in PEM format) that matches a certificate
amongst the :file:`.pem` files in the directory containing the certificates.

When signing a package, WAPT will refuse the certificate if the package
contains a :file:`setup.py` file and the certificate is not a *CodeSigning*
type.

Managing the **WAPT agent's** key and certificate
-------------------------------------------------

Context
+++++++

The WAPT client (:program:`waptservice`) uses RSA keys and X509 certificates
to interact with the WAPT Server.

The WAPT client certificate is used in the following situations:

* when updating the WAPT client status on the server
  (:command:`update_server_status`) **signing informations**;

* when the WAPT agent establishes a Websocket with the server
  (:program:`waptservice`) **signing the WAPT client UUID**;

First emission and later update of the WAPT agent's certificate
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

* on finishing the installation process of the WAPT agent on the device,
  the WAPT agent automatically registers itself on the WAPT Server by sending
  a Kerberos authenticated HTTPS request that uses the TGT of the machine
  account.

  The WAPT agent uses Windows kerberos APIs implemented
  with :program:`kerberos-sspi` and :program:`requests-kerberos` python modules.

.. note::

  this process works if and only if the device is joined to the Windows domain
  for which the WAPT Server is configured.

* if the key and the certificates have not yet been generated, or if they
  do not match the current :term:`FQDN` of the device, the WAPT agent generates
  a self-signed RSA key and X509 certificate with the following parameters:

  * the key is 2048 bit RSA encoded in PEM format and stored in the file
    :file:`<WAPT>\private\<device FQDN>.pem`;

  * the generated certificate has the following attributes:

    * *Subject.COMMON_NAME* = <device FQDN>;

    * *Subject.ORGANIZATIONAL_UNIT_NAME* = name of the :term:`Organization`
      registered in the WAPT client's Windows registry;

    * *SubjectAlternativeName.DNSName* = <device FQDN>;

    * *BasicConstraint.CA* = True;

    * *validity* = 10 years;

    * *serialnumber* = random;

  * the certificate is saved in the :file:`<WAPT>\private\<device FQDN>.crt`;

.. note::

  Only machine accounts and :term:`Local Administrators` have access to
  the :file:`<WAPT>\private` directory because specific ACLs have been applied
  upon first installation of the WAPT agent on the device.

* the inventory and the WAPT agent status updates are sent to the WAPT Server
  over POST HTTPS requests;

* the POST HTTPS requests are authenticated by adding two specific headers:

  * *X-Signature*:

    * JSON encoded :abbr:`BLOB (Binary Large Object)`
      of inventory or status informations;

    * signature of the JSON file with the private key of the WAPT Client:
      *sha256* hashing and *PKCS#1 v1.5* padding;

    * *base64* encoding of the signature;

  * *X-Signer*: *Subject.COMMON_NAME* or UUID of the WAPT Client.

* after having initially authenticated the WAPT client with Kerberos,
  the WAPT Server receives the certificate sent by the Client and stores it
  in the table *hosts* of its inventory in PEM format
  (column *host_certificate*).

.. note::

  If the device is renamed, the key/ certificate pair is regenerated.

  When the WAPT agent will update its status with the WAPT Server,
  the POST request will be refused because the remote device is registered
  in the database with another certificate.

  The device will then retry to :command:`register` with the WAPT Server
  using Kerberos; then the new certificate will be saved in the database.

Deploying certificates of Authorities of Certification to verify packages and validate actions on Clients
---------------------------------------------------------------------------------------------------------

PEM formated certificates are stored in files with *.crt* or *.pem*
extensions in the directory defined with the *public_certs_dir* parameter
in the file :file:`<WAPT>\wapt-get.ini`. They are reputed to be
**trusted certificates**.

The *public_certs_dir* parameter is initialized by default
to be :file:`<WAPT>\ssl`.

Authority certificates are deployed when the WAPT agents are first deployed.

From the console, the :term:`Administrator` compiles a personalized installer
to be deployed by :term:`GPO` or other means on target devices.

The WAPT console includes in its personalized installer the certificates
present in the :file:`<WAPT>\ssl` directory of the PC on which the installer
is being compiled.

The :term:`Administrator` must insure to save in :file:`<WAPT>\ssl`
only the certificates of Authorities that are strictly necessary
before launching the compilation of the installer.

New or updated certificates of :term:`Certificate Authority`
for the verification of packages and the validation of actions
may also be deployed a posteriori with an Active Directory GPO
or a WAPT package.

Deploying certificates of Authorities of Certification for the HTTPS communication between the WAPT clients and the WAPT Server
-------------------------------------------------------------------------------------------------------------------------------

The WAPT service (:program:`waptservice`) and the command line tool
:program:`wapt-get` exchange with the WAPT Server to send its inventory
(:command:`register`) and the package deployment status
(:command:`update-status`).

These two types of connections verify the HTTPS certificate of the WAPT Server.

*verify_cert* parameter in section ``[global]`` in :file:`<WAPT>\wapt-get.ini`:

* *verify_cert* = 1

  this method will only work well if the HTTPS server is configured
  to send its certificate and the intermediary certificates
  upon initialization of the TLS connexion.

* *verify_cert* = <path to .pem>

  check the HTTPS certificate using the indicated bundle of certificates.
  All the certificates of the intermediary Certificate Authorities
  must be bundled in a *.pem* formated file;

* *verify_cert* = 0

  do not verify the HTTPS certificate of the server;

Conventionally, the approved bundle of certificates from the
:term:`Certificate Authority` is stored in the :file:`<WAPT>\ssl\server`
directory.

The WAPT console includes a function to facilitate the initial recovery
of the server certificate chain. The function stores it in *.pem* format
in :file:`<WAPT>\ssl\server\<server FQDN>`.

The :term:`Administrator` is responsible for insuring that the recovered
certificate chain is **authentic**.

During the compilation of the WAPT agent installer, the certificates
or the bundle of certificates is incorporated into the installer.

When the installer is deployed on the WAPT clients, the bundle is copied
in :file:`<WAPT>\ssl\server` and the *verify_cert* parameter
in section``[global]`` in :file:`<WAPT>\wapt-get.ini` is filled out
to indicate the path to the bundle.

HTTPS communication between the WAPT clients and the WAPT repositories
----------------------------------------------------------------------

Deploying certificates of Authorities of Certification
++++++++++++++++++++++++++++++++++++++++++++++++++++++

The HTTPS exchanges between the WAPT agent and the main repository
and between the WAPT agent and the WAPT Server use the same methods.

The WAPT agent uses the same bundle of certificates to communicate
in HTTPS with the main repository, with the WAPT Server, and with the secondary
repositories.

The WAPT client
+++++++++++++++

The HTTPS connection is implemented with :program:`requests`,
:program:`urllib3` et :program:`ssl` python modules.

The certificate emitted by the repository HTTPS server is verified
with the :program:`urllib3.contrib.pysopenssl.PyOpenSSLContext`
and :program:`urllib3.util.ssl_wrap_socket` python modules.

Websocket communications between the WAPT clients and the WAPT Server
---------------------------------------------------------------------

To allow immediate actions on the WAPT clients, the WAPT service deployed
on the clients establishes and maintains a permanent Websocket with
the WAPT server.

This connection is TLS encrypted and uses on the client side the same bundle
of certificates as the HTTPS connexion from the WAPT client to the WAPT Server.

Communications between the WAPT console and the WAPT Server
-----------------------------------------------------------

Deploying certificates of Authorities of Certification
++++++++++++++++++++++++++++++++++++++++++++++++++++++

*verify_cert* parameter in section ``[global]`` in file
:file:`%LOCALAPPDATA%\waptconsole\waptconsole.ini`:

* *verify_cert* = 1

  this method will only work well if the HTTPS server is configured
  to send its certificate and the intermediary certificates
  upon initialization of the TLS connexion.

* *verify_cert* = <path to .pem>

  check the HTTPS certificate using the indicated bundle of certificates.
  All the certificates of the intermediary Certificate Authorities
  must be bundled in a *.pem* formated file;

* *verify_cert* = 0

  do not verify the HTTPS certificate of the server;

Conventionally, the approved bundle of certificates from the
:term:`Certificate Authority` is stored in the :file:`<WAPT>\ssl\server`
directory.

The WAPT console includes a function that facilitates the initial recovery
of the server certificate chain and that stores it in *.pem* format
in the :file:`<WAPT>\ssl\server\<server FQDN>`.

The :term:`Administrator` is responsible for insuring that the recovered
certificate chain is **authentic**.

It is also possible to recover the server certificate chain and fill
out the *verify_cert* parameter with the command line
:code:`wapt-get enable-check-certificate`.

Deploying the certificates of Authorities of Certification to verify packages imported in the main repository
-------------------------------------------------------------------------------------------------------------

Context
+++++++

In the WAPT console, tab :guilabel:`Private Repository`, a button
:guilabel:`Import from Internet` allows to download a package from an external
repository whose address is provided with the *repo-url* parameter in
the section ``[wapt_templates]`` of
:file:`%LOCALAPPDATA%\waptconsole\waptconsole.ini`.

A checkbox :guilabel:`Verify Package Signature` insures that the imported
package has been signed with a trusted certificate.

Certificates from Trusted Authorities
+++++++++++++++++++++++++++++++++++++

The certificates from Trusted Authorities present in the directory specified
with the *public_certs_dir* parameter in section ``[wapt_templates]``
in file :file:`%LOCALAPPDATA%\waptconsole\waptconsole.ini` are considered
to be trusted.

If the parameter is not explicitly mentioned, it is initialized
at :file:`%appdata%\waptconsole\ssl`.

This directory is not automatically populated by WAPT. It is the responsibility
of the :term:`Administrator` to copy/ paste into it the :file:`PEM` files
of other trusted :term:`Administrators` or the certificates from trusted
Certificate Authorities.

The Certificates from Trusted Authorities are encoded in *.pem* format
and stored in files with *.pem* or *.crt* extensions. It is possible
to store several certificates in each :file:`.crt` or :file:`.pem` file.

It is not necessary to have the complete chain of certificates, WAPT will accept
the signature of a package as long as:

* the certificate of the package is also included in the *public_certs_dir*
  directory. The matching is done using the fingerprint of the certificate;

* the certificate of the Authority that has signed the certificate
  of the package is included in the *public_certs_dir* directory.
  The matching is done using the *issuer_subject_hash* attribute
  of the certificate. The signature of the certificate is done using
  the :program:`x509.verification.CertificateVerificationContext` class;

Process for signing a package
-----------------------------

The process for signing a package is launched with the following actions:

* action :code:`wapt-get.exe build-upload <directory>`;

* action :code:`wapt-get.exe sign-package <path-to-package-file.wapt>`;

* shell command :code:`wapt-signpackage.py <WAPT-package-list>`;

* saving a *host* package in the WAPT console;

* saving a *group* package in the WAPT console;

* importing a package from an external repository;

* creating a package with the MSI setup wizard;

Initial parameters
++++++++++++++++++

* ZIP file of the package;

* *.pem* formated RSA private key of the certificate holder
  (encrypted with OpenSSL's *aes-256-cbc* algorithm if the key has been created
  in the WAPT console);

* *X509* certificate of the certificate holder matching the private key;

* if the package to be signed contains a :file:`setup.py` file,
  then the *X509* certificate must have the *advanced Key Usage* extension
  *codeSigning (1.3.6.1.5.5.7.3.3)*;

Signature of the attributes in the control file
"""""""""""""""""""""""""""""""""""""""""""""""

The :file:`control` file defines the metadata of a package and in particular
its name, its version, its dependencies and its conflicts. It is
the identity card of the WAPT package.

These metadata are primarily used by the WAPT agent to determine
whether a package must be upgraded, and what packages must be first installed
or removed.

The package attributes are therefore signed to insure the integrity
and the authenticity of the WAPT package.

Process steps:

* the attributes *signed_attributes*, *signer*, *signature_date*,
  *signer_fingerprint* are added to the structure of the :file:`control` file:

  * *signed_attributes*: comma separated list of the names of the attributes;

  * *signer*: CommonName of the certificate holder;

  * *signature_date*: current date and time (UTC) in '%Y-%m-%dT%H:%M:%S format;

  * *signer_fingerprint*: hexadecimal encoded ``sha256`` fingerprint
    of the fingerprint obtained with the :program:`fingerprint`
    function included in the :program:`cryptography.x509.Certificate` class;

* the attributes of the control structure are JSON encoded;

* the resulting JSON :abbr:`BLOB (Binary Large Object)` is signed with *sha256*
  hashing and *PKCS#1 v1.5* padding;

* the signature is base64 encoded and stored as a *signature* attribute
  in the :file:`control` file;

Signing the files of the package
""""""""""""""""""""""""""""""""

* the :file:`control` file attributes are signed and serialized in JSON format.
  The result is stored in the :file:`<WAPT>\control` file of the WAPT package;

* the PEM serialized X509 certificate of the certificate holder is stored
  in the :file:`<WAPT>\certificate.crt` file of the WAPT package;

* the *sha256* fingerprints of the all files contained in the WAPT package
  are hexadecimal encoded and stored as a JSON list [(filename,hash),]
  in the :file:`<WAPT>\manifest.sha256` file in the WAPT package;

* the content of the file :file:`<WAPT>\manifest.sha256` is signed
  with the private key of the :term:`Administrator` (2048 bit RAS key),
  *sha256* hashed and *PKCS#1 v1.5* padded:

    * the signature process relies on the signing function
      of the :program:`cryptography.rsa.RSAPrivateKey.signer` class;

    * :program:`cryptography.rsa.RSAPrivateKey.signer` relies on the OpenSSL
      functions of :program:`EVP_DigestSignInit`;

* the signature is base64 serialized and stored in the file
  :file:`<WAPT>\signature.sha256` of the WAPT package;

Verifying the signature of a package attributes
-----------------------------------------------

The verification takes place:

* when the index file of available packages on the WAPT client is updated
  from the :file:`Packages` index file on the repository;

* when a package signature is verified (installation, download) when not
  in *development* mode, i.e. if the installation takes place from a ZIP file
  and not from a development directory;

The verification consists of:

* reading the control attributes from the WAPT package's :file:`control` file;

* recovering the X509 certificate from the certificate holder
  from the WAPT package's :file:`certificate.crt` file;

* decoding the base64 formated signature attribute;

* constructing a JSON structure with the attributes
  to be signed (such as defined in the :program:`PackageEntry` class);

* verifying if the public key of the holder's certificate can verify
  the hash of the JSON structured list of attributes and the signature
  of the :file:`control` file, using *sha256* hashing and *PKCS#1 v1.5* padding;

* verifying whether the certificate is trusted (either it is present
  in the list of trusted certificates, or signed
  by a Trusted :term:`Certificate Authority`);

In case we must verify the attributes without having the WAPT package on hand,
we recover the list of certificates of potential certificate holders
from the :file:`Packages` index file on the WAPT repository.
The certificates are named :file:`ssl/<hexadecimal formated certificate
fingerprint>.crt`.

An attribute in the WAPT package's :file:`control` file specifies
the fingerprint of the :file:`control` file's certificate holder.

Verifying the signature of a WAPT package
-----------------------------------------

The verification takes place:

* when installing a package on a WAPT Client;

* when editing an existing package;

* when importing a package from an external repository
  (if the checkbox is checked in the WAPT console);

The verification consists of:

* recovering the X509 certificate from the certificate holder from the WAPT
  package's :file:`certificate.crt` file;

* verifying that the certificate has been signed by a Trusted Authority
  whose certificate is present in the file :file:`ssl` on the WAPT client;

* verifying the signature of the file :file:`manifest.sha256`
  with the public key;

Signing immediate actions
-------------------------

Context
+++++++

From the WAPT console, the :term:`Administrators` may launch actions
directly on the WAPT clients connected with the WAPT Server using Websockets.

The WAPT console signs these actions with the key and certificate
of the :term:`Administrator` before sending them to the WAPT Server
using an HTTPS POST request; the request is then forwarded
to the targeted WAPT clients.

Possible immediate actions are:

* :command:`trigger_host_update`;

* :command:`trigger_host_upgrade`;

* :command:`trigger_install_packages`;

* :command:`trigger_remove_packages`;

* :command:`trigger_forget_packages`;

* :command:`trigger_cancel_all_tasks`;

* :command:`trigger_host_register`;

Signing process for immediate actions
+++++++++++++++++++++++++++++++++++++

* the action is defined by its name and the actions attributes. The attributes
  are *uuid*, *action*, *force*, *notify_server*, and *packages*
  (for actions implicating a list of packages)

* the attributes *signed_attributes*, *signer*, *signature_date*,
  *signer_certificate* are added to the structure of the action:

    * *signed_attributes* list of the attributes that are signed;

    * *signer* Subject.COMMON_NAME of certificate holder;

    * *signature_date* : current date and time (UTC)
      in '%Y-%m-%dT%H:%M:%S' format;

    * *signer_certificate* certificate holder's base64 encoded
      *X509* certificate;

* the structure is JSON encoded;

* the signature of the JSON file is calculated from the RSA private key
  of the *signer* using a *sha256* hash algorithm and a *PKCS1 v1.5* padding;

* the signature is base64 encoded and stored on the *signature*
  attribute inside the JSON file;

Verifying the signature of an immediate action
----------------------------------------------

Context
+++++++

From the WAPT console, the :term:`Administrators` may launch actions directly
on the WAPT clients connected with the WAPT Server using Websockets.

The actions are JSON encoded, signed with the key and certificate of
the :term:`Administrator`, and relayed to the targeted WAPT clients
by the WAPT Server.

Possible immediate actions are:

* :command:`trigger_host_update`;

* :command:`trigger_host_upgrade`;

* :command:`trigger_install_packages`;

* :command:`trigger_remove_packages`;

* :command:`trigger_forget_packages`;

* :command:`trigger_cancel_all_tasks`;

* :command:`trigger_host_register`;

The action :command:`get_tasks_status` does not require SSL authentication.

Verification process
++++++++++++++++++++

Upon receiving an event on the Websocket connexion of the WAPT client:

* the X509 certificate of the certificate holder is extracted
  from the JSON file (format PEM);

* the WAPT client tests whether the certificate is to be trusted, i.e. that
  it is present in :file:`<WAPT>\ssl` or that it has been signed by a
  Trusted Authority (certificate of the Authority present
  in :file:`<WAPT>\ssl`);

* the WAPT client checks whether the certificate can verify the signature
  that is present in the JSON structure of the action, which consists of:

  * extracting the base64 encoded signature from the *signature* attribute
    in the JSON file;

  * extracting the signature date formated in '%Y-%m-%dT%H:%M:%S' from the
    *signature_date* attribute;

  * checking that the signature date is neither too old in the past, nor
    too late into the future by over 10 minutes;

  * reconstructing a JSON representation of the attributes of the action;

  * checking that the certificate's public key can verify the JSON file
    with the signature by using a *sha256* hash algorithm
    and a *PKCS1 v1.5* padding;

Checking the complete download of a package
-------------------------------------------

For each package, a *md5* sum of the package is calculated and stored
in the :file:`Packages` index file of the repository.

When installing a package, the WAPT client checks whether a local version
of the package is already available in the cache directory :file:`<WAPT>\cache`.

If the package file is cached, its *md5* sum is calculated and compared
with the *md5* sum in the index file. If they are different,
the cached package is deleted.

This *md5* sum is only used to insure that a package has been fully downloaded.

The checking of the signature of the package will fully insure its integrity
and its authenticity.
