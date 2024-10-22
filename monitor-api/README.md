### Run the rails server

Copy the service over to the appropiate folder
```sh
cp monitor-api.service /lib/systemd/system/
```

```sh
systemctl start monitor-api.service
systemctl stop monitor-api.service
systemctl status monitor-api.service
```

* System dependencies
Expects the database to be populated by an external script

* Database creation
Expects a `production.sqlite3` database to exists, that has the expected schema

* Database initialization
Standard Rails commands can be used to set up the database for developoment, test and production
