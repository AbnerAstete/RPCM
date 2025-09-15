#!/bin/bash

# Detectar la IP de la máquina host automáticamente
if command -v python3 &> /dev/null; then
    # Usar Python si está disponible
    HOST_IP=$(python3 -c "
import socket
def get_local_ip():
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(('8.8.8.8', 80))
        ip = s.getsockname()[0]
        s.close()
        return ip
    except:
        return 'localhost'
print(get_local_ip())
")
else
    # Fallback usando comandos del sistema
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        HOST_IP=$(ip route get 1 | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' | head -1)
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        HOST_IP=$(ifconfig | grep "inet " | grep -v 127.0.0.1 | head -1 | awk '{print $2}')
    else
        HOST_IP="localhost"
    fi
fi

echo "🌐 Detected HOST_IP: $HOST_IP"

# Exportar la variable y ejecutar docker-compose
export HOST_IP
docker-compose up "$@"