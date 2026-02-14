#!/bin/bash
# User data script for EC2 instances

# Update system
yum update -y

# Install Docker
amazon-linux-extras install docker -y
service docker start
systemctl enable docker
usermod -a -G docker ec2-user

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Create app directory
mkdir -p /home/ec2-user/app
cd /home/ec2-user/app

# Create docker-compose file
cat > docker-compose.yml << EOF
version: '3.8'
services:
  app:
    image: nginx:latest
    ports:
      - "80:80"
    restart: always
EOF

# Start the container
docker-compose up -d
