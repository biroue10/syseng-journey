#!/bin/bash
  THRESHOLD=80

  df -h | grep -v tmpfs | tail -n +2 | while read line; do
      # extraire le pourcentage avec awk (c'est la 5ème colonne, sans le %)
      USAGE=$(echo "$line" | awk '{print $5}' | tr -d '%')
      PARTITION=$(echo "$line" | awk '{print $6}')

      # comparer USAGE au THRESHOLD avec if
       if [ "$USAGE" -ge "$THRESHOLD" ]; then
        echo "⚠️ ALERT: $PARTITION is at ${USAGE}% (threshold: ${THRESHOLD}%)"
       fi
      # afficher une alerte si dépassé
  done
