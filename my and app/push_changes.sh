#!/data/data/com.termux/files/usr/bin/bash

# إضافة جميع التغييرات (بما في ذلك الملفات المعدلة والجديدة)
git add .

# التحقق من وجود تغييرات ليتم الـ Commit
if git status | grep -q "Changes to be committed"; then
    # طلب رسالة الـ Commit من المستخدم
    echo "أدخل رسالة الـ Commit:"
    read commit_message

    # إذا لم يتم إدخال رسالة، استخدم رسالة افتراضية
    if [ -z "$commit_message" ]; then
        commit_message="Update project files"
    fi

    # إنشاء Commit مع الرسالة
    git commit -m "$commit_message"
    
    # رفع التغييرات إلى GitHub
    git push
else
    echo "لا توجد تغييرات ليتم رفعها."
    git status
fi
