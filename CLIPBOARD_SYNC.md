# 📋 Clipboard Synchronization Guide (Remote to Local)

This guide explains how to fix and use the shared clipboard between your local machine and the remote VNC desktop.

## 🛠️ The Solution: vncconfig

The primary tool for bridging the X11 clipboard (remote) with the VNC clipboard (local) is `vncconfig`.

### 1. Manual Fix (Immediate)
If copy-paste stops working, run this command in any terminal inside the VNC session:
```bash
vncconfig -nowin &
```
*Note: The `-nowin` flag runs it in the background without opening a configuration window.*

### 2. Permanent Fix (Automatic)
To ensure the clipboard works every time you start VNC, the following line is included in your `~/.vnc/xstartup` file:
```bash
vncconfig -iconic &
```

---

## 🌐 How to use with noVNC (Web Browser)

Since browsers have security restrictions regarding the system clipboard, follow these steps when using the web-based VNC link:

### Copying from Local → Remote:
1. Copy text on your **Main Machine** (Ctrl+C).
2. On the **VNC Browser Tab**, click the **Small Arrow** on the left side of the screen to open the noVNC menu.
3. Click the **Clipboard Icon** (looks like a notepad).
4. **Paste** your text into the text area that appears there.
5. Now, go into the Linux terminal/browser and **Paste** (Ctrl+V or Right-click > Paste).

### Copying from Remote → Local:
1. Copy text inside the **Linux Session** (Highlight + Right-click > Copy).
2. Open the **noVNC Clipboard Panel** (the side-menu icon).
3. The text you copied will appear in that text area.
4. **Copy** it from that text area to your **Main Machine's** clipboard.

---

## 🔍 Troubleshooting

- **Tool Missing:** If `vncconfig` is not found, install the TigerVNC standalone server package:
  ```bash
  sudo apt install tigervnc-standalone-server
  ```
- **Sync Lag:** If there is a delay, try restarting the process:
  ```bash
  killall vncconfig && vncconfig -nowin &
  ```
