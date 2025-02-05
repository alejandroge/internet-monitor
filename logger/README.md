The main functionality of the monitoring happens in this service.

A ping command is ran every 15 seconds. The exit code of the command is used to determine if the connection is up or down. The result of this is logged in a file, with a timestamp.

Every hour, a ruby script is run, which analyzes the log file, and saves the disconnection events in a sqlite3 database. This script is also responsible for initializing the database, and cleaning up the old logs.
