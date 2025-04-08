clear
cd depian
clear
./start-debian.sh
proot-distro login debian
pkg install fping
pkg install hping3
pkg search fping
pkg install hping3
nano $PREFIX/etc/apt/sources.list
pkg update
deb https://mirror.termux.com/apt/termux-main stable main
pkg update
pkg install fping
pkg search fping
clear
pkg install fping
pkg install ping
pkg install netcat
pkg install tcpdump
pkg install hping3
pkg install traceroute
traceroute 10.10.26.53  # تتبع المسار إلى جهاز معين
pkg install ettercap
nmap -sn 10.10.26.0/24  # يقوم بالمسح لجميع الأجهزة ضمن نفس الشبكة
traceroute 10.10.26.1
nmap 10.10.26.1
dig @10.10.26.1 google.com
pkg install dnsutils
dig @10.10.26.1 google.com
nslookup google.com 10.10.26.1
host google.com 10.10.26.1
pkg update
pkg upgrade
host google.com 10.10.26.1
curl http://10.10.26.1
telnet 10.10.26.1
pkg install telnet
pkg install x11-repo
wine winbox.exe
pkg install openssh
ssh admin@10.10.26.1
/ip service print
pkg install telnet
./start-debian.sh
proot-distro login debian
pkg install x11-repo
pkg install wine
wine winbox.exe
/ip service enable ssh
clear
pkg update && pkg upgrade
pkg install proot-distro
proot-distro install kali
proot-distro list
pkg update && pkg upgrade -y
pkg install wget
wget -O install-nethunter-termux https://offs.ec/2MceZWr
chmod +x install-nethunter-termux
./install-nethunter-termux
pkg install wget -y
wget -O install-nethunter-termux https://offs.ec/2MceZWr
chmod +x install-nethunter-termux
./install-nethunter-termux
clear
./install-nethunter-termux
٠٠٠٠
./install-nethunter-termux
cli
CLI
clear
nethunter -r
nethunter kex passwd
nh
exit
clear
nh
exit
clear
cd kali
pkg update && pkg upgrade -y
pkg install tcpdump tshark nmap termux-api -y
pkg update && pkg upgrade -y
pkg install tcpdump tshark nmap termux-api -y
ip addr show
tcpdump -i wlan0 -s 0 -w capture.pcap
nano fix_packages.sh
chmod +x fix_packages.sh
./fix_packages.sh
nano fix_packages.sh
chmod +x fix_packages.sh
./fix_packages.sh
ps aux
bash -x ./fix_packages.sh
nano fix_packages.sh
chmod +x fix_packages.sh
./fix_packages.sh
nano fix_packages.sh
chmod +x fix_packages.sh
./fix_packages.sh
bash -x ./fix_packages.sh > output.txt 2>&1
cat output.txt
bash -x ./fix_packages.sh > output.txt 2>&1
cat output.txt
bash -x ./fix_packages.sh > output.txt 2>&1
# التحديثات الأساسية
pkg update -y && pkg upgrade -y
pkg install wget proot -y
# تنزيل سكربت التثبيت
wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Installer/Kali/kali.sh -O kali.sh
# تشغيل السكربت
bash kali.sh
./start-kali.sh
pkg update -y && pkg install wget curl proot tar -y && wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Installer/Kali/kali-xfce.sh -O kali-xfce.sh && chmod +x kali-xfce.sh && bash kali-xfce.sh 
pkg update -y && pkg upgrade -y
