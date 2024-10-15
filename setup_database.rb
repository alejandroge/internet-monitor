require 'sqlite3'

class DbConnection
  DB_NAME = "internet-monitor.db".freeze

  def self.create_new_connection!
    conn = SQLite3::Database.new(DB_NAME)

    conn.execute <<-SQL
      CREATE TABLE IF NOT EXISTS network_disconnections (
        id INTEGER PRIMARY KEY,
        created_at INTEGER NOT NULL,
        disconnected_at INTEGER NOT NULL,
        reconnected_at INTEGER NOT NULL,
        duration INTEGER
      );

      CREATE INDEX IF NOT EXISTS created_at_index ON network_disconnections(created_at);
    SQL

    conn
  end
end
