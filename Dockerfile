FROM docker.n8n.io/n8nio/n8n

USER root

# Zainstaluj Pythona i pip z Alpine
RUN apk add --no-cache python3 py3-pip

# Zainstaluj requests z obejściem PEP 668
RUN pip3 install --break-system-packages requests

USER node

# Twoje zmienne środowiskowe i uruchomienie
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

CMD ["n8n", "worker"]
