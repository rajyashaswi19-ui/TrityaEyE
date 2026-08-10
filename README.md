<div align="center">

```
 ████████╗██████╗ ██╗████████╗██╗   ██╗ █████╗ ███████╗██╗   ██╗███████╗
    ██╔══╝██╔══██╗██║╚══██╔══╝╚██╗ ██╔╝██╔══██╗██╔════╝╚██╗ ██╔╝██╔════╝
    ██║   ██████╔╝██║   ██║    ╚████╔╝ ███████║█████╗   ╚████╔╝ █████╗  
    ██║   ██╔══██╗██║   ██║     ╚██╔╝  ██╔══██║██╔══╝    ╚██╔╝  ██╔══╝  
    ██║   ██║  ██║██║   ██║      ██║   ██║  ██║███████╗   ██║   ███████╗
    ╚═╝   ╚═╝  ╚═╝╚═╝   ╚═╝      ╚═╝   ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝
```

**TrityaEyE** — Vulnerability Scanning Suite

*Created by Yashaswi *

![Bash](https://img.shields.io/badge/Shell-Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20Kali-blue?style=for-the-badge&logo=linux&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)
![Version](https://img.shields.io/badge/Version-2.0-red?style=for-the-badge)
![Educational](https://img.shields.io/badge/Use-Educational%20Only-orange?style=for-the-badge)

</div>

---

## ⚠️ Legal Disclaimer

> **This tool is intended strictly for educational purposes and authorized penetration testing.**
> Scanning or probing systems without explicit written permission is **illegal** under the Computer Fraud and Abuse Act (CFAA), IT Act 2000 (India), and equivalent laws worldwide.
> The authors bear **no responsibility** for any misuse or damage caused by this tool.

---

## 📖 About

**TrityaEyE** is a terminal-based vulnerability scanning suite that bundles the most commonly used recon and scanning tools into a single, interactive, and beginner-friendly interface. Designed for cybersecurity students and ethical hackers, it simplifies running multi-step recon workflows without memorizing complex flags.

---

## ✨ Features

| Feature | Description |
|---|---|
| 🔍 **10 Integrated Tools** | Nmap, WhatWeb, DNSRecon, Dirb, Gobuster, Nikto, TheHarvester, Sublist3r, Whois |
| 🚀 **Full Recon Mode** | Runs all tools on a single target automatically |
| 📋 **Scan Presets** | Quick-select scan profiles (e.g., quick/full/stealth for Nmap) |
| 📝 **Auto Logging** | All scan output saved to timestamped logs in `~/.tritya_logs/` |
| 🎨 **Colorized UI** | Clean, color-coded terminal interface |
| ⚖️ **Legal Gate** | Disclaimer prompt before tool launches |
| 🔧 **Dependency Aware** | Warns if a required tool is missing before running |

---

## 🛠️ Tools Included

| # | Tool | Purpose |
|---|---|---|
| 1 | **Nmap** | Port scanning, service/OS detection |
| 2 | **WhatWeb** | Web technology fingerprinting |
| 3 | **DNSRecon** | DNS enumeration, zone transfer, brute-force |
| 4 | **Dirb** | Directory and file brute-forcing |
| 5 | **Gobuster** | Fast dir/DNS/vhost brute-forcing |
| 6 | **Nikto** | Web server misconfiguration & vuln scanning |
| 7 | **TheHarvester** | OSINT: emails, subdomains, IPs |
| 8 | **Sublist3r** | Passive subdomain enumeration |
| 9 | **Whois** | Domain registration & ownership info |
| 10 | **Full Recon** | Automated pipeline of all tools |

---

## 📦 Installation

### Prerequisites

Recommended: **Kali Linux** or any Debian-based distro (most tools are pre-installed on Kali).

```bash
# Install all dependencies (Debian/Ubuntu/Kali)
sudo apt update && sudo apt install -y \
    nmap \
    whatweb \
    dnsrecon \
    dirb \
    gobuster \
    nikto \
    theharvester \
    whois

# Install Sublist3r (if not present)
pip install sublist3r
```

### Clone & Run

```bash
# Clone the repository
git clone https://github.com/yourusername/TrityaEyE.git
cd TrityaEyE

# Give execute permission
chmod +x TrityaEyE.sh

# Run
./TrityaEyE.sh
```

---

## 🖥️ Usage

```
./TrityaEyE.sh
```

On launch, you'll see the interactive menu:

```
  SELECT A TOOL
  ──────────────────────────────────────────────────
  [1]  Nmap         — Port scanning & service detection
  [2]  WhatWeb      — Web technology fingerprinting
  [3]  DNSRecon     — DNS enumeration & zone transfer
  [4]  Dirb         — Directory & file brute-forcing
  [5]  Gobuster     — Fast dir/DNS/vhost brute-forcing
  [6]  Nikto        — Web server vulnerability scanner
  [7]  TheHarvester — OSINT: emails, subdomains, IPs
  [8]  Sublist3r    — Subdomain enumeration
  [9]  Whois        — Domain registration info
  [10] Full Recon   — Run all tools on a target
  [11] View Logs    — Open last scan log
  [12] Exit
```

---

## 📂 Logs

All scan results are automatically saved:

```
~/.tritya_logs/
  └── scan_20240601_143022.log
  └── scan_20240601_150511.log
  └── ...
```

Use option **[11] View Logs** from the menu to browse and open previous scans.

---

## 📸 Screenshot

> *(Add your own terminal screenshot here)*
> ```
> [screenshot.png]
> ```

---

## 🗺️ Roadmap

- [ ] CVE lookup integration (via NVD API)
- [ ] HTML report export
- [ ] Automated severity tagging in logs
- [ ] Shodan API integration
- [ ] Config file support for custom defaults

---

## 🤝 Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you'd like to change.

1. Fork the repo
2. Create your branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m 'Add some feature'`
4. Push to the branch: `git push origin feature/your-feature`
5. Open a Pull Request

---

## 👨‍💻 Authors

- **Yashaswi** — [GitHub](https://github.com/rajyashaswi19-ui)

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

---

<div align="center">
  <sub>Made with ❤️ for the cybersecurity community. Use responsibly.</sub>
</div>
