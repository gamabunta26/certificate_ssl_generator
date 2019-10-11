echo off
CLS
TITLE SSL CERTIFICATE GENERATOR
REM ##########################################################################
REM # Nom....... :  02-import_certificat.bat
REM ##########################################################################
REM # Objectif.. :  Import certificat and autority in different format of keystore ( JKS / P12 )
REM #
REM ##########################################################################
REM # Input parameters :
REM # ------------------
REM # parameter 	 : none
REM # Input File     : liste.csv, *.cer
REM # Output File    : *.jks, *.p12
REM #
REM ##########################################################################
REM # Revision :
REM # ----------
REM # - initial version  - 27/09/2019 - BDR - initial creation
REM # - MAJ				 - 03/10/2019 - BDR - update
REM #
REM ###########################################################################



REM # ========================================================================= 
REM # Definition des variables
REM # =========================================================================
set VAR_PATH_SCRIPT=%~f0
set VAR_LETTRE=%~d0
set VAR_PATH_ACCES=%~p0
set VAR_PATH_WORK=%VAR_LETTRE%%VAR_PATH_ACCES%
set VAR_PATH_OUTPUT="%VAR_PATH_WORK%output"

REM Definition Java
set JAVA_HOME=C:\Program Files (x86)\Java\jre1.8.0_144
set PATH=%JAVA_HOME%\bin;%PATH%

REM Definition OpenSSL
set PATH=%VAR_PATH_WORK%\openssl-1.0.2d-fips-2.0.10\bin;%PATH%
set OPENSSL_CONF=%VAR_PATH_WORK%\openssl-1.0.2d-fips-2.0.10\share\openssl.cnf


REM # ========================================================================= 
REM # Main
REM # =========================================================================
for /f "tokens=1,2,3,4,5,6 delims=;" %%a  in ('type liste.csv ^| findstr /V /B #') do (
	echo "======================="
	echo Application    : %%a
	REM echo Environnement  : %%b
	REM echo Mot_de_passe   : %%c
	REM echo Alias          : %%d
	REM echo Nom_output     : %%e
	echo URL            : %%f
	
	
	REM generate a p12 certificate from the key and the certificate
	openssl pkcs12 -export -in %VAR_PATH_OUTPUT%\%%a\%%b\%%e.cer -inkey %VAR_PATH_OUTPUT%\%%a\%%b\%%e.key -passout pass:%%c -out %VAR_PATH_OUTPUT%\%%a\%%b\%%e.p12 -name %%d
	
    REM import of autority
	keytool -import -noprompt -trustcacerts -alias CA_root -file "%VAR_PATH_WORK%CA_cert\CA_root.cer" -keystore %VAR_PATH_OUTPUT%\%%a\%%b\%%e.p12 -storepass %%c -storetype PKCS12
	
	REM convert from P12 to JKS
	keytool -importkeystore -srckeystore %VAR_PATH_OUTPUT%\%%a\%%b\%%e.p12 -destkeystore %VAR_PATH_OUTPUT%\%%a\%%b\%%e.jks -srcstoretype pkcs12 -deststoretype jks -srcstorepass %%c -deststorepass %%c
)

pause