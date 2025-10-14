#!/bin/bash
echo "Deployment of FastAPI setup on Amazon Linux 2023 at:" $(date '+%y-%m-%d %H:%M:%S')

# Log output to file appending
exec > >(tee /tmp/log/fastapi_setup.log) 2>&1

# Update packages
dnf update -y

# Install required tool packages
dnf install -y python3 python3-pip git curl

# Symlink python to python3 if needed
if ! command -v python &>/dev/null; then
    ln -s /usr/bin/python3 /usr/bin/python
    echo ">>> Created symlink: python -> python3"
fi

# Define app user and directory
APP_USER="ec2-user"
APP_DIR="/home/${APP_USER}"

mkdir -p "$APP_DIR"
chown $APP_USER:$APP_USER "$APP_DIR"

# Install FastAPI and Uvicorn globally
pip3 install --no-cache-dir fastapi uvicorn

# Create FastAPI app
cat > "$APP_DIR/main.py" <<EOF
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello from FastAPI on Amazon Linux 2023!"}

@app.get("/register")
def read_register():
    return {"message": "Registration Window Opened"}

@app.get("/users")
def read_users():
    return {"message": "Users Window Opened"}
EOF

chown $APP_USER:$APP_USER "$APP_DIR/main.py"

# Get full path to uvicorn
UVICORN_BIN=$(which uvicorn)

if [ -z "$UVICORN_BIN" ]; then
  echo "ERROR: uvicorn not found in PATH"
  exit 1
fi

# Create systemd service
cat > /etc/systemd/system/fastapi.service <<EOF
[Unit]
Description=FastAPI app
After=network.target

[Service]
User=$APP_USER
WorkingDirectory=$APP_DIR
ExecStart=$UVICORN_BIN main:app --host 0.0.0.0 --port 8000
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Check if fastapi.service exists
if [ -f /etc/systemd/system/fastapi.service ]; then
    echo "fastapi.service file is created successfully"
else
    echo "cross checked: the file does not exist..."
fi

# Reload and start service
systemctl daemon-reload
systemctl enable fastapi.service
systemctl start fastapi.service
systemctl status fastapi.service

echo "FastAPI setup completed at:" $(date '+%y-%m-%d %H:%M:%S')
