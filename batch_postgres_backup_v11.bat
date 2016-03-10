SET PGPASSFILE=C:\pgbackupscripts\pgpass.conf

 FOR /f "tokens=1-3 delims=/ " %%i IN ("%date%") DO (

 SET day=%%i
 SET month=%%j
 SET year=%%k
 )

 SET datestr=%day%_%month%_%year%

 REM Dynamically sets the date variable so that folders and files can have a date identifier

 SET WAL_ARCHIVE_DIR=C:\pgbackup\wal_logs

 REM Setting the WAL archive directory for deletion operations

 SET DEST_DIRECTORY_NAME=C:\pgbackup\data\backup_%datestr%

 REM Setting the backup destination directory, this is where all backup data will be stored

 SET BASE_DIRECTORY_PATH=/pgbackup/data/backup_%datestr%

 REM Destination path has to be written with forward slashes for pg_basebackup command

 SET DIRECTORY_NAME=C:\pgbackup\data

 REM Setting the base directory name so that files older than 2 days can be deleted

 MKDIR %DEST_DIRECTORY_NAME%

 REM Creating the dynamic directory for the backup to be placed in

"C:\PostgreSQL94\bin\pg_basebackup.exe"  --xlog --format=t -Z 6 -R -U backupscripts -D %BASE_DIRECTORY_PATH%

 REM Running postgres pg_basebackup function to take a data dump of all tables, --xlog specifies to include all non-flushed WAL logs and is required for directory pathing. 
 REM The output format is set to .tar which can then be compressed using Zip to compression level 6. User is backupscripts and directory is set as BASE_DIRECTORY_PATH

forfiles /P "%DIRECTORY_NAME%" /S /D -2 /C "cmd /c IF @ISDIR == TRUE rd /S /Q @path" 

 REM This recursively deletes any backup folder that is older than 2 days

forfiles /D -2 /P "%WAL_ARCHIVE_DIR%" /C "cmd /c del @path"

 REM This deletes all WAL logs and history/backup files that are older than 2 days