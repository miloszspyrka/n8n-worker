# Use the n8n image as the base
FROM docker.n8n.io/n8nio/n8n

# Switch to root to install packages
USER root

# Install Python and pip using Alpine's apk
RUN apk add --no-cache python3 py3-pip

# Install external Python packages
RUN pip3 install requests

# Switch back to n8n user
USER node

# Set required build args and environment variables
ARG PGPASSWORD
ARG PGHOST
ARG PGPORT
ARG PGDATABASE
ARG PGUSER

ENV DB_TYPE=postgresdb
ENV DB_POSTGRESDB_DATABASE=$PGDATABASE
ENV DB_POSTGRESDB_HOST=$PGHOST
ENV DB_POSTGRESDB_PORT=$PGPORT
ENV DB_POSTGRESDB_USER=$PGUSER
ENV DB_POSTGRESDB_PASSWORD=$PGPASSWORD
ENV N8N_LOG_LEVEL=debug
ENV N8N_ENCRYPTION_KEY=W0rAjnjtd6

# Start n8n in worker mode
CMD ["n8n", "worker"]
