SET PGPASSFILE=C:\Database\BackupScripts\scripts\pgpass.conf

 FOR /f "tokens=1-3 delims=/ " %%i IN ("%date%") DO (

 SET day=%%i
 SET month=%%j
 SET year=%%k
 )

 SET datestr=%day%_%month%_%year%
 ECHO datestr is %datestr%

 SET FILE_NAME=C:\Database\Backup\Globals\global_stuff_%datestr%.out

"C:\Program Files (x86)\PostgreSQL\9.5\bin\pg_dumpall.exe" -U postgres -g  > %FILE_NAME%

forfiles -p "C:\Database\Backup\Globals" -s -m *.* /D -8 /C "cmd /c del @path"
