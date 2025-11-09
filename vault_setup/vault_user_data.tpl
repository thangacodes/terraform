#!/bin/bash
set -e

LOG_FILE="/tmp/vault_installation.log"
exec > >(tee -a $LOG_FILE) 2>&1

echo "==> Installing prerequisites..."
sudo yum install -y yum-utils shadow-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum install -y vault

echo "==> Creating Vault directories..."
sudo mkdir -p /etc/vault.d /opt/vault/data
sudo chown -R vault:vault /opt/vault
sudo chmod -R 750 /opt/vault

echo "==> Fetching public IP..."
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

echo "==> Writing Vault configuration..."
cat <<VAULTCFG | sudo tee /etc/vault.d/vault.hcl
ui = true
disable_mlock = true

storage "raft" {
  path    = "/opt/vault/data"
  node_id = "${node_id}"
}

listener "tcp" {
  address          = "0.0.0.0:8200"
  cluster_address  = "0.0.0.0:8201"
  tls_disable      = 1
}

api_addr     = "http://$PUBLIC_IP:8200"
cluster_addr = "http://$PUBLIC_IP:8201"
cluster_name = "demo_cluster"
log_level    = "INFO"
VAULTCFG

echo "==> Starting Vault..."
systemctl enable vault
systemctl start vault
