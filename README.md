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