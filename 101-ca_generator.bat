openssl req -x509 -nodes -newkey rsa:4096 -keyout CA_cert\CA_ROOT.key -out CA_cert\CA_ROOT.cer -days 3650 -subj "/C=FR/ST=PACA/L=CAGNES-SUR-MER/O=DORIER SAS/CN=DORIER SAS - CA ROOT"
