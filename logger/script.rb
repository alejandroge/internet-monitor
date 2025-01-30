# frozen_string_literal: true

require_relative 'setup_database'
require_relative 'network_disconnection_model'

MAIN_REGEX = /^(?<epoch>\d+) - (?<status>connected|disconnected)?/

PING_RESULTS_PATH = '/db-data/ping.log'
TIMEZONE = 'A' # CET

lines = File.readlines(PING_RESULTS_PATH, chomp: true)

seq = 0
processed_rows = lines.map do |line|
  seq += 1
  match = MAIN_REGEX.match(line)

  connected = match['status'] == 'connected'
  seconds_since_epoch_integer = match['epoch']
  time = Time.at(seconds_since_epoch_integer.to_i, in: TIMEZONE)

  processed_row = { seq: seq, connected: connected, time: time }

  processed_row
end

disconnected = false
disconnections = []

processed_rows.each_with_index do |row, index|
  if disconnected
    next unless row[:connected]

    disconnected = false
    disconnections.last[:reconnected_at] = row[:time]
  else
    next if row[:connected]

    disconnected = true
    disconnected_at =  index > 0 ? processed_rows[index - 1][:time] : row[:time]
    disconnections.push({ disconnected_at: disconnected_at })
  end
end

puts "Analyzed lines: #{seq}"
puts "Disconnections count: #{disconnections.count}"

conn = DbConnection.create_new_connection!
time = Time.now

if disconnections.any?
  disconnections.each do |disconnection|
    NetworkDisconnectionModel.save!(
      disconnected_at: disconnection[:disconnected_at].to_i,
      reconnected_at: (disconnection[:reconnected_at] || time).to_i,
      conn: conn
    )
    puts disconnection
  end
  conn.close
end

# clears the file, so we do not duplicate the disconnection reports
File.open(PING_RESULTS_PATH, 'w') {}
