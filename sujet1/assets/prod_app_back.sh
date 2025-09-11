#!/bin/bash
aws s3 cp s3://${BUCKET}/back .
chmod +x back
sudo dnf install libxcrypt-compat -y
# Rendre dynamique db host en utlisant terraform templatefile
./back --db-host  ${DATABASE} -p 80