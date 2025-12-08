resource "aws_cognito_identity_pool" "log_pool" {
  identity_pool_name                     = "cross-account-log-identity-pool"
  allow_unauthenticated_identities       = false
  developer_provider_name = "login.mycompany.myapp"
}
