json.greeting "Hola bola|"

json.cpu do
  json.user @stats.cpu_stats[:user]
  json.system @stats.cpu_stats[:system]
  json.idle @stats.cpu_stats[:idle]
end

json.memory do
  json.total @stats.memory_stats[:total]
  json.free @stats.memory_stats[:free]
  json.used @stats.memory_stats[:used]
end

json.disk do
  json.size @stats.disk_stats[:size]
  json.used @stats.disk_stats[:used]
  json.avail @stats.disk_stats[:avail]
end
