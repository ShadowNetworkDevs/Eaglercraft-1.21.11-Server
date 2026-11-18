
#!/bin/bash

set -e

ROOT="$(cd "$(dirname "$0")" && pwd)"
MC="$ROOT/Server/MinecraftServer"
PROXY="$ROOT/Server/EaglerProxy"

MC_SESSION="eagler_minecraft"
PROXY_SESSION="eagler_proxy"

mkdir -p "$ROOT/logs"

if [ ! -f "$MC/server.jar" ]; then
    echo "Error: Minecraft server.jar not found."
    exit 1
fi

if [ ! -f "$PROXY/proxy.jar" ]; then
    echo "Error: Proxy proxy.jar not found."
    exit 1
fi

if ! command -v tmux >/dev/null 2>&1; then
    echo "Run bash setup.sh first."
    exit 1
fi

if tmux has-session -t "=$MC_SESSION" 2>/dev/null || tmux has-session -t "=$PROXY_SESSION" 2>/dev/null; then
    echo "A server session is already running."
    exit 1
fi

echo "Starting Minecraft server..."

tmux new-session -d \
    -s "$MC_SESSION" \
    -c "$MC" \
    "java -Xms1G -Xmx2G -jar server.jar nogui"

sleep 2

if ! tmux has-session -t "=$MC_SESSION" 2>/dev/null; then
    echo "Minecraft failed to start."
    exit 1
fi

echo "Starting Eaglercraft proxy..."

tmux new-session -d \
    -s "$PROXY_SESSION" \
    -c "$PROXY" \
    "java -jar proxy.jar > '$ROOT/logs/proxy.log' 2>&1"

sleep 2

if ! tmux has-session -t "=$PROXY_SESSION" 2>/dev/null; then
    echo "Proxy failed to start. Check logs/proxy.log."
    exit 1
fi

echo ""
echo "Both server processes started."
echo "Minecraft console is available."
echo "Proxy output is hidden."
echo ""

if [ -n "${DISPLAY:-}" ] && command -v gnome-terminal >/dev/null 2>&1; then
    gnome-terminal -- bash -c "tmux attach-session -t '$MC_SESSION'"
    echo "Minecraft console opened in a new terminal."
    echo "Use bash stop.sh here to stop both servers."
else
    echo "Attaching to Minecraft console..."
    echo "To detach without stopping: Ctrl+B, then D"
    echo "Run bash stop.sh in another terminal."
    sleep 2
    tmux attach-session -t "$MC_SESSION"
fi
