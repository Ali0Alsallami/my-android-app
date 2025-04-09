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
clear
pkg update && pkg upgrade -y
pkg install git python nodejs php apache2 mariadb -y
pip install flask
pkg install wget
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip
unzip ngrok-stable-linux-arm.zip
./ngrok authtoken YOUR_AUTH_TOKEN  # الحصول على التوكن من موقع ngrok.com
unzip ngrok-stable-linux-arm.zip
python -m http.server 8000 &  # تشغيل الخادم في الخلفية
./ngrok http 8000
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/username/repo.git
git push -u origin main
mkdir ali-cv-website
cd ali-cv-website
nano index.html
nano styles.css
git init
git add .
git commit -m "سيرة ذاتية لعلي محمد أحمد"
git remote add origin https://github.com/username/ali-cv-website.git
git remote add origin https://github.com/Ali0Alsallami/ali-cv-website.git
git push -u origin main
git status
git push -u origin master
Ali0Alsallami
git remote -v
git remote set-url origin https://github.com/Ali0Alsallami/ali-cv-website.git
git push -u origin master
https://github.com/Ali0Alsallami/ali-cv-website
ls -l
cat index.html
it clone https://github.com/Ali0Alsallami/Ali0Alsallami.github.io.git
cd Ali0Alsallami.github.io
cp ../ali-cv-website/* .
git add .
git commit -m "نقل الموقع إلى المستودع الجديد"
git push -u origin master
cdcd ~
git remote -v
git remote set-url origin https://github.com/Ali0Alsallami/CV.git
git remote -v
nano index.html
nano styles.css
git remote set-url origin https://github.com/Ali0Alsallami/CV.git
git add .
git commit -m "Updated CV to English version"
git push -u origin master
pwd
cd /storage/emulated/0/Download
cd PIC
file PIC
cp PIC.jpg ~/ali-cv-website/profile.jpg
cd ~/ali-cv-website
nano index.html
nano styles.css
git add .
git commit -m "Added profile picture to CV"
git push -u origin master
cd ~/ali-cv-website
nano index.html
nano styles.css
git add .
git commit -m "Updated CV with new details and restored profile picture size to 150x150"
git push -u origin master
nano index.html
nano styles.css
git add .
git commit -m "Enhanced CV with new features and design improvements"
git push -u origin master
nano index.html
nano styles.css
cd ~/ali-cv-website
nano styles.css
git add .
git commit -m "Enhanced CV with new features and design improvements"
git push -u origin master
cp /sdcard/Download/cv.pdf .
cp /storage/emulated/0/Download/cv.pdf .
cp /storage/emulated/0/Download/cv.pdf
cp /storage/emulated/0/Download/cv.pdf .
ls /sdcard/Download/
cp /sdcard/Download/cv.pdf .
<a href="cv.pdf" download class="download-btn">Download My CV</a>
nano index.html
git add .
git commit -m "Added Ali_CV.pdf for download and updated download link"
git commit -m "Added cv.pdf for download and updated download link"
nano index.html
git add .
git commit -m "Added cv.pdf for download and updated download link"
git push -u origin master
nano index.html
nano styles.css
nano script.js
git add .
git commit -m "Enhanced CV with improved design, content, and features"
git push -u origin master
nano index.html
