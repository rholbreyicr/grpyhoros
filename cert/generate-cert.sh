#developed from https://dev.to/techschoolguru/how-to-create-sign-ssl-tls-certificates-2aai
#remove "-nodes" arg to force generation of encrypted private keys

rm *.pem

OPENSSL=/usr/local/Cellar/openssl@1.1/1.1.1i/bin/openssl

# 1. Generate CA's private key and self-signed certificate
${OPENSSL} req -x509 -newkey rsa:4096 -days 365 -nodes -keyout ca-key.pem -out ca-cert.pem -subj "/C=UK/ST=Surrey/L=Sutton/O=ICR/OU=Imaging&Radiotherapy/CN=icr.ac.uk/emailAddress=pyosirix_ca@icr.ac.uk"

#echo "CA's self-signed certificate"
#openssl x509 -in ca-cert.pem -noout -text

# 2. Generate web server's private key and certificate signing request (CSR)
${OPENSSL} req -newkey rsa:4096 -nodes -keyout server-key.pem -out server-req.pem -subj "/C=UK/ST=Surrey/L=Sutton/O=ICR/OU=Imaging&Radiotherapy/CN=icr.ac.uk/emailAddress=horos.osirix@icr.ac.uk"

# 3. Use CA's private key to sign web server's CSR and get back the signed certificate
${OPENSSL} x509 -req -in server-req.pem -days 365 -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -extfile server-ext.cnf

#echo "Server's signed certificate"
#openssl x509 -in server-cert.pem -noout -text

# 4. Generate client's private key and certificate signing request (CSR)
${OPENSSL} req -newkey rsa:4096 -nodes -keyout client-key.pem -out client-req.pem -subj "/C=UK/ST=Surrey/L=Sutton/O=ICR/OU=Imaging&Radiotherapy/CN=icr.ac.uk/emailAddress=pyosirix@icr.ac.uk"

# 5. Use CA's private key to sign client's CSR and get back the signed certificate
${OPENSSL} x509 -req -in client-req.pem -days 365 -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out client-cert.pem -extfile client-ext.cnf

#echo "Client's signed certificate"
#openssl x509 -in client-cert.pem -noout -text

#verify
#${OPENSSL} verify -CAfile ca-cert.pem server-cert.pem
# eg should return: server-cert.pem: OK
