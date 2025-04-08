#!/usr/bin/env python3
# Ultimate Scanner Pro - Advanced Professional Edition (v4.0.0)
# Enhanced with Photon and Web-Scanner Features

import os
import sys
import json
import re
import logging
import subprocess
import argparse
from datetime import datetime, timedelta
from urllib.parse import urljoin, urlparse
from concurrent.futures import ThreadPoolExecutor, as_completed
import socket
import asyncio
import aiohttp
from bs4 import BeautifulSoup
from termcolor import colored
import pkg_resources

# إعداد السجل
logging.basicConfig(
    format='%(asctime)s - %(levelname)s - %(message)s',
    level=logging.INFO,
    handlers=[logging.FileHandler('scanner_pro.log'), logging.StreamHandler()]
)

# قائمة Wordlist مدمجة
DEFAULT_WORDLIST = [
    "index.html", "login", "admin", "dashboard", ".env", "config", "backup.sql",
    "phpinfo.php", "wp-login.php", "robots.txt", "sitemap.xml", "admin.php"
]

# خدمات Ninja Mode (مثل Photon)
NINJA_SERVICES = [
    "https://webhook.site/",
    "https://httpbin.org/get?url="
]

class ScannerConfig:
    def __init__(self, target, threads=10, timeout=8, delay=0, depth=2, scan_type="web", aggressive=False, ninja=False, regex=None):
        self.target = target.rstrip('/')
        self.threads = threads
        self.timeout = timeout
        self.delay = delay
        self.depth = depth
        self.scan_type = scan_type.lower()
        self.aggressive = aggressive
        self.ninja = ninja
        self.regex = regex
        if self.scan_type == "web" and not re.match(r'^https?://', self.target):
            raise ValueError("Invalid URL. Must start with http or https for web scan.")

class ProScanner:
    def __init__(self, config: ScannerConfig):
        self.config = config
        self.results = {"urls": [], "intel": [], "files": [], "keys": [], "js_endpoints": []}
        self.start_time = datetime.now()
        self.session = aiohttp.ClientSession(timeout=aiohttp.ClientTimeout(total=config.timeout))

    async def _fetch(self, url, session, service=None):
        try:
            target_url = f"{service}{url}" if service else url
            async with session.get(target_url) as response:
                text = await response.text()
                return {
                    "url": url,
                    "status": response.status,
                    "size": int(response.headers.get("Content-Length", 0)),
                    "content": text if response.status == 200 else None
                }
        except Exception as e:
            logging.warning(f"Failed to fetch {url}: {e}")
            return {"url": url, "status": None, "error": str(e)}

    def _is_critical(self, url):
        critical_keywords = [".env", "backup", "admin", "config", "sql", "phpinfo"]
        return any(keyword in url.lower() for keyword in critical_keywords)

    def _extract_intel(self, content):
        emails = re.findall(r'[\w\.-]+@[\w\.-]+', content)
        keys = re.findall(r'(?i)(api[_-]?key|auth[_-]?token)=[\w-]{10,}', content)
        return emails, keys

    def _extract_js_endpoints(self, content, base_url):
        endpoints = re.findall(r'[\'"](\/[\w\/\-\.\?=&]+)[\'"]', content)
        return [urljoin(base_url, ep) for ep in endpoints]

    async def scan_web_endpoint(self, path, depth=0):
        url = urljoin(self.config.target, path)
        service = NINJA_SERVICES[0] if self.config.ninja and depth == 0 else None
        result = await self._fetch(url, self.session, service)
        
        # تحليل النتائج
        if result["status"]:
            status_color = "green" if result["status"] == 200 else "red" if result["status"] in [403, 500] else "yellow"
            prefix = "★" if self._is_critical(url) else " "
            print(colored(f"{prefix} {result['status']} {url} (Size: {result['size']}B)", status_color))
            
            self.results["urls"].append(result)
            if result["content"]:
                emails, keys = self._extract_intel(result["content"])
                self.results["intel"].extend(emails)
                self.results["keys"].extend(keys)
                
                if url.endswith((".js", ".json")) and self.config.aggressive:
                    endpoints = self._extract_js_endpoints(result["content"], self.config.target)
                    self.results["js_endpoints"].extend(endpoints)
                
                if self.config.regex:
                    matches = re.findall(self.config.regex, result["content"])
                    self.results["intel"].extend(matches)
                
                if depth < self.config.depth and result["status"] == 200:
                    soup = BeautifulSoup(result["content"], "html.parser")
                    links = [link.get("href") for link in soup.find_all("a") if link.get("href")]
                    tasks = [self.scan_web_endpoint(link.split("?")[0], depth + 1) for link in links if link.startswith("/")]
                    await asyncio.gather(*tasks)

    async def run_web_scan(self, wordlist):
        host = urlparse(self.config.target).hostname
        if not self._is_host_reachable(host):
            raise ValueError("Target host is unreachable")
        
        tasks = [self.scan_web_endpoint(path) for path in wordlist]
        await asyncio.gather(*tasks)
        await self.session.close()

    def scan_ports(self, target):
        cmd = ["nmap", "-F", target] if not self.config.aggressive else ["nmap", "-A", target]
        try:
            result = subprocess.check_output(cmd, text=True)
            ports_info = []
            for line in result.splitlines():
                if re.match(r'^\d+/tcp', line):
                    port, state, service = line.split()[:3]
                    ports_info.append({"port": port, "state": state, "service": service})
                    print(colored(f"Port: {port}, State: {state}, Service: {service}", "cyan"))
            self.results["ports"] = ports_info
        except Exception as e:
            logging.error(f"Port scan failed: {e}")

    def discover_network(self, network):
        try:
            cmd = ["nmap", "-sn", network]
            result = subprocess.check_output(cmd, text=True)
            devices = [{"ip": ip} for ip in re.findall(r'Nmap scan report for (\d+\.\d+\.\d+\.\d+)', result)]
            for device in devices:
                print(colored(f"Device IP: {device['ip']}", "blue"))
            self.results["network"] = devices
        except Exception as e:
            logging.error(f"Network discovery failed: {e}")

    def _is_host_reachable(self, host, port=80):
        try:
            socket.create_connection((host, port), timeout=self.config.timeout)
            return True
        except (socket.timeout, socket.error):
            return False

    def generate_report(self, output_format="txt"):
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        duration = str(timedelta(seconds=(datetime.now() - self.start_time).seconds))
        base_name = f"report_pro_{timestamp}"
        
        if output_format == "json":
            with open(f"{base_name}.json", "w", encoding="utf-8") as f:
                json.dump({"target": self.config.target, "duration": duration, "results": self.results}, f, indent=2)
            print(colored(f"JSON report saved to {base_name}.json", "green"))
        else:
            with open(f"{base_name}.txt", "w", encoding="utf-8") as f:
                f.write(f"Ultimate Scanner Pro Report\nTarget: {self.config.target}\nDuration: {duration}\n\n")
                if self.config.scan_type == "web":
                    f.write("URLs:\n")
                    for r in self.results["urls"]:
                        f.write(f"{r['url']} - Status: {r.get('status', 'N/A')} (Size: {r['size']}B)\n")
                    f.write(f"Intel: {', '.join(self.results['intel'])}\n")
                    f.write(f"Keys: {', '.join(self.results['keys'])}\n")
                    f.write(f"JS Endpoints: {', '.join(self.results['js_endpoints'])}\n")
                elif self.config.scan_type == "ports":
                    f.write("Ports:\n")
                    for r in self.results.get("ports", []):
                        f.write(f"Port: {r['port']}, State: {r['state']}, Service: {r['service']}\n")
                elif self.config.scan_type == "network":
                    f.write("Devices:\n")
                    for r in self.results.get("network", []):
                        f.write(f"Device IP: {r['ip']}\n")
            print(colored(f"Text report saved to {base_name}.txt", "green"))

def check_update():
    try:
        current_version = "4.0.0"
        latest_version = pkg_resources.get_distribution("ultimate-scanner-pro").version
        if current_version != latest_version:
            print(colored(f"Update available: {latest_version} (Current: {current_version})", "yellow"))
            print("Run 'pip install --upgrade ultimate-scanner-pro' to update.")
    except Exception:
        print(colored("Could not check for updates.", "red"))

async def main(args):
    config = ScannerConfig(
        target=args.target,
        threads=args.threads,
        timeout=args.timeout,
        delay=args.delay,
        depth=args.depth,
        scan_type=args.scan_type,
        aggressive=args.aggressive,
        ninja=args.ninja,
        regex=args.regex
    )
    
    scanner = ProScanner(config)
    wordlist = DEFAULT_WORDLIST
    if args.wordlist:
        with open(args.wordlist, "r", encoding="utf-8") as f:
            wordlist = [line.strip() for line in f if line.strip()] + DEFAULT_WORDLIST

    if config.scan_type == "web":
        await scanner.run_web_scan(wordlist)
    elif config.scan_type == "ports":
        scanner.scan_ports(config.target)
    elif config.scan_type == "network":
        scanner.discover_network(config.target)
    
    scanner.generate_report(output_format=args.output)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Ultimate Scanner Pro v4.0.0 - Advanced OSINT Tool")
    parser.add_argument("target", help="Target URL or IP")
    parser.add_argument("-w", "--wordlist", help="Path to custom wordlist file")
    parser.add_argument("-s", "--scan-type", choices=["web", "ports", "network"], default="web", help="Scan type")
    parser.add_argument("-t", "--threads", type=int, default=10, help="Number of threads")
    parser.add_argument("-T", "--timeout", type=int, default=8, help="Request timeout in seconds")
    parser.add_argument("-d", "--delay", type=float, default=0, help="Delay between requests in seconds")
    parser.add_argument("-D", "--depth", type=int, default=2, help="Crawl depth for web scan")
    parser.add_argument("-a", "--aggressive", action="store_true", help="Aggressive scan mode")
    parser.add_argument("-n", "--ninja", action="store_true", help="Ninja mode (use external services)")
    parser.add_argument("-r", "--regex", help="Custom regex pattern for extraction")
    parser.add_argument("-o", "--output", choices=["txt", "json"], default="txt", help="Output format")
    parser.add_argument("--update", action="store_true", help="Check for updates")

    args = parser.parse_args()

    if args.update:
        check_update()
        sys.exit(0)

    asyncio.run(main(args))
