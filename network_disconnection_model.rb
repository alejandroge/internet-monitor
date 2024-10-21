# frozen_string_literal: true

require 'sqlite3'

# Class for saving records to network_disconnections table
class NetworkDisconnectionModel
  TABLE_NAME = 'network_disconnections'

  # @param disconnected_at [Integer]
  # @param reconnected_at [Integer]
  def self.save!(disconnected_at:, reconnected_at:, conn:)
    # Insert data into the table
    statement = "INSERT INTO #{TABLE_NAME} (created_at, disconnected_at, reconnected_at) " \
        'VALUES (?, ?, ?)'

    execute(
      statement, [Time.now.to_i, disconnected_at, reconnected_at], conn
    )
  end

  def self.execute(statement, values, conn)
    conn.execute(statement, values)
  end
end
