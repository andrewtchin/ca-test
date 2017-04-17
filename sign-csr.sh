#!/usr/bin/env bash

# Sign a CSR with specified CA

set -euf -o pipefail

CA_CRT_FILE="certs/START_ENTERPRISES_ROOT_CA.cert.crt"
OUTDIR="/root/ca"
SERVER_CERT_CN="starkenterprises.io"

while getopts ":c:d:n:" opt; do
  case $opt in
    c) CA_CRT_FILE="$OPTARG"
    ;;
    d) OUTDIR="$OPTARG"
    ;;
    n) SERVER_CERT_CN="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done


cd $OUTDIR
openssl ca -config openssl.cnf \
    -batch \
    -extensions server_cert \
    -days 365 -notext -md sha256 \
    -in csr/${SERVER_CERT_CN}.csr.pem \
    -out certs/${SERVER_CERT_CN}.cert.pem

chmod 444 certs/${SERVER_CERT_CN}.cert.pem
openssl x509 -noout -text -in certs/${SERVER_CERT_CN}.cert.pem

# Test certificate
openssl verify -CAfile $CA_CRT_FILE certs/${SERVER_CERT_CN}.cert.pem
