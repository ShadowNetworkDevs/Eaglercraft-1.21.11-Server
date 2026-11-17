
#!/bin/bash

set -e

cd "$(dirname "$0")"

echo "=================================="
echo " Eaglercraft 1.21.11 Server Setup"
echo "=================================="
echo ""

if ! command -v apt-get >/dev/null 2>&1; then
    echo "This installer requires Ubuntu or Debian."
    exit 1
fi

echo "Installing Java 21 and tmux..."
sudo apt-get update
sudo apt-get install -y openjdk-21-jdk tmux

echo ""
echo "Java version:"
java -version


echo ""
echo "Checking server files..."

if [ -f Server/MinecraftServer/server.jar ]; then
    echo "Minecraft server found."
else
    echo "Missing: Server/MinecraftServer/server.jar"
fi

if [ -f Server/EaglerProxy/bungee.jar ]; then
    echo "Eaglercraft proxy found."
else
    echo "Missing: Server/EaglerProxy/bungee.jar"
fi

echo ""
echo "Setup complete!"
echo "Run bash start.sh to start the server."
