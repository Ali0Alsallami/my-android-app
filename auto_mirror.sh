#!/data/data/com.termux/files/usr/bin/bash

# ----------------------------------------------------
# سكريبت اختيار أسرع مرآة تلقائيًا لـ Termux
# إصدار: 2.0
# الرخصة: MIT
# ----------------------------------------------------

# قائمة المرايا المعتمدة (يمكنك إضافة/حذف أي مرايا)
MIRRORS=(
    "https://grimler.se/termux-packages-24"
    "https://packages.termux.org/apt/termux-main"
    "https://mirrors.tuna.tsinghua.edu.cn/termux"
    "https://termux.mirror.lzy.li/apt"
    "https://mirror.mwt.me/termux"
)

# دالة تحديد أسرع مرآة
select_fastest_mirror() {
    echo -e "\033[1;34m[●] جاري البحث عن أسرع مرآة...\033[0m"
    
    # قياس سرعة المرايا باستخدام netselect
    FASTEST_URL=$(netselect -s1 -t20 "${MIRRORS[@]}" 2>/dev/null | awk '{print $2}')
    
    if [[ -z "$FASTEST_URL" ]]; then
        echo -e "\033[1;31m[✗] فشل في تحديد المرآة، استخدام الإفتراضي.\033[0m"
        FASTEST_URL="https://packages.termux.org/apt/termux-main"
    fi
    
    echo -e "\033[1;32m[✓] تم اختيار المرآة: $FASTEST_URL\033[0m"
    
    # تحديث ملف sources.list
    echo "deb $FASTEST_URL stable main" > $PREFIX/etc/apt/sources.list
}

# دالة التحديث الآمن
safe_update() {
    echo -e "\033[1;36m[●] جاري تحديث قائمة الحزم...\033[0m"
    apt update -o Acquire::http::No-Cache=True 2>&1 | grep -v "Unable to locate"
}

# الإجراء الرئيسي
main() {
    select_fastest_mirror
    safe_update
}

# بدء التنفيذ
main
