# internet-monitor

### Install the systemd unit

In order to install the unit, you must copy the `internet-monitor.service` file to the correct location using the following command.

```sh
cp internet-monitor.service /lib/systemd/system/
```

### Add a crontab to generate the report of disconnections

```sh
(crontab -l; echo "0 0 * * * cd Code/internet-monitor && /home/alejandro/.rbenv/shims/ruby script") | crontab -
```

### Run analysis of ping report

Just run the script using Ruby. Any version should work. Ruby version in this repo is just locked to latest one. This will print on screen the disconnects, and will also print to a file in the repos directory.

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

1. Abandon text reports, and use a DB instead. Then I can safely clean the logs every once in a while
2. Do a web based ui for the disconnects information?
3. Should probably create a small sh script, that installs the daemon.
