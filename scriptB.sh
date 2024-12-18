#!/bin/bash

URL="http://localhost"

# Асинхронні HTTP-запити
while true; do
    delay=$((RANDOM % 6 + 5)) # Випадкова затримка 5-10 секунд
    (curl -s -o /dev/null -w "Request to $URL returned status %{http_code}\n" $URL) &
    echo "Next request in $delay seconds..."
    sleep $delay
done