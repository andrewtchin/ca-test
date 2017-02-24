#!/usr/bin/env bash

cp /root/ca/certs/ca.cert.crt /usr/local/share/ca-certificates

dpkg-reconfigure --frontend=noninteractive ca-certificates
