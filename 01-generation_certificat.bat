echo off
CLS
TITLE SSL CERTIFICATE GENERATOR
REM ##########################################################################
REM # Nom....... :  01-generation_certificat.bat
REM ##########################################################################
REM # Objectif.. :  Generate private keys without password and certificate request
REM #
REM ##########################################################################
REM # Input parameters :
REM # ------------------
REM # parameter 	 : none
REM # Input File     : liste.csv
REM # Output File    : *.key, *.csr
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
set VAR_PATH_OUTPUT="%VAR_PATH_WORK%\output"

REM Definition Java
set JAVA_HOME=C:\Program Files (x86)\Java\jre1.8.0_144
set PATH=%JAVA_HOME%\bin;%PATH%

REM Definition OpenSSL
set PATH=%VAR_PATH_WORK%\openssl-1.0.2d-fips-2.0.10\bin;%PATH%
set OPENSSL_CONF=%VAR_PATH_WORK%\openssl-1.0.2d-fips-2.0.10\share\openssl.cnf



REM # ========================================================================= 
REM # Main
REM # =========================================================================
REM test work directory
IF NOT EXIST %VAR_PATH_OUTPUT% (
	mkdir %VAR_PATH_OUTPUT%
)


for /f "tokens=1,2,3,4,5,6 delims=;" %%a  in ('type liste.csv ^| findstr /V /B #') do (
	echo "======================="
	REM echo Application    : %%a
	REM echo Environnement  : %%b
	REM echo Mot_de_passe   : %%c
	REM echo Alias          : %%d
	REM echo Nom_output     : %%e
	echo URL            : %%f
	
	REM test work directory
	IF NOT EXIST %VAR_PATH_OUTPUT%\%%a (
		mkdir %VAR_PATH_OUTPUT%\%%a
	)
	IF NOT EXIST %VAR_PATH_OUTPUT%\%%a\%%b (
		mkdir %VAR_PATH_OUTPUT%\%%a\%%b
	)
	
	REM generate a private key uncrypted
	openssl genrsa -out %VAR_PATH_OUTPUT%\%%a\%%b\%%e.key 2048
	
	REM generate a certificate request
	openssl req -new -key %VAR_PATH_OUTPUT%\%%a\%%b\%%e.key -out %VAR_PATH_OUTPUT%\%%a\%%b\%%e.csr -subj "/C=FR/ST=PACA/L=Biot/O=DORIER/OU=DSI/CN=%%f"
)

pause