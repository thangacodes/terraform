#!/bin/bash
set -euxo pipefail
# Log everything
exec > /tmp/log/user-data.log 2>&1

echo "script to check whether the instance having an ec2 instnace profile or not"
echo "User-data started at $(date '+%Y-%m-%d %H:%M:%S')"

# Wait for IMDS to be available
sleep 7

# Get IMDSv2 token (1 hour)
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 3600")

# Query IAM info
curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/iam/info \
  > /tmp/profile_info.txt

echo "User-data completed at $(date '+%Y-%m-%d %H:%M:%S')"
exit 0
