# certificate_ssl_generator
generate SSL certificate with keytool and openssl utilities for https connector apache, tomcat, ...



#pre requisite :
*openssl-1.0.2d-fips-2.0.10
*java ( no version )

OpenSSL :
	DL : https://freefr.dl.sourceforge.net/project/openssl/openssl-1.0.2d-fips-2.0.10/openssl-1.0.2d-fips-2.0.10.zip
	unzip at the root directory
Java :
	JDK or JRE


Example of arborescence :

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
    ├───Cedre
    │   ├───PRE
    │   └───PRO
    └───PFE
        ├───PRE
        └───PRO

# Need 
Pour Apache :

# Usage
run 01
