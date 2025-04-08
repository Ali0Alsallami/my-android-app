#!/bin/bash

# ------ إعدادات الألوان ------
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
NC="\033[0m"

# ------ إنشاء المحتوى التلقائي ------
cat << EOF > install_kali.sh
#!/bin/bash
echo -e "\${GREEN}بدء التثبيت...\${NC}"
pkg update -y && pkg install proot wget tar -y
wget https://kali.download/nethunter-images/current/rootfs/kalifs-arm64-minimal.tar.xz -O kali-rootfs.tar.xz
mkdir kali-fs
tar -xJf kali-rootfs.tar.xz -C kali-fs --exclude=dev
echo -e "\${GREEN}تم التثبيت بنجاح!\${NC}"
echo -e "\${YELLOW}للتشغيل:\${NC} proot -r kali-fs -w /root /bin/bash"
EOF

# ------ جعله قابل للتنفيذ ------
chmod +x install_kali.sh

# ------ التشغيل التلقائي ------
./install_kali.sh
