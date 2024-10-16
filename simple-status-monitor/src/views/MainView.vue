<script type="module">
import { computed } from 'vue'
import { getSystemDetails, getDateTime } from '../lib/system'

const systemDetails = computed(() => {
  return getSystemDetails();
});

const dateTime = computed(() => {
  return getDateTime();
});
</script>

<template>
  <main>
    <p>This is coming from the main page</p>

    <div>
      <p>{{ `Date Time: ${dateTime}` }}</p>
      <div class="section">
        <div class="row">
          <span >Hostname:</span>
        </div>
        <div class="row">
          <span >Platform:</span>
        </div>
        <div class="row">
          <span >Architecture:</span>
        </div>
        <div class="row">
          <span >CPU Temperature:</span>
          <span>{{ `${systemDetails.cpuTemp.toFixed(1)}°C` }}</span>
        </div>
      </div>

      <div class="section">
        <h3 class="text-lg font-semibold text-foreground">CPU Usage</h3>
          <div v-for="(usage, index) in systemdetails.cpuUsage" :key="index" class="space-y-1">
            <div class="row">
              <span>{{ `Core ${index}` }}</span>
              <span>{{ `${usage}%` }} </span>
            </div>
          </div>
        ))}
      </div>

      <div class="section">
        <h3 class="text-lg font-semibold text-foreground">Memory Usage</h3>
        <div class="row">
          <span>Used</span>
          <span>
            {{ systemDetails.memoryUsage.used.toFixed(2) }} /
            {{ systemDetails.memoryUsage.total.toFixed(2) }} GB
          </span>
        </div>
      </div>
    </div>

  </main>
</template>
