single_domain=$1

# Create database
docker-compose -f docker-compose-db.yml up -d

docker pull rhe89/hub-coinbase-pro-service-bus-queue-host:latest
docker pull rhe89/hub-coinbase-pro-scheduled-host:latest
docker pull rhe89/hub-coinbase-pro-api:latest
docker pull rhe89/hub-coinbase-service-bus-queue-host:latest
docker pull rhe89/hub-coinbase-scheduled-host:latest
docker pull rhe89/hub-coinbase-api:latest
docker pull rhe89/hub-sbanken-service-bus-queue-host:latest
docker pull rhe89/hub-sbanken-scheduled-host:latest
docker pull rhe89/hub-sbanken-api:latest
docker pull rhe89/hub-sbanken-app:latest
docker pull rhe89/hub-spreadsheet-service-bus-queue-host:latest
docker pull rhe89/hub-spreadsheet-api:latest
docker pull rhe89/hub-admin-web:latest
docker pull rhe89/hub-dashboard-web:latest

# If no domain is specified, deploy all
if [ -z "$single_domain" ];
then
    docker-compose -f docker-compose.yml -f "docker-compose-admin.yml" up -d
    docker-compose -f docker-compose.yml -f "docker-compose-sbanken.yml" up -d
    docker-compose -f docker-compose.yml -f "docker-compose-coinbase.yml" up -d
    docker-compose -f docker-compose.yml -f "docker-compose-dashboard.yml" up -d
    docker-compose -f docker-compose.yml -f "spreadsheet/docker-compose.yml" up -d
    docker-compose -f docker-compose.yml -f "docker-compose-coinbase-pro.yml" up -d
else 
    # Deploy single domain
    docker-compose -f docker-compose.yml -f "/docker-compose-$single_domain.yml" up -d
fi
