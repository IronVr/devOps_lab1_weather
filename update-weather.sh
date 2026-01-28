#!/bin/bash

if [ "$1" != "PERM" ]; then
    echo "Ошибка: скрипт должен вызываться с ключом PERM"
    echo "Использование: $0 PERM"
    exit 1
fi

HTML_FILE="/var/www/html/index.nginx-debian.html"

WEATHER_JSON=$(curl -s "wttr.in/Perm?format=j1")
TEMP=$(echo "$WEATHER_JSON" | jq -r '.["current_condition"][0].temp_C')
HUMIDITY=$(echo "$WEATHER_JSON" | jq -r '.["current_condition"][0].humidity')
NOW=$(date "+%Y-%m-%d %H:%M:%S")

cat > "$HTML_FILE" << EOF
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Погода в Перми</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 50px;
            background: #f5f5f5;
        }
        .container {
            display: inline-block;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 { color: #333; margin-bottom: 30px; }
        .data {
            font-size: 24px;
            margin: 10px 0;
        }
        .temp { color: #ff5722; }
        .humidity { color: #2196f3; }
        .time {
            margin-top: 20px;
            color: #666;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Погода в Перми</h1>
        
        <div class="data temp">
            Температура: <strong>${TEMP}°C</strong>
        </div>
        
        <div class="data humidity">
            Влажность: <strong>${HUMIDITY}%</strong>
        </div>
        
        <div class="time">
            Обновлено: ${NOW}
        </div>
    </div>
</body>
</html>
EOF

echo "Погода для Перми обновлена: ${TEMP}°C, влажность ${HUMIDITY}%"