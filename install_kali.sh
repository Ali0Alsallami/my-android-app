#!/bin/bash

# إعدادات الألوان
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
NC="\033[0m"

echo -e "${GREEN}بدء التثبيت...${NC}"

# تحديث وتثبيت المتطلبات
pkg update -y
pkg install proot wget tar xz-utils -y || {
    echo -e "${RED}[خطأ] فشل في تثبيت الحزم المطلوبة!${NC}"
    exit 1
}

# تنزيل ملف rootfs
echo -e "${BLUE}• جاري التنزيل...${NC}"
wget "https://kali.download/nethunter-images/rolling/current/rootfs/kalifs-arm64-minimal.tar.xz" -O kali-rootfs.tar.xz || {
    echo -e "${RED}[خطأ] فشل التنزيل! تأكد من الاتصال بالإنترنت.${NC}"
    exit 1
}

# فك الضغط
echo -e "${BLUE}• فك الضغط...${NC}"
mkdir -p kali-fs
tar -xJf kali-rootfs.tar.xz -C kali-fs --exclude='dev/*' --exclude='proc/*' || {
    echo -e "${RED}[خطأ] فشل فك الضغط! الملف قد يكون تالفًا.${NC}"
    exit 1
}

# التهيئة النهائية
echo -e "${GREEN}✅ تم التثبيت بنجاح!${NC}"
echo -e "${YELLOW}للتشغيل:${NC}\nproot -r kali-fs -w /root /bin/bash"
