FROM sburn/apache-atlas:2.1.0

# Install necessary dependencies
RUN apt-get update && apt-get install -y netcat-openbsd curl python && apt-get clean

# Copy proxy script
COPY atlas_proxy_clean.py /tmp/atlas_proxy_clean.py

# Copy startup script
COPY start_atlas_with_proxy.sh /opt/start_atlas_with_proxy.sh
RUN chmod +x /opt/start_atlas_with_proxy.sh

# Copy JSON entity files
COPY Entitydefs.json /opt/atlas-data/Entitydefs.json
COPY retail_entities_bulk_atlas.json /opt/atlas-data/retail_entities_bulk_atlas.json
COPY student_entities_bulk_atlas.json /opt/atlas-data/student_entities_bulk_atlas.json

# Create directory if it doesn't exist and set permissions
RUN mkdir -p /opt/atlas-data && \
    chmod 644 /opt/atlas-data/*.json

# Expose ports
EXPOSE 21000 8502

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=120s --retries=3 \
  CMD curl -f http://localhost:21000/api/atlas/admin/version || exit 1

# Default command
CMD ["/opt/start_atlas_with_proxy.sh"]