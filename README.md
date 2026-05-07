# 🖥️ Linux Mint Browser-Based Remote Desktop Setup

This repository documents the professional setup of a high-performance, browser-accessible remote desktop for Linux Mint (Cinnamon Edition).

## 🎯 Objective
Enable full graphical access to the Linux Mint desktop environment via any web browser without requiring a dedicated VNC client, optimized for low-latency and authentic visual experience.

## 🛠️ Technical Architecture

### 1. TigerVNC Server (Backend)
- **Role:** High-performance Xvnc server.
- **Configuration:** Set to run on Display `:1` (Port 5901).
- **Security:** Password-protected (`vncpasswd`) with local and remote access enabled.

### 2. noVNC Gateway (Frontend)
- **Role:** HTML5 VNC client that uses WebSockets to provide a VNC interface in the browser.
- **Implementation:** A Python-based `websockify` proxy bridges the VNC traffic from port 5901 to a web-friendly port 6080.
- **Access URL:** `http://localhost:6080/vnc.html`

### 3. Cinnamon 2D (Graphical Environment)
To solve the common "Black Screen" issue in remote desktops (caused by VNC's lack of 3D acceleration), the system is forced into **Cinnamon Software Rendering Mode**.

**The `~/.vnc/xstartup` Configuration:**
```bash
#!/bin/bash
# Initialize Cinnamon in 2D/Software Rendering mode
export XDG_CURRENT_DESKTOP=X-Cinnamon
export XDG_SESSION_DESKTOP=cinnamon
export CINNAMON_2D=1

# Ensure the DBUS session is properly launched for Menu and Tray support
dbus-launch --exit-with-session cinnamon-session --session cinnamon2d &
```

## 🌙 24/7 Availability (Lid Closure)
The system is configured to maintain the remote session even when the physical laptop lid is closed. This was achieved by modifying the `systemd` login manager:
- **File:** `/etc/systemd/logind.conf`
- **Setting:** `HandleLidSwitch=ignore`

## 🚀 Usage
1. Start the VNC server: `vncserver :1`
2. Start the noVNC proxy: `./noVNC/utils/novnc_proxy --vnc localhost:5901 --listen 6080`
3. Connect via browser at Port 6080.

---
