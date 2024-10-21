class NetworkDisconnection < ApplicationRecord
  def created_at
    unix_ts_to_datetime(self[:created_at])
  end

  def disconnected_at
    unix_ts_to_datetime(self[:disconnected_at])
  end

  def reconnected_at
    unix_ts_to_datetime(self[:reconnected_at])
  end

  def readonly?
    true
  end

  private

  def unix_ts_to_datetime(ts)
    Time.at(ts).to_datetime
  end
end
