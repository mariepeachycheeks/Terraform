#!/bin/bash
sudo su
aws s3 cp s3://${BUCKET}/webserver_x86_64 .
chmod +x webserver_x86_64
./webserver_x86_64 