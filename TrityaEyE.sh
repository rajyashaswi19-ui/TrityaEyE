#!/bin/bash

# ============================================================
#   TrityaEyE - Vulnerability Scanning Suite
#   Created by Yashaswi 
#   Version: 2.0
#   License: MIT
# ============================================================

# ── Colors ──────────────────────────────────────────────────
RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
MAGENTA="\e[1;35m"
CYAN="\e[1;36m"
WHITE="\e[1;37m"
DIM="\e[2m"
RESET="\e[0m"

# ── Globals ──────────────────────────────────────────────────
LOG_DIR="$HOME/.tritya_logs"
LOG_FILE="$LOG_DIR/scan_$(date +%Y%m%d_%H%M%S).log"
VERSION="2.0"

# ── Logging ──────────────────────────────────────────────────
init_log() {
    mkdir -p "$LOG_DIR"
    echo "=== TrityaEyE Scan Log ===" > "$LOG_FILE"
    echo "Date: $(date)" >> "$LOG_FILE"
    echo "Host: $(hostname)" >> "$LOG_FILE"
    echo "User: $(whoami)" >> "$LOG_FILE"
    echo "==============================" >> "$LOG_FILE"
}

log() {
    echo -e "$1" | tee -a "$LOG_FILE"
}

# ── Banner ────────────────────────────────────────────────────
display_banner() {
    clear
    echo -e "${CYAN}"
    echo " ████████╗██████╗ ██╗████████╗██╗   ██╗ █████╗ ███████╗██╗   ██╗███████╗"
    echo "    ██╔══╝██╔══██╗██║╚══██╔══╝╚██╗ ██╔╝██╔══██╗██╔════╝╚██╗ ██╔╝██╔════╝"
    echo "    ██║   ██████╔╝██║   ██║    ╚████╔╝ ███████║█████╗   ╚████╔╝ █████╗  "
    echo "    ██║   ██╔══██╗██║   ██║     ╚██╔╝  ██╔══██║██╔══╝    ╚██╔╝  ██╔══╝  "
    echo "    ██║   ██║  ██║██║   ██║      ██║   ██║  ██║███████╗   ██║   ███████╗"
    echo "    ╚═╝   ╚═╝  ╚═╝╚═╝   ╚═╝      ╚═╝   ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝"
    echo -e "${RESET}"
    echo -e "${DIM}${WHITE}         ┌──────────────────────────────────────────────────────┐${RESET}"
    echo -e "${DIM}${WHITE}         │  ${YELLOW}Vulnerability Scanning Suite ${DIM}${WHITE}│ ${GREEN}v${VERSION}${DIM}${WHITE}               │${RESET}"
    echo -e "${DIM}${WHITE}         │  ${CYAN}Created by Yashaswi ${DIM}${WHITE}           │${RESET}"
    echo -e "${DIM}${WHITE}         │  ${RED}⚠  For educational and authorized use only ⚠${DIM}${WHITE}      │${RESET}"
    echo -e "${DIM}${WHITE}         └──────────────────────────────────────────────────────┘${RESET}"
    echo ""
}

# ── Separator ─────────────────────────────────────────────────
sep() {
    echo -e "${DIM}${CYAN}  ─────────────────────────────────────────────────────────${RESET}"
}

# ── Dependency Check ──────────────────────────────────────────
check_tool() {
    local tool="$1"
    if ! command -v "$tool" &>/dev/null; then
        echo -e "${RED}  [✗] '$tool' is not installed or not in PATH.${RESET}"
        echo -e "${YELLOW}      Install it and try again.${RESET}"
        return 1
    fi
    return 0
}

# ── Menu ──────────────────────────────────────────────────────
display_menu() {
    sep
    echo -e "${WHITE}  SELECT A TOOL${RESET}"
    sep
    echo -e "  ${YELLOW}[1]${RESET} ${GREEN}Nmap${RESET}         ${DIM}— Port scanning & service detection${RESET}"
    echo -e "  ${YELLOW}[2]${RESET} ${GREEN}WhatWeb${RESET}      ${DIM}— Web technology fingerprinting${RESET}"
    echo -e "  ${YELLOW}[3]${RESET} ${GREEN}DNSRecon${RESET}     ${DIM}— DNS enumeration & zone transfer${RESET}"
    echo -e "  ${YELLOW}[4]${RESET} ${GREEN}Dirb${RESET}         ${DIM}— Directory & file brute-forcing${RESET}"
    echo -e "  ${YELLOW}[5]${RESET} ${GREEN}Gobuster${RESET}     ${DIM}— Fast dir/DNS/vhost brute-forcing${RESET}"
    echo -e "  ${YELLOW}[6]${RESET} ${GREEN}Nikto${RESET}        ${DIM}— Web server vulnerability scanner${RESET}"
    echo -e "  ${YELLOW}[7]${RESET} ${GREEN}TheHarvester${RESET} ${DIM}— OSINT: emails, subdomains, IPs${RESET}"
    echo -e "  ${YELLOW}[8]${RESET} ${GREEN}Sublist3r${RESET}    ${DIM}— Subdomain enumeration${RESET}"
    echo -e "  ${YELLOW}[9]${RESET} ${GREEN}Whois${RESET}        ${DIM}— Domain registration info${RESET}"
    echo -e "  ${YELLOW}[10]${RESET} ${GREEN}Full Recon${RESET}  ${DIM}— Run all tools on a target${RESET}"
    echo -e "  ${YELLOW}[11]${RESET} ${GREEN}View Logs${RESET}   ${DIM}— Open last scan log${RESET}"
    echo -e "  ${YELLOW}[12]${RESET} ${RED}Exit${RESET}"
    sep
    echo ""
}

# ── Scan Result Header ────────────────────────────────────────
scan_header() {
    local tool="$1" target="$2"
    echo ""
    sep
    log "${GREEN}  [★] Tool    : ${WHITE}$tool${RESET}"
    log "${GREEN}  [★] Target  : ${WHITE}$target${RESET}"
    log "${GREEN}  [★] Time    : ${WHITE}$(date '+%Y-%m-%d %H:%M:%S')${RESET}"
    sep
    echo ""
}

# ── Prompt Helper ─────────────────────────────────────────────
ask() {
    local prompt="$1" varname="$2" default="$3"
    if [ -n "$default" ]; then
        read -rp "$(echo -e "  ${CYAN}${prompt}${RESET} ${DIM}[default: ${default}]${RESET}: ")" "$varname"
        eval "[ -z \"\$$varname\" ] && $varname=\"$default\""
    else
        read -rp "$(echo -e "  ${CYAN}${prompt}${RESET}: ")" "$varname"
    fi
}

# ── Tools ─────────────────────────────────────────────────────

run_nmap() {
    check_tool nmap || return
    ask "Target IP or domain" target
    echo -e "  ${DIM}Preset profiles:${RESET}"
    echo -e "  ${YELLOW}[a]${RESET} Quick scan      (-T4 -F)"
    echo -e "  ${YELLOW}[b]${RESET} Service detect  (-sV -sC)"
    echo -e "  ${YELLOW}[c]${RESET} Full port scan   (-p- -T4)"
    echo -e "  ${YELLOW}[d]${RESET} OS detection    (-O -sV)"
    echo -e "  ${YELLOW}[e]${RESET} Custom options"
    ask "Profile" profile "b"
    case "$profile" in
        a) options="-T4 -F" ;;
        b) options="-sV -sC" ;;
        c) options="-p- -T4" ;;
        d) options="-O -sV" ;;
        e) ask "Custom Nmap options" options "" ;;
        *) options="-sV -sC" ;;
    esac
    scan_header "Nmap" "$target"
    nmap $options "$target" 2>&1 | tee -a "$LOG_FILE"
}

run_whatweb() {
    check_tool whatweb || return
    ask "Target URL (e.g. http://example.com)" target
    ask "Aggression level 1-4" agg "3"
    scan_header "WhatWeb" "$target"
    whatweb -a "$agg" "$target" 2>&1 | tee -a "$LOG_FILE"
}

run_dnsrecon() {
    check_tool dnsrecon || return
    ask "Target domain (e.g. example.com)" domain
    echo -e "  ${DIM}Scan types:${RESET}"
    echo -e "  ${YELLOW}[std]${RESET}  Standard (SOA, NS, A, AAAA, MX, TXT)"
    echo -e "  ${YELLOW}[axfr]${RESET} Zone transfer attempt"
    echo -e "  ${YELLOW}[brute]${RESET} Subdomain brute-force"
    echo -e "  ${YELLOW}[all]${RESET}  All types"
    ask "Type" dtype "std"
    scan_header "DNSRecon" "$domain"
    if [ "$dtype" = "brute" ]; then
        ask "Wordlist path" wl "/usr/share/wordlists/dnsmap.txt"
        dnsrecon -d "$domain" -t brt -D "$wl" 2>&1 | tee -a "$LOG_FILE"
    else
        dnsrecon -d "$domain" -t "$dtype" 2>&1 | tee -a "$LOG_FILE"
    fi
}

run_dirb() {
    check_tool dirb || return
    ask "Target URL" url
    ask "Wordlist path" wordlist "/usr/share/wordlists/dirb/common.txt"
    ask "Extra options (or leave blank)" options ""
    scan_header "Dirb" "$url"
    dirb "$url" "$wordlist" $options 2>&1 | tee -a "$LOG_FILE"
}

run_gobuster() {
    check_tool gobuster || return
    ask "Target URL" url
    ask "Wordlist path" wordlist "/usr/share/wordlists/dirb/common.txt"
    ask "Extensions (e.g. php,html,txt or blank)" ext ""
    ask "Threads" threads "50"
    scan_header "Gobuster" "$url"
    if [ -z "$ext" ]; then
        gobuster dir -u "$url" -w "$wordlist" -t "$threads" 2>&1 | tee -a "$LOG_FILE"
    else
        gobuster dir -u "$url" -w "$wordlist" -x "$ext" -t "$threads" 2>&1 | tee -a "$LOG_FILE"
    fi
}

run_nikto() {
    check_tool nikto || return
    ask "Target URL or IP" target
    ask "Extra Nikto options (or blank)" options ""
    scan_header "Nikto" "$target"
    nikto -h "$target" $options 2>&1 | tee -a "$LOG_FILE"
}

run_theharvester() {
    check_tool theHarvester || return
    ask "Target domain" domain
    ask "Data source (google/bing/all)" source "all"
    ask "Result limit" limit "200"
    scan_header "TheHarvester" "$domain"
    theHarvester -d "$domain" -b "$source" -l "$limit" 2>&1 | tee -a "$LOG_FILE"
}

run_sublist3r() {
    check_tool sublist3r || return
    ask "Target domain" domain
    ask "Threads" threads "40"
    scan_header "Sublist3r" "$domain"
    sublist3r -d "$domain" -t "$threads" 2>&1 | tee -a "$LOG_FILE"
}

run_whois() {
    check_tool whois || return
    ask "Domain or IP" target
    scan_header "Whois" "$target"
    whois "$target" 2>&1 | tee -a "$LOG_FILE"
}

run_full_recon() {
    echo -e "${YELLOW}  [!] Full Recon will run: Nmap, WhatWeb, DNSRecon, Nikto, Whois${RESET}"
    ask "Target domain/IP" target
    ask "Target URL (for web tools)" url "http://$target"
    echo ""
    echo -e "${CYAN}  [>] Starting Full Recon on: ${WHITE}$target${RESET}"

    for tool in nmap whatweb dnsrecon nikto whois; do
        check_tool "$tool" || echo -e "${YELLOW}  Skipping $tool...${RESET}"
    done

    scan_header "Full Recon" "$target"

    echo -e "\n${CYAN}  ── Whois ──${RESET}" | tee -a "$LOG_FILE"
    whois "$target" 2>&1 | head -30 | tee -a "$LOG_FILE"

    echo -e "\n${CYAN}  ── Nmap Quick Scan ──${RESET}" | tee -a "$LOG_FILE"
    nmap -T4 -F "$target" 2>&1 | tee -a "$LOG_FILE"

    echo -e "\n${CYAN}  ── DNSRecon ──${RESET}" | tee -a "$LOG_FILE"
    dnsrecon -d "$target" -t std 2>&1 | tee -a "$LOG_FILE"

    echo -e "\n${CYAN}  ── WhatWeb ──${RESET}" | tee -a "$LOG_FILE"
    whatweb -a 3 "$url" 2>&1 | tee -a "$LOG_FILE"

    echo -e "\n${CYAN}  ── Nikto ──${RESET}" | tee -a "$LOG_FILE"
    nikto -h "$url" 2>&1 | tee -a "$LOG_FILE"

    echo -e "\n${GREEN}  [✓] Full Recon complete. Log saved to: ${WHITE}$LOG_FILE${RESET}\n"
}

view_logs() {
    if [ -z "$(ls -A "$LOG_DIR" 2>/dev/null)" ]; then
        echo -e "${YELLOW}  No logs found in $LOG_DIR${RESET}"
    else
        echo -e "${CYAN}  Available Logs:${RESET}"
        ls -lt "$LOG_DIR" | grep -v total | head -10 | nl
        ask "Enter log number to view (or blank to skip)" lognum ""
        if [ -n "$lognum" ]; then
            logfile=$(ls -lt "$LOG_DIR" | grep -v total | awk '{print $NF}' | sed -n "${lognum}p")
            [ -n "$logfile" ] && less "$LOG_DIR/$logfile"
        fi
    fi
}

# ── Disclaimer ────────────────────────────────────────────────
show_disclaimer() {
    echo -e "${RED}"
    echo "  ╔══════════════════════════════════════════════════════╗"
    echo "  ║              ⚠  LEGAL DISCLAIMER ⚠                  ║"
    echo "  ╠══════════════════════════════════════════════════════╣"
    echo "  ║  This tool is intended for EDUCATIONAL purposes and  ║"
    echo "  ║  authorized penetration testing ONLY.                ║"
    echo "  ║                                                       ║"
    echo "  ║  Unauthorized scanning of systems you do NOT own     ║"
    echo "  ║  or have written permission to test is ILLEGAL.      ║"
    echo "  ║                                                       ║"
    echo "  ║  The authors bear NO responsibility for misuse.      ║"
    echo "  ╚══════════════════════════════════════════════════════╝"
    echo -e "${RESET}"
    read -rp "$(echo -e "  ${CYAN}I agree to use this tool legally and ethically. [yes/no]: ${RESET}")" agree
    if [[ "$agree" != "yes" ]]; then
        echo -e "${RED}  Exiting. You must accept the terms.${RESET}"
        exit 1
    fi
}

# ── Entry Point ───────────────────────────────────────────────
display_banner
show_disclaimer
init_log

while true; do
    display_banner
    display_menu
    read -rp "$(echo -e "  ${CYAN}Choice (1-12): ${RESET}")" choice
    echo ""

    case "$choice" in
        1)  run_nmap ;;
        2)  run_whatweb ;;
        3)  run_dnsrecon ;;
        4)  run_dirb ;;
        5)  run_gobuster ;;
        6)  run_nikto ;;
        7)  run_theharvester ;;
        8)  run_sublist3r ;;
        9)  run_whois ;;
        10) run_full_recon ;;
        11) view_logs ;;
        12)
            echo -e "${RED}  Exiting TrityaEyE. Goodbye!${RESET}"
            echo -e "${DIM}  Log saved to: $LOG_FILE${RESET}\n"
            break
            ;;
        *)
            echo -e "${RED}  [!] Invalid choice. Enter 1–12.${RESET}"
            sleep 1
            ;;
    esac

    echo ""
    read -rp "$(echo -e "  ${DIM}Press Enter to return to menu...${RESET}")" _
done
