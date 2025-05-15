#!/bin/bash
TABLE_NAME="active_account"
# Array of account data to inject
declare -a accounts=(
  '{"account_id": {"S": "acct_001"}, "reason": {"S": "sean"}, "added_at": {"S": "2025-05-01"}}'
  '{"account_id": {"S": "acct_002"}, "reason": {"S": "abbort"}, "added_at": {"S": "2025-05-05"}}'
  '{"account_id": {"S": "acct_003"}, "reason": {"S": "john"}, "added_at": {"S": "2025-05-10"}}'
  '{"account_id": {"S": "acct_004"}, "reason": {"S": "michael"}, "added_at": {"S": "2025-05-13"}}'
)
echo "Injecting test data into DynamoDB table: $TABLE_NAME"

# Loop through the accounts array and inject each item into DynamoDB
for account in "${accounts[@]}"; do
  echo "Injecting: $account"
  aws dynamodb put-item --table-name "$TABLE_NAME" --item "$account"
done
echo "Data injection completed."
