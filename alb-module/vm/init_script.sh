#!/bin/bash
LOGFILE="/tmp/$(hostname).log"
{
  echo "==== Script started at: $(date '+%d-%m-%Y %H:%M:%S') ===="
  echo "Sleeping for 60 seconds..."
  sleep 60
  echo "Running yum update..."
  yum update -y
  echo "Installing Apache (httpd)..."
  yum install -y httpd
  echo "Starting Apache service..."
  systemctl start httpd
  echo "Enabling Apache on boot..."
  systemctl enable httpd
  echo "Creating HTML welcome page with colored hostname..."
  cat <<EOF > /var/www/html/index.html
<html>
  <head>
    <title>Welcome to Home Page</title>
  </head>
  <body style="background-color: skyblue;">
    <h1 style="color: black;">Hello from Web Server</h1>
    <h1 style="color: blue;">$(hostname)</h1>
    <p style="color: green; font-size: 18px; font-weight: bold;">This is a static page running on an Apache web server.</p>
  </body>
</html>
EOF
  echo "==== Script completed at: $(date '+%d-%m-%Y %H:%M:%S') ===="
} >> "$LOGFILE" 2>&1
