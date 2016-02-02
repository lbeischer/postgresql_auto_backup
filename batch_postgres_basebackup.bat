SET PGPASSFILE=C:\Database\BackupScripts\scripts\pgpass.conf

 FOR /f "tokens=1-3 delims=/ " %%i IN ("%date%") DO (

 SET day=%%i
 SET month=%%j
 SET year=%%k
 )

 SET datestr=%day%_%month%_%year%
 ECHO datestr is %datestr%

 SET FILE_NAME=C:\Database\Backup\Data\data_backup_%datestr%.tar.gz

"C:\Program Files (x86)\PostgreSQL\9.5\bin\pg_basebackup.exe" -D - -Ft -z -U postgres > %FILE_NAME%

forfiles -p "C:\Database\Backup\Data" -s -m *.* /D -2 /C "cmd /c del @path"
