# postgresql_auto_backup

Batch file to automatically run a postgresql pg_basebackup through either Windows Task Scheduler or through PGAdminIII

Included are the batch script batch_postgres_backup_v11 and the postgres login/password details configuration file pgpass.conf

The batch script automatically runs the pg_basebackup function in Postgres (later than 9.2) and creates a date_stamped folder in C:\pgbackup\data where the batabase dump is stored.

The directories should be changed as appropriate to ensure that they are pointing to the bin folder in Postgres, the WAL archive location and the directories where the user wishes the backups to be stored.

Also included is a template recovery.conf file to be used to restore the server.

 I hope this is useful to those trying to do this from scratch. Took several days to combine all sources to get this right and automated
