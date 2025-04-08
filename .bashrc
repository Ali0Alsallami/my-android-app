# ---------- تفعيل اختيار المرآة التلقائي ----------
pkg() {
}
# --------------------------------------------------./test_mirrors.sh && mv /data/data/com.termux/files/home/sources.list /data/data/com.termux/files/usr/etc/apt/sources.list
./test_mirrors.sh && pkg update
alias pkg-install='./test_mirrors.sh && pkg update && pkg install'
