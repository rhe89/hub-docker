backup_dir=$(ls -td * | head -1)

sudo docker cp $backup_dir/coinbase_db.bak hub_db:/var/opt/mssql/backup/coinbase_db.bak 
sudo docker cp $backup_dir/sbanken_db.bak hub_db:/var/opt/mssql/backup/sbanken_db.bak 
sudo docker cp $backup_dir/spreadsheet_db.bak hub_db:/var/opt/mssql/backup/spreadsheet_db.bak 
sudo docker cp $backup_dir/dashboard_db.bak hub_db:/var/opt/mssql/backup/dashboard_db.bak 
