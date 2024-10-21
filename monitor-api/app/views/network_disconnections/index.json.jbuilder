json.greeting "Hola mona"

json.disconnections @network_disconnections do |network_disconnection|
  json.id network_disconnection.id
  json.created_at network_disconnection.created_at
  json.disconnected_at network_disconnection.disconnected_at
  json.reconnected_at network_disconnection.reconnected_at
end

