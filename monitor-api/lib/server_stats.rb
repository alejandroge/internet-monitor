class ServerStats
  CPU_USAGE_REGEX = /\s+(?<user>\d+\.\d+) us,.*\s+(?<system>\d+\.\d+) sy,.*\s+(?<idle>\d+\.\d+) id/
  MEM_USAGE_REGEX = /\s+(?<total>\d+\.\d+) total,.*\s+(?<free>\d+\.\d+) free,.*\s+(?<used>\d+\.\d+) used/
  DISK_USAGE_REGEX = /\s+(?<size>\d+G)\s+(?<used>\d+G)\s+(?<avail>\d+G)/

  def initialize
    @raw_cpu_usage = `top -bn1 | grep "Cpu(s)"` # Linux command
    @raw_memory_info = `top -bn1 | grep "MiB Mem"` # Gets memory information in megabytes
    @raw_disk_usage = `df -h /`
  end

  def cpu_stats
    cpu_usage = CPU_USAGE_REGEX.match(@raw_cpu_usage)

    {
      user: cpu_usage[:user].to_f,
      system: cpu_usage[:system].to_f,
      idle: cpu_usage[:idle].to_f
    }
  end

  def memory_stats
    mem_usage = MEM_USAGE_REGEX.match(@raw_memory_info)

    {
      total: mem_usage[:total].to_f,
      free: mem_usage[:free].to_f,
      used: mem_usage[:used].to_f
    }
  end

  def disk_stats
    disk_usage = DISK_USAGE_REGEX.match(@raw_disk_usage)


    {
      size: disk_usage[:size].to_i,
      used: disk_usage[:used].to_i,
      avail: disk_usage[:avail].to_i
    }
  end
end
