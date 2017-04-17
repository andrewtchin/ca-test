#!/usr/bin/env bash

# Generate a CA and server certificate bundle

set -euf -o pipefail

CA_DIR="/root/ca"
OUT_DIR="/root/ca/bundle"
OUT_FILE="/root/ca/cert-bundle.tgz"
SERVER_CERT_CN="starkenterprises.io"

while getopts ":d:f:n:o:" opt; do
  case $opt in
    d) CA_DIR="$OPTARG"
    ;;
    f) OUT_FILE="$OPTARG"
    ;;
    n) SERVER_CERT_CN="$OPTARG"
    ;;
    o) OUT_DIR="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

mkdir $OUT_DIR
cp certs/ca.cert.crt $OUT_DIR
cp private/${SERVER_CERT_CN}.key.pem $OUT_DIR
cp certs/${SERVER_CERT_CN}.cert.pem $OUT_DIR
tar cvf $OUT_FILE $OUT_DIR
