#!/bin/bash
#Variables
USER_DIR="/Users/td"
TOKEN_FILE="$USER_DIR/.vault-token"

# Check if Vault is already running on port 8200
if lsof -i :8200 >/dev/null; then
    echo "Vault is already running on port 8200."
else
    echo "Vault is not running. Starting Vault in dev mode..."
    # Start Vault in dev mode in the background
    vault server -dev > "$USER_DIR/vault_dev.log" 2>&1 &
    # sleep for 3 seconds to vault initialize
    sleep 3
    echo "Vault started in dev mode."
fi
# Check if token file exists
if [ -f "$TOKEN_FILE" ]; then
    echo "Vault Token found at $TOKEN_FILE:"
    echo "---------------------------------------"
    cat "$TOKEN_FILE"
    echo "---------------------------------------"
else
    echo "Vault token not found at $TOKEN_FILE"
fi
