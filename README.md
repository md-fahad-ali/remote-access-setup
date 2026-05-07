# 🖥️ Linux Mint Browser-Based Remote Desktop Setup

A professional, high-performance remote desktop setup for Linux Mint (Cinnamon Edition) that works directly in any web browser.

## 🎯 Features
- **Actual Graphics:** Real Linux Mint Menu and Taskbar (Cinnamon 2D).
- **Lid Closure Support:** Laptop stays awake and accessible when the lid is closed.
- **Zero Client:** No VNC software needed on the remote device—just a browser.
- **Auto-Monitoring:** Background scripts ensure the connection stays alive.

---

## 🛠️ Step-by-Step Setup from Scratch

### 1. Install Required Packages
First, install the VNC server, the Cinnamon environment, and the necessary networking tools:
```bash
sudo apt update
sudo apt install -y tigervnc-standalone-server xterm cinnamon-session dbus-x11 git python3
```

### 2. Download noVNC
Clone the noVNC project to your home directory:
```bash
cd ~
git clone https://github.com/novnc/noVNC.git
```

### 3. Move Configuration Files
Move the files from this repository to their correct locations on your system:

| File | Destination | Command |
| :--- | :--- | :--- |
| `xstartup` | `~/.vnc/xstartup` | `mkdir -p ~/.vnc && cp xstartup ~/.vnc/xstartup` |
| `background-services.sh` | `~/background-services.sh` | `cp background-services.sh ~/background-services.sh` |
| `sleep-aliases.sh` | `~/sleep-aliases.sh` | `cp sleep-aliases.sh ~/sleep-aliases.sh` |

**Make them executable:**
```bash
chmod +x ~/.vnc/xstartup
chmod +x ~/background-services.sh
chmod +x ~/sleep-aliases.sh
```

### 4. Configure Lid Closure (Stay Awake)
To keep the laptop running when the lid is shut:
1. Open the config: `sudo nano /etc/systemd/logind.conf`
2. Change or add this line: `HandleLidSwitch=ignore`
3. Restart the service: `sudo systemctl restart systemd-logind`

### 5. Set VNC Password
Create the password you will use to log in via the browser:
```bash
vncpasswd
```

---

## 🚀 How to Start the Remote Desktop

### Step 1: Start the VNC Server
This starts the Linux Mint desktop in the background:
```bash
vncserver :1 -geometry 1280x720 -depth 24 -localhost no
```

### Step 2: Start the Web Gateway (noVNC)
This creates the browser link:
```bash
~/noVNC/utils/novnc_proxy --vnc localhost:5901 --listen 6080
```

### Step 3: Access via Browser
Open your browser and go to:
`http://<YOUR_IP_ADDRESS>:6080/vnc.html`

---

## 💡 Tips & Automation
- **Shortcuts:** Add `source ~/sleep-aliases.sh` to your `~/.zshrc` or `~/.bashrc` to use commands like `slp` (sleep mode) and `perf` (performance mode).
- **Background Check:** Run `~/background-services.sh` to ensure the gateway stays active.
