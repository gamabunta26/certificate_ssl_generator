@echo off 
CLS
TITLE SSL CERTIFICATE GENERATOR

REM # ========================================================================= 
REM # Definition des variables
REM # =========================================================================
set VAR_PATH_SCRIPT=%~f0
set VAR_LETTRE=%~d0
set VAR_PATH_ACCES=%~p0

REM # prompt user pour avoir le nom du serveur
SET /P servername=nom du serveur sans extension : 
SET /P domain=nom du domaine  : 
SET /P serverIP=adresse IP du serveur : 

REM # calcul variable
set VAR_PATH_WORK=%VAR_LETTRE%%VAR_PATH_ACCES%
set VAR_DATE=%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%-%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%
set VAR_DATE=%VAR_DATE: =%
set VAR_WORKDIR=%servername%_%VAR_DATE%
set VAR_PATH_OUTPUT=%VAR_PATH_WORK%%VAR_WORKDIR%

REM Definition OpenSSL
set OPENSSL_PATH=%VAR_PATH_WORK%\openssl-1.0.2d-fips-2.0.10
set PATH=%OPENSSL_PATH%\bin;%PATH%
set OPENSSL_CONF=%VAR_PATH_OUTPUT%\%servername%_openssl.cnf
set OPENSSL_CONF_CA=%VAR_PATH_OUTPUT%\%servername%_openssl_ca.cnf


REM # ========================================================================= 
REM # Main
REM # =========================================================================

REM # créé un repertoire de travail
mkdir %VAR_WORKDIR%

REM # créé le fichier de conf
echo HOME = .>> %OPENSSL_CONF%
echo [ req ]>> %OPENSSL_CONF%
echo default_bits = 4096>> %OPENSSL_CONF%
echo default_keyfile = %servername%.key>> %OPENSSL_CONF%
echo req_extensions = v3_req>> %OPENSSL_CONF%
echo distinguished_name = req_distinguished_name>> %OPENSSL_CONF%
echo x509_extensions	= usr_cert>> %OPENSSL_CONF%
echo prompt = no>> %OPENSSL_CONF%
echo [ v3_req ]>> %OPENSSL_CONF%
echo basicConstraints = CA:FALSE>> %OPENSSL_CONF%
echo keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment>> %OPENSSL_CONF%
echo extendedKeyUsage = serverAuth, clientAuth, codeSigning, emailProtection>> %OPENSSL_CONF%
echo subjectAltName = @alt_names>> %OPENSSL_CONF%
echo [ req_distinguished_name ]>> %OPENSSL_CONF%
echo C  = FR>> %OPENSSL_CONF%
echo ST = PACA>> %OPENSSL_CONF%
echo L  = Cagnes-Sur-Mer>> %OPENSSL_CONF%
echo O  = DORIER SAS>> %OPENSSL_CONF%
echo OU = DSI>> %OPENSSL_CONF%
echo CN = %servername%.%domain%>> %OPENSSL_CONF%
echo emailAddress = benjamin@dorier.fr>> %OPENSSL_CONF%
echo [ usr_cert ]>> %OPENSSL_CONF%
echo basicConstraints=CA:FALSE>> %OPENSSL_CONF%
echo nsCertType = client, server, email>> %OPENSSL_CONF%
echo keyUsage = nonRepudiation, digitalSignature, keyEncipherment>> %OPENSSL_CONF%
echo extendedKeyUsage = serverAuth, clientAuth, codeSigning, emailProtection>> %OPENSSL_CONF%
echo nsComment = "OpenSSL Generated Certificate">> %OPENSSL_CONF%
echo subjectKeyIdentifier=hash>> %OPENSSL_CONF%
echo authorityKeyIdentifier=keyid,issuer>> %OPENSSL_CONF%
echo [ alt_names ]>> %OPENSSL_CONF%
echo DNS.1 = %servername%.%domain%>> %OPENSSL_CONF%
echo DNS.2 = %servername%>> %OPENSSL_CONF%
echo IP.1 = %serverip%>> %OPENSSL_CONF%

REM fichier de conf pour signer par le CA
echo subjectAltName=DNS:%servername%.%domain%,DNS:%servername%,IP:%serverip% > %OPENSSL_CONF_CA%


REM generate a certificate request
openssl req -newkey rsa:4096 -keyout %VAR_PATH_OUTPUT%\%servername%.key -nodes -config %OPENSSL_CONF% -out %VAR_PATH_OUTPUT%\%servername%.csr



REM signé par le CA
openssl x509 -req -in %VAR_PATH_OUTPUT%\%servername%.csr -CA CA_cert\CA_ROOT.cer -CAkey CA_cert\CA_ROOT.key -CAcreateserial -out %VAR_PATH_OUTPUT%\%servername%.cer -days 365 -extfile %OPENSSL_CONF_CA%