#!/bin/bash

CRON_FILE="/etc/cron.d/test_cron"
RUNTIME_FILE="/tmp/runtime.txt"

if [[ $EUID -ne 0 ]]; then
    echo "Запустите с sudo"
    exit 1
fi


rm -f "$CRON_FILE"


cat > "$CRON_FILE" << 'EOF'

SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

*/5 * * * * root /bin/date >> /tmp/runtime.txt

EOF


chmod 644 "$CRON_FILE"
chown root:root "$CRON_FILE"


systemctl restart cron


/bin/date >> "$RUNTIME_FILE"

echo "Готово"
