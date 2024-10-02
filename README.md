# internet-monitor

#### Generate ping report
```bash
ping -i 10 -D google.com > ping_results.txt &
```

#### Run analysis of ping report

Build the image for Ruby
```bash
docker build -t ruby .
```

Run the script to get the disconnects report
```bash
docker run -it --rm --name ruby-console -v "$PWD":/usr/src/myapp -w /usr/src/myapp ruby ruby script.rb
```

#### Find job to kill it
```bash
ps -eF | grep ping # find the PID
kill [PID]
```

##### TODO:
1. Currently working on transforming this into a systemd unit. Idea is that I don't have to run the ping command manually, and that it would restart automatically if I restart the raspberrypi.
  - should probably create a small sh script, that installs the daemon.

2. Drop the use of docker. It is really un-necessary I think, and takes resources. Just need to be sure to cleanly un-install it from the pi

3. Run the report generation on a cron job, so it also does not need my interaction.

4. Abandon text reports, and use a DB instead. Then I can safely clean the logs every once in a while

5. Do a web based ui for the disconnects information?

##### Current notes:
Unit file should be moved to a run-able directory
```cp internet-monitor.service /etc/systemd/system```

After the unit file is in there, the unit can be managed with `systemctl`
```sh
systemctl start internet-monitor
systemctl stop internet-monitor
systemctl status internet-monitor
```
