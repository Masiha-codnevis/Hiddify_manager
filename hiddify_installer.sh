#!/data/data/com.termux/files/usr/bin/bash

# این اسکریپت برای دانلود و نصب اسکریپت اصلی Hiddify-Manager در Termux طراحی شده است.
# پس از اجرای این اسکریپت، مراحل پیکربندی نهایی توسط اسکریپت Hiddify-Manager انجام می‌شود.

echo "---"
echo "شروع نصب پیش‌نیازها..."
pkg update -y
pkg upgrade -y
pkg install -y git curl apt-transport-https ca-certificates lsb-release

echo "---"
echo "نصب Docker (در صورت نیاز و امکان‌پذیر بودن در Termux - این بخش ممکن است در برخی دستگاه‌ها کار نکند)"
# Termux به صورت native از Docker پشتیبانی نمی‌کند. این بخش صرفاً یک تلاش است و ممکن است ناموفق باشد.
# Hiddify-Manager برای اجرا به Docker نیاز دارد که در Termux به صورت مستقیم قابل نصب نیست.
# این اسکریپت فرض می‌کند که شما محیطی شبیه به لینوکس کامل برای Docker فراهم کرده‌اید،
# یا قصد دارید Hiddify-Manager را در یک سرور واقعی اجرا کنید و صرفاً از Termux برای شروع استفاده می‌کنید.

# اگر Termux را برای این منظور استفاده می‌کنید، نیاز به یک سرور لینوکس واقعی دارید
# که بتوانید Hiddify-Manager را روی آن نصب کنید و سپس از طریق Termux آن را مدیریت کنید.

# این بخش برای یک سیستم عامل لینوکس کامل است، نه Termux.
# curl -fsSL https://get.docker.com -o get-docker.sh
# sh get-docker.sh
# usermod -aG docker $(whoami)

echo "---"
echo "دانلود اسکریپت Hiddify-Manager..."
# فرض بر این است که مخزن Hiddify-Manager وجود دارد و قابل کلون کردن است.
# این اسکریپت Hiddify-Manager را کلون می‌کند.
if [ -d "Hiddify-Manager" ]; then
    echo "پوشه Hiddify-Manager از قبل موجود است، به‌روزرسانی می‌شود..."
    cd Hiddify-Manager
    git pull
else
    echo "کلون کردن مخزن Hiddify-Manager..."
    git clone https://github.com/hiddify/Hiddify-Manager.git # آدرس دقیق مخزن ممکن است تغییر کند
    cd Hiddify-Manager
fi

echo "---"
echo "آماده‌سازی و اجرای اسکریپت Hiddify-Manager..."
# اجرای اسکریپت نصب Hiddify-Manager.
# توجه: این اسکریپت نیاز به دسترسی root و Docker دارد که در Termux به صورت پیش‌فرض فراهم نیست.
# شما باید این اسکریپت را روی یک سرور لینوکس با دسترسی root و Docker نصب شده اجرا کنید.
# دستورات زیر برای اجرای اسکریپت Hiddify-Manager روی یک سیستم لینوکس استاندارد هستند.
bash install.sh

echo "---"
echo "نصب Hiddify-Manager تکمیل شد. برای پیکربندی بیشتر به دستورالعمل‌های Hiddify مراجعه کنید."
echo "توجه: این نصب برای اجرای کامل نیاز به یک محیط سرور لینوکس واقعی با Docker دارد و Termux تنها برای شروع فرآیند استفاده شده است."
echo "---"

