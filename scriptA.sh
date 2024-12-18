#!/bin/bash

start_container() {
    if sudo docker ps -a --format "{{.Names}}" | grep -q "^$1$"; then
        echo "Контейнер $1 вже існує. Видаляю його..."
        sudo docker rm -f "$1"
    fi
    echo "Запускаю контейнер $1 на CPU ядрі #$2"
    sudo docker run --name "$1" --cpuset-cpus="$2" --network bridge -d rovniy0/program
}

stop_container() {
    echo "Зупинка контейнера $1"
    sudo docker kill "$1" && sudo docker rm "$1"
}

check_cpu_load() {
    sudo docker stats --no-stream --format "{{.Name}} {{.CPUPerc}}" | grep "$1" | awk '{print $2}' | sed 's/%//'
}

assign_cpu_core() {
    case $1 in
        srv1) echo "0" ;;
        srv2) echo "1" ;;
        srv3) echo "2" ;;
        *) echo "0" ;;
    esac
}

refresh_containers() {
    echo "Перевірка оновлення образу..."
    pull_result=$(sudo docker pull rovniy0/program | grep "Downloaded newer image")
    if [ -n "$pull_result" ]; then
        echo "Доступний новий образ. Оновлюю контейнери..."
        for container in srv1 srv2 srv3; do
            if sudo docker ps --format "{{.Names}}" | grep -q "^$container$"; then
                echo "Оновлення $container..."
                new_container="${container}_new"
                start_container "$new_container" "$(assign_cpu_core "$container")"
                stop_container "$container"
                sudo docker rename "$new_container" "$container"
                echo "$container оновлено."
            fi
        done
    else
        echo "Новий образ відсутній."
    fi
}

monitor_containers() {
    while true; do
        if sudo docker ps --format "{{.Names}}" | grep -q "srv1"; then
            cpu_srv1=$(check_cpu_load "srv1")
            if (( $(echo "$cpu_srv1 > 30.0" | bc -l) )); then
                echo "srv1 перевантажений. Запуск srv2..."
                if ! sudo docker ps --format "{{.Names}}" | grep -q "srv2"; then
                    start_container "srv2" 1
                fi
            fi
        else
            start_container "srv1" 0
        fi

        if sudo docker ps --format "{{.Names}}" | grep -q "srv2"; then
            cpu_srv2=$(check_cpu_load "srv2")
            if (( $(echo "$cpu_srv2 > 30.0" | bc -l) )); then
                echo "srv2 перевантажений. Запуск srv3..."
                if ! sudo docker ps --format "{{.Names}}" | grep -q "srv3"; then
                    start_container "srv3" 2
                fi
            fi
        fi

        for container in srv3 srv2; do
            if sudo docker ps --format "{{.Names}}" | grep -q "$container"; then
                cpu=$(check_cpu_load "$container")
                if (( $(echo "$cpu < 1.0" | bc -l) )); then
                    echo "$container простоює. Зупинка..."
                    stop_container "$container"
                fi
            fi
        done

        refresh_containers
        sleep 120
    done
}

monitor_containers
