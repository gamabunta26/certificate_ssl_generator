# Certificate_ssl_generator
Mass generate SSL certificate with keytool and openssl utilities for https connector apache, tomcat, ...
Work / Test on Windows 10 PC

# Pre requisite :
* openssl-1.0.2d-fips-2.0.10
  * DL : https://freefr.dl.sourceforge.net/project/openssl/openssl-1.0.2d-fips-2.0.10/openssl-1.0.2d-fips-2.0.10.zip
  * unzip on the root directory
* java ( no specific version )( pre configured with C:\Program Files (x86)\Java\jre1.8.0_144 )
  *	JDK or JRE ( only needed for keytool command )


# Directory

Example of tree :

	W:\certificate_ssl_generator
	├───CA_cert
	├───openssl-1.0.2d-fips-2.0.10
	│   ├───bin
	│   ├───include
	│   │   └───openssl
	│   ├───lib
	│   │   ├───engines
	│   │   └───pkgconfig
	│   └───share
	│       └───man
	│           ├───man1
	│           ├───man3
	│           ├───man5
	│           └───man7
	└───output
		├───Dorier
		│   ├───PRE
		│   └───PRO


# Need 
Apache :
* CER and KEY files

Tomcat :
 * JKS and password
 * CER and KEY files

IIS :
* P12 file


# Instructions / Usage
    1/ Fill the CSV file with needed information
    2/ Execute 01-generation_certificat.bat
    3/ Sign CSR file by the autority
    4/ Put CER file on the same directory
    5/ Execute 02-import_certificat.bat
    6/ Enjoy !
