#!/usr/bin/env bash
set -euo pipefail

FILE="terraform.tfvars"
KEY="oidc_thumbprint"

# Get thumbprint
THUMBPRINT=$(openssl s_client \
  -servername token.actions.githubusercontent.com \
  -connect token.actions.githubusercontent.com:443 < /dev/null 2>/dev/null \
  | openssl x509 -fingerprint -sha1 -noout \
  | sed 's/.*=//' | tr -d ':' | tr 'A-Z' 'a-z')

# If key exists, replace its value; otherwise append
if grep -q "^${KEY}\s*=" "$FILE"; then
    # Replace existing line
    sed -i.bak "s|^${KEY}\s*=.*|${KEY} = \"$THUMBPRINT\"|" "$FILE"
else
    # Append if missing
    echo "${KEY} = \"$THUMBPRINT\"" >> "$FILE"
fi

echo "Updated $FILE with $KEY = $THUMBPRINT"
