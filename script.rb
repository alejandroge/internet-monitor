MAIN_REGEX = /^\[(?<epoch>\d+\.\d+)\] (?<success>64 bytes)?/.freeze
EXPECTED_LINES_WITHOUT_TIMESTAMPT = [
  /^PING google.com/.freeze,
  /^--- google.com/.freeze,
  /^[0-9]+ packets transmitted/.freeze,
  /^rtt min/.freeze,
  /^\s*$/.freeze,
]

TIMEZONE = 'A' # CET
PING_RESULTS_PATH = '/var/log/ping-internet-monitor.log'

lines = File.readlines(PING_RESULTS_PATH, chomp: true)

seq = 0
processed_rows = lines.map do |line|
  skip_line = EXPECTED_LINES_WITHOUT_TIMESTAMPT.any? { |regex| regex.match?(line) }

  if skip_line
    # puts "skipped_line: #{line}"
    next
  end

  seq = seq + 1

  match = MAIN_REGEX.match(line)

  processed_row = { seq: seq, connected: match && match['success'] }

  if match
    seconds_since_epoch_integer = match['epoch']
    time = Time.at(seconds_since_epoch_integer.to_i, in: TIMEZONE)
    processed_row[:time] = time
  end

  processed_row
end.compact

disconnected_active = false
disconnected_at = nil

disconnections = []

processed_rows.each_with_index do |row, index|
  if disconnected_active
    next if !row[:connected]

    disconnected_active = false
    disconnections.last[:reconnected_at] = row[:time]
  else
    next if row[:connected]

    disconnected_active = true
    disconnections.push({
      disconnected_at: processed_rows[index - 1][:time]
    })
  end
end


time = Time.now
formatted_time = time.strftime("%Y.%m.%d_%H:%M:%S")
file_name = "report_#{formatted_time}"

puts "Report saved to ./#{file_name}.txt"

File.open("./#{file_name}.txt", "w") do |file|
  puts "Analyzed lines: #{seq}"
  file.puts "Analyzed lines: #{seq}"

  puts "Disconnections count: #{disconnections.count}"
  file.puts "Disconnections count: #{disconnections.count}"

  disconnections.each do |disconnection|
    puts disconnection
    file.puts disconnection
  end
end

