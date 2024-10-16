 ```
 _     _                   _                     _ _
|_|___| |_ ___ ___ ___ ___| |_ ___ _____ ___ ___|_| |_ ___ ___
| |   |  _| -_|  _|   | -_|  _|___|     | . |   | |  _| . |  _|
|_|_|_|_| |___|_| |_|_|___|_|     |_|_|_|___|_|_|_|_| |___|_|
```

### Install the systemd unit

In order to install the unit, you must copy the `internet-monitor.service` file to the correct location using the following command.

This will put the results of the a ping command to a log file in: `/var/log/ping-internet-monitor.log`

```sh
cp internet-monitor.service /lib/systemd/system/
```

### Add a crontab to generate the report of disconnections

```sh
(crontab -l; echo "0 0 * * * cd Code/internet-monitor && /home/alejandro/.rbenv/shims/ruby script") | crontab -
```

### Run analysis of ping report

Just run the script using Ruby. This will print on screen the disconnects, and will also register the disconnects to a local sqlite3 database. Since this process is automated, this script also empties the `/var/log/pint-internet-monitor.log` after recording the disconnects.

```sh
ruby script.rb
```

### Manage the service using `systemctl`

This way we can use the systemctl to manage the service. The service will also restart if there a temporary throuble, even if the system itself restarts.

```sh
systemctl start internet-monitor.service
systemctl stop internet-monitor.service
systemctl status internet-monitor.service
```

##### TODO:

1. Do a web based ui for the disconnects information?
2. Should probably create a small sh script, that installs the daemon.
