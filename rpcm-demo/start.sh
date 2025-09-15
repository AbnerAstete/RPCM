#!/bin/bash
# start.sh - Hybrid script for Codespaces and local development

echo "Starting environment setup..."

# First try Codespaces-specific configuration
if [ -n "$CODESPACE_NAME" ] && [ -n "$GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN" ]; then
    echo "☁️  GitHub Codespaces environment detected (method 1)"
    echo "   Codespace: $CODESPACE_NAME"
    echo "   Domain: $GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN"
    
    # For Codespaces, use the full URL with HTTPS
    HOST_IP="https://${CODESPACE_NAME}-8502.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
    echo "🌐 HOST_IP configured for Codespaces: $HOST_IP"
    CODESPACE_MODE=true
    
else
    echo "Using automatic IP detection"
    
    # logic - works locally and in Codespaces without variables
    if command -v python3 &> /dev/null; then
        # Use Python if available
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
        # Fallback using system commands
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
    
    echo "Detected HOST_IP: $HOST_IP"
    
    # Detect if we are in Codespaces even without the variables
    if [ -n "$CODESPACES" ] || [[ "$PWD" == *"codespace"* ]] || [[ "$PWD" == *"/workspaces/"* ]]; then
        echo "☁️  Seems like we are in Codespaces (method 2)"
        CODESPACE_MODE=true
    else
        CODESPACE_MODE=false
    fi
fi

# Create .env file for Docker Compose
echo "HOST_IP=$HOST_IP" > .env
echo ".env file created:"
cat .env

echo ""
echo "Access URLs:"
if [ "$CODESPACE_MODE" = true ] && [ -n "$CODESPACE_NAME" ]; then
    echo " Streamlit: https://${CODESPACE_NAME}-8501.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
    echo " Atlas (direct): https://${CODESPACE_NAME}-21000.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
    echo " Atlas (proxy): ${HOST_IP}"
elif [ "$CODESPACE_MODE" = true ]; then
    echo " Streamlit: Look for port 8501 in the Codespaces 'Ports' tab"
    echo " Atlas (direct): Look for port 21000 in the Codespaces 'Ports' tab"
    echo " Atlas (proxy): Look for port 8502 in the Codespaces 'Ports' tab"
    echo " Or use: http://${HOST_IP}:8502 (if IP detection works)"
else
    echo " Streamlit: http://${HOST_IP}:8501"
    echo " Atlas (direct): http://${HOST_IP}:21000"
    echo " Atlas (proxy): http://${HOST_IP}:8502"
fi

echo ""
echo "Starting Docker Compose..."

# Export the variable and run docker-compose
export HOST_IP
docker-compose up "$@"
