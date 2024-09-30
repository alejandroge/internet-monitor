MAIN_REGEX = /^\[(?<epoch>\d+\.\d+)\] (?<success>64 bytes)?/.freeze
FIRST_LINE_REGEX = /^PING google.com/.freeze
TIMEZONE = 'A' # CET

lines = File.readlines('./ping_results.txt', chomp: true)
line_count = lines.size

seq = 0
processed_rows = lines.map do |line|
  next if FIRST_LINE_REGEX.match?(line)

  seq = seq + 1

  match = MAIN_REGEX.match(line)

  processed_row = { seq: seq, connected: !!match['success'] }

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

p seq
puts "Disconnections count: #{disconnections.count}"
disconnections.each { |disconnection| puts disconnection }
