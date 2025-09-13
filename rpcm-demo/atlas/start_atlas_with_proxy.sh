#!/bin/bash

set -e  # Exit on any error

echo "Starting Atlas..."
/opt/apache-atlas-2.1.0/bin/atlas_start.py &
ATLAS_PID=$!

echo "Waiting for Atlas to start..."
# Wait for Atlas to be available with timeout
max_wait=300  # 5 minutes
wait_time=0
while ! curl -s -f -u admin:admin http://localhost:21000/api/atlas/admin/version > /dev/null 2>&1; do
    if [ $wait_time -ge $max_wait ]; then
        echo "ERROR: Atlas failed to start within $max_wait seconds"
        exit 1
    fi
    echo "Waiting for Atlas... ($wait_time/$max_wait seconds)"
    sleep 10
    wait_time=$((wait_time + 10))
done

echo "Atlas is running. Loading entity definitions..."
# Retry mechanism for loading definitions
max_retries=3
retry_count=0

while [ $retry_count -lt $max_retries ]; do
    if curl -u admin:admin -X POST -H "Content-Type: application/json" \
       -d @/opt/atlas-data/Entitydefs.json \
       http://localhost:21000/api/atlas/v2/types/typedefs; then
        echo "Entity definitions loaded successfully"
        break
    else
        retry_count=$((retry_count + 1))
        echo "Failed to load entity definitions. Retry $retry_count/$max_retries"
        sleep 5
    fi
done

if [ $retry_count -eq $max_retries ]; then
    echo "ERROR: Failed to load entity definitions after $max_retries attempts"
    exit 1
fi

echo "Loading retail entities..."
retry_count=0
while [ $retry_count -lt $max_retries ]; do
    if curl -u admin:admin -X POST -H "Content-Type: application/json" \
       -d @/opt/atlas-data/retail_entities_bulk_atlas.json \
       http://localhost:21000/api/atlas/v2/entity/bulk; then
        echo "Retail entities loaded successfully"
        break
    else
        retry_count=$((retry_count + 1))
        echo "Failed to load retail entities. Retry $retry_count/$max_retries"
        sleep 5
    fi
done

echo "Loading student entities..."
retry_count=0
while [ $retry_count -lt $max_retries ]; do
    if curl -u admin:admin -X POST -H "Content-Type: application/json" \
       -d @/opt/atlas-data/student_entities_bulk_atlas.json \
       http://localhost:21000/api/atlas/v2/entity/bulk; then
        echo "Student entities loaded successfully"
        break
    else
        retry_count=$((retry_count + 1))
        echo "Failed to load student entities. Retry $retry_count/$max_retries"
        sleep 5
    fi
done

echo "Starting proxy..."
python /tmp/atlas_proxy_clean.py &
PROXY_PID=$!

echo "Setup complete!"
echo "Atlas available at:"
echo "  - Direct access: http://localhost:21000 (admin/admin)"
echo "  - Proxy access:  http://localhost:8502"
echo ""
echo "Container is ready for use."

# Function to handle shutdown
cleanup() {
    echo "Shutting down services..."
    kill $PROXY_PID 2>/dev/null || true
    kill $ATLAS_PID 2>/dev/null || true
    exit 0
}

# Trap signals for clean shutdown
trap cleanup SIGTERM SIGINT

# Wait for processes
wait