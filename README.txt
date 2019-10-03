
pre requis
==========
-openssl-1.0.2d-fips-2.0.10
-java ( no version )



instructions
============

1/ Remplir le fichier liste.csv avec les elements demandés
2/ Executer 01-generation_certificat.bat
3/ Envoyer les fichiers CSR à l'admin
4/ Déposer les CER venant de l'infra dans les dossiers respectifs
5/ Executer 02-import_certificat.bat
6/ Enjoy !




Utilisation
===========

Apache :
--------
Voir fichier de conf :
	Windows :
	
	Linux :
		/etc/httpd/conf.d/ssl.conf
		
		
			SSLCertificateFile /etc/httpd/conf/ssl.crt/mygsf14052013.cer
			SSLCertificateKeyFile /etc/httpd/conf/ssl.key/mygsf14052013.key

Tomcat :
--------

Voir fichier de conf :
	Windows :
		[...]\Tomcat\conf\server.xml
		
			//Tomcat 8.5
			<Connector 	port="443" 
						protocol="org.apache.coyote.http11.Http11NioProtocol"
						maxThreads="150" SSLEnabled="true">
						<SSLHostConfig>
							<Certificate 
									certificateKeystoreFile="file:///C:/Apache/Tomcat 8.5/SSL/keystore.jks"
									certificateKeystorePassword="changeit"
									certificateKeyAlias="changeit"
									type="RSA" 
							/>
						</SSLHostConfig>
			</Connector>

			//Tomcat x
			<Connector 	port="8443"
						protocol="org.apache.coyote.http11.Http11Protocol"
						maxThreads="150" SSLEnabled="true"
						scheme="https" secure="true"
						keystoreFile="D:\Products\tibco\tibcojre64\1.8.0\lib\security\keystore.jks"
						keystorePass="changeit"
						clientAuth="false" sslProtocol="TLS" />
						
			//Tomcat 9
			<Connector 	port="8443"
						protocol="org.apache.coyote.http11.Http11NioProtocol"
						SSLCertificateFile="file:///D:/apache-tomcat-9.0.24/conf/certificat/espacegsf.cer"
						SSLCertificateKeyFile="file:///D:/apache-tomcat-9.0.24/conf/certificat/espacegsf.key"
						maxThreads="150"
						SSLProtocol="TLSv1+TLSv1.1+TLSv1.2"
						SSLEnabled="true">
			</Connector>

	Linux :
		[...]/Tomcat/conf/server.xml
		
		    <Connector port="8443" protocol="org.apache.coyote.http11.Http11Protocol"
				maxHttpHeaderSize="65536"
				server=" " SSLEnabled="true"
				maxThreads="150" minSpareThreads="25"
				enableLookups="false" disableUploadTimeout="true"
				acceptCount="100" scheme="https" secure="true"
				clientAuth="false" sslProtocol="TLS"
				sslEnabledProtocols="TLSv1.2,TLSv1.1,TLSv1"
				keystoreFile="/opt/sng/tomcat/conf/server.p12"
				keystorePass="changeit"
				keystoreType="PKCS12"
				truststoreFile="/opt/sng/tomcat/conf/cacert.jks"
				truststorePass="changeit"
				truststoreType="JKS"
				URIEncoding="UTF-8" />


IIS :
-----
fichier *.p12