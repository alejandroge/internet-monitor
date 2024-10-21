class CreateNetworkDisconnections < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:network_disconnections)
      create_table :network_disconnections do |t|
        t.integer :created_at, null: false, index: true
        t.integer :disconnect_at, null: false
        t.integer :reconnected_at, null: false
        t.integer :duration
      end
    end
  end

  def down
    if table_exists?(:network_disconnections)
      drop_table :network_disconnections
    end
  end
end
