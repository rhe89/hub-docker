password=$1;

backup_dir=$(date +'%d-%m-%Y_%H-%M-%S')
mkdir "./backups/$backup_dir"

databases=("coinbase_db" "binance_db" "coinbase_pro_db" "sbanken_db" "spreadsheet_db" "dashboard_db")

sudo docker exec hub_db mkdir "/var/opt/mssql/backup/"$backup_dir"/"

for database in ${databases[@]}; do
    sudo docker exec -it hub_db /opt/mssql-tools/bin/sqlcmd \
    -S localhost -U SA -P $password \
    -Q "BACKUP DATABASE [$database] TO DISK = N'/var/opt/mssql/backup/"$backup_dir"/$database.bak' WITH NOFORMAT, NOINIT, NAME = '$database-full', SKIP, NOREWIND, NOUNLOAD, STATS = 10"

    sudo docker cp hub_db:/var/opt/mssql/backup/"$backup_dir"/$database.bak "./backups/$backup_dir"/$database.bak
done