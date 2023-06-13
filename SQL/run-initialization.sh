sleep 10s;
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"


/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P <YOUR_PASSWORD_HERE> -d master -i setup.sql
