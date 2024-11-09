# frozen_string_literal: true

require_relative 'setup_database'
require_relative 'network_disconnection_model'

MAIN_REGEX = /^\[(?<epoch>\d+\.\d+)\] (?<success>64 bytes)?/
EXPECTED_LINES_WITHOUT_TIMESTAMPT = [
  /^PING google.com/,
  /^--- google.com/,
  /^[0-9]+ packets transmitted/,
  /^rtt min/,
  /^\s*$/
].freeze

TIMEZONE = 'A' # CET
PING_RESULTS_PATH = '/var/log/ping-internet-monitor.log'

lines = File.readlines(PING_RESULTS_PATH, chomp: true)

seq = 0
processed_rows = lines.map do |line|
  skip_line = EXPECTED_LINES_WITHOUT_TIMESTAMPT.any? { |regex| regex.match?(line) }
  next if skip_line

  seq += 1
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
disconnections = []

processed_rows.each_with_index do |row, index|
  if disconnected_active
    next unless row[:connected]

    disconnected_active = false
    disconnections.last[:reconnected_at] = row[:time]
  else
    next if row[:connected]

    disconnected_active = true
    disconnections.push(
      {
        disconnected_at: processed_rows[index - 1][:time]
      }
    )
  end
end

puts "Analyzed lines: #{seq}"
puts "Disconnections count: #{disconnections.count}"

return if disconnections.empty?

time = Time.now
formatted_time = time.strftime('%Y.%m.%d_%H:%M:%S')
file_name = "report_#{formatted_time}.txt"

conn = DbConnection.create_new_connection!

File.open(file_name, 'w') do |file|
  file.puts "Analyzed lines: #{seq}"

  file.puts "Disconnections count: #{disconnections.count}"

  disconnections.each do |disconnection|
    NetworkDisconnectionModel.save!(
      disconnected_at: disconnection[:disconnected_at].to_i,
      reconnected_at: (disconnection[:reconnected_at] || time).to_i,
      conn: conn
    )
    puts disconnection
    file.puts disconnection
  end
end
conn.close

# clears the file, so we do not duplicate the disconnection reports
File.open(PING_RESULTS_PATH, 'w') {}

puts "Report saved to ./#{file_name}"
