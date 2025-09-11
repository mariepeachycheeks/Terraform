#!/bin/bash
aws s3 cp s3://${BUCKET}/webserver .
chmod +x webserver
sudo dnf install libxcrypt-compat -y
./webserver -p 80 --api-url http://${HOST}
#BRANDON HELP j'ai aucune idee pourquoi ca marche avec local host, et je vous bien que tu m'explique cette commande
