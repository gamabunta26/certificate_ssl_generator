REM variables
set KEYSIZE=4096
set SRV=fedora-srv

REM set la conf
set PATH=C:\\Workspace\\Github\\certificate_ssl_generator\\openssl-1.0.2d-fips-2.0.10\\bin;%PATH%
set OPENSSL_CONF=C:\\Workspace\\Github\\certificate_ssl_generator\\openssl-1.0.2d-fips-2.0.10\\bin\\openssl.cnf

REM generation de la clé et du certificat auto signé pour le role du CA
openssl req -x509 -nodes -newkey rsa:%KEYSIZE% -keyout CA_cert\CA_ROOT.key -out CA_cert\CA_ROOT.cer -days 3650 -subj "/C=FR/ST=PACA/L=CAGNES-SUR-MER/O=DORIER SAS/CN=DORIER SAS - CA ROOT"


REM client
REM generation de la clé et du CSR
openssl req -newkey rsa:%KEYSIZE% -keyout %SRV%.key -nodes  -out %SRV%.csr -subj "/C=FR/ST=PACA/L=CAGNES-SUR-MER/O=DORIER SAS/CN=%SRV%.local"



REM signé avec mon CA perso
openssl x509 -req -in %SRV%.csr -CA CA_cert\CA_ROOT.cer -CAkey CA_cert\CA_ROOT.key -CAcreateserial -out %SRV%.cer -days 365