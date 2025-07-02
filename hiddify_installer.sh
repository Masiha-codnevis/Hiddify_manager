#!/bin/bash

# این اسکریپت برای نصب Hiddify-Manager روی یک سرور مجازی لینوکس (معمولاً Ubuntu/Debian) طراحی شده است.
# این اسکریپت پیش‌نیازها را نصب کرده و Hiddify-Manager را راه‌اندازی می‌کند.
# قبل از اجرا، مطمئن شوید که دسترسی root دارید یا با 'sudo' اجرا می‌کنید.

echo "---"
echo "شروع نصب پیش‌نیازها و به‌روزرسانی سیستم..."

# به‌روزرسانی لیست پکیج‌ها و نصب curl و git
apt update -y
apt upgrade -y
apt install -y curl git apt-transport-https ca-certificates lsb-release

echo "---"
echo "نصب Docker و Docker Compose..."

# اضافه کردن کلید GPG رسمی Docker
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# اضافه کردن مخزن Docker به لیست سورس‌ها
echo \
  "deb [arch=\"$(dpkg --print-architecture)\" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  \"$(. /etc/os-release && echo \"$VERSION_CODENAME\")\" stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

# به‌روزرسانی دوباره لیست پکیج‌ها و نصب Docker Engine, containerd و Docker Compose
apt update -y
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "---"
echo "دانلود و راه‌اندازی Hiddify-Manager..."

# کلون کردن مخزن Hiddify-Manager
if [ -d "/opt/hiddify-manager" ]; then
    echo "پوشه Hiddify-Manager از قبل موجود است، به‌روزرسانی می‌شود..."
    cd /opt/hiddify-manager
    git pull
else
    echo "کلون کردن مخزن Hiddify-Manager به /opt/hiddify-manager..."
    git clone https://github.com/hiddify/Hiddify-Manager.git /opt/hiddify-manager
    cd /opt/hiddify-manager
fi

# اجرای اسکریپت نصب Hiddify-Manager
# این اسکریپت پیکربندی نهایی و راه‌اندازی سرویس‌ها را انجام می‌دهد.
bash install.sh

echo "---"
echo "نصب Hiddify-Manager بر روی سرور مجازی تکمیل شد."
echo "لطفاً خروجی اسکریپت بالا را برای دسترسی به پنل مدیریت دنبال کنید."
echo "---"

