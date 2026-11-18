
# Eaglercraft 1.21.11 Server

Host your own Minecraft 1.21.11 Eaglercraft server for free using GitHub Codespaces. No coding experience needed!

> **Note:** Codespaces is not 24/7 hosting. Your server goes offline when your Codespace stops.

## 1. Open GitHub Codespaces

1. Click the green **Code** button on this repository.
2. Select **Codespaces → Create codespace on main**.
3. Once loaded, open **Terminal → New Terminal**.

## 2. Set Up and Start the Server

Run these commands in order:

**Install Java and dependencies:**
```bash
bash setup.sh
```

**Start Minecraft and the Eaglercraft proxy:**
```bash
bash start.sh
```

Both servers start automatically. Minecraft logs appear in the terminal while the proxy runs in the background.

## 3. Get Your Server IP

1. Open the **Ports** tab in Codespaces.
2. Add port `8081` if it isn't already listed.
3. Right-click port `8081` and set its visibility to **Public**.
4. Copy the forwarded address and replace `https://` with `wss://`.

**Example:**

`https://example-8081.app.github.dev`

Becomes:

`wss://example-8081.app.github.dev`

Use this address to join through Eaglercraft!

## 4. Stop the Server

Open another terminal and run:

```bash
bash stop.sh
```

This safely stops both servers.

## Useful Commands

| Action | Command |
| --- | --- |
| Setup | `bash setup.sh` |
| Start | `bash start.sh` |
| Stop | `bash stop.sh` |
| Reopen Minecraft console | `tmux attach -t eagler_minecraft` |

To leave the Minecraft console without stopping the server, press **Ctrl+B**, then **D**.

---

NOTE: This readme and the .sh files were generated with Artificial Intelligence, I will not be using this github repository it is only here to provide support for a newer version then what people that use my eaglercraft server templates repositories currently support.

If its refusing to stop for wtv reason just run "tmux kill-session -t eagler_proxy 2>/dev/null; tmux kill-session -t eagler_minecraft 2>/dev/null" itll force kill it.
