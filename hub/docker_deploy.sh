single_domain=$1

# Create database
docker-compose -f docker-compose-db.yml up -d

docker pull rhe89/hub-crypto-service-bus-queue-host:latest
docker pull rhe89/hub-crypto-scheduled-host:latest
docker pull rhe89/hub-crypto-api:latest
docker pull rhe89/hub-banking-service-bus-queue-host:latest
docker pull rhe89/hub-banking-scheduled-host:latest
docker pull rhe89/hub-banking-api:latest
docker pull rhe89/hub-banking-app:latest
docker pull rhe89/hub-spreadsheet-service-bus-queue-host:latest
docker pull rhe89/hub-spreadsheet-api:latest
docker pull rhe89/hub-spreadsheet-webapp:latest

# If no domain is specified, deploy all
if [ -z "$single_domain" ];
then
    docker-compose -f docker-compose.yml -f "docker-compose-banking.yml" up -d
    docker-compose -f docker-compose.yml -f "docker-compose-spreadsheet.yml" up -d
    docker-compose -f docker-compose.yml -f "docker-compose-crypto.yml" up -d
else 
    # Deploy single domain
    docker-compose -f docker-compose.yml -f "docker-compose-$single_domain.yml" up -d
fi
