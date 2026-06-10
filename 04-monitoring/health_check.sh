#!/bin/bash
SERVICE="mariadb"
SERVICE2="nginx"
EXIT_CODE=0
if systemctl is-active --quiet "$SERVICE"; then
    echo "✅ Le service $SERVICE est EN COURS D'EXÉCUTION"
 
else
    echo "❌ Le service $SERVICE EST ARRÊTÉ"
    EXIT_CODE=1
fi

if systemctl is-active --quiet "$SERVICE2"; then
    echo "✅ Le service $SERVICE2 est EN COURS D'EXÉCUTION"
   
else
    echo "❌ Le service $SERVICE2 EST ARRÊTÉ"
    EXIT_CODE=1
fi
exit $EXIT_CODE
