
#!/bin/bash

MC_SESSION="eagler_minecraft"
PROXY_SESSION="eagler_proxy"

echo "Stopping Eaglercraft servers..."

if tmux has-session -t "=$MC_SESSION" 2>/dev/null; then
    echo "Saving and stopping Minecraft..."
    tmux send-keys -t "=$MC_SESSION" "stop" Enter
else
    echo "Minecraft is not running."
fi

if tmux has-session -t "=$PROXY_SESSION" 2>/dev/null; then
    echo "Stopping Eaglercraft proxy..."
    tmux send-keys -t "=$PROXY_SESSION" "end" Enter
else
    echo "Proxy is not running."
fi

for i in $(seq 1 60); do
    if ! tmux has-session -t "=$MC_SESSION" 2>/dev/null && ! tmux has-session -t "=$PROXY_SESSION" 2>/dev/null; then
        echo ""
        echo "Both servers stopped successfully."
        exit 0
    fi
    sleep 1
done

echo ""
echo "Shutdown is taking longer than expected."
echo "Check the Minecraft console before forcing a shutdown."
exit 1
