#!/bin/bash
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
mysqldump --databases monsite_db -u monsite_user -pStr0ngPass! > /var/backups/monsite_db_${DATE}.sql
if [ $? -eq 0 ]; then
    echo "✅ Backup successful!"
    echo "📅 Date: $DATE"
else
    echo "❌ Backup failed!"
    echo "📅 Date: $DATE"
fi

