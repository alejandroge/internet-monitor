 ```
 _     _                   _                     _ _
|_|___| |_ ___ ___ ___ ___| |_ ___ _____ ___ ___|_| |_ ___ ___
| |   |  _| -_|  _|   | -_|  _|___|     | . |   | |  _| . |  _|
|_|_|_|_| |___|_| |_|_|___|_|     |_|_|_|___|_|_|_|_| |___|_|
```

### how to run it?

Simply run the docker-compose up command. This will start the appropriate containers and the application will be available at `http://localhost:8081`.

> Note: you must build the go binary before running the docker-compose up command.

### how does it work?

A bit more of info can be found in the individual README file of each service. But in general, the application is composed of 3 services:

1. **logger**: this service logs the connection status, using a simple ping command in the console. It pings periodically, every 15 seconds. A ruby script is run every hour, which analyzes the logs results, and saves disconnection events in a sqlite3 database.
2. **api**: minimal api, that exposes the disconnection events saved in the sqlite3 database. It has a single endpoint, that returns the disconnection events in a json format. It is written in Go.
3. **frontend**: vuejs frontend using bulma, that consumes the api and displays the disconnection events in a table.

When running docker compose, a volume is created. This volume is shared between the logger and the api services. The logs and the databse are stored in this volume, so they are persisted between runs.
