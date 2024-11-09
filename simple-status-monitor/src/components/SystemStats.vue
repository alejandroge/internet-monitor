<template>
  <section class="container">
    <p v-if="loadingStatistics" class="loading">Loading</p>
    <div v-else class="columns">
      <div class="column">
        <div class="card cpu">
          <header class="card-header">
            <p class="card-header-title">CPU</p>
          </header>
          <div class="card-content">
            <div
              v-for="(value, key) in statistics.cpu"
              :key="key"
              class="media"
            >
              <div class="media-left">
                <p class="title is-6">{{ key }}:</p>
              </div>
              <div class="media-content">
                <label :for="`${key}-progress-bar`">{{ value }}%</label>
                <progress
                  :id="`${key}-progress-bar`"
                  :value="value"
                  class="progress is-info"
                  max="100"
                >
                  {{ value }}%
                </progress>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="column">
        <div class="card mem">
          <header class="card-header">
            <p class="card-header-title">Memory</p>
          </header>
          <div class="card-content">
            <div
              v-for="(value, key) in printableMemoryStats"
              :key="key"
              class="media"
            >
              <div class="media-left">
                <p class="title is-6">{{ key }}:</p>
              </div>
              <div class="media-content">
                <label :for="`${key}-progress-bar`">{{ value }} MB</label>
                <progress
                  :id="`${key}-progress-bar`"
                  :value="value"
                  :max="statistics.memory.total"
                  class="progress is-info"
                >
                  {{ value }}
                </progress>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="column">
        <div class="card disk">
          <header class="card-header">
            <p class="card-header-title">Disk</p>
          </header>
          <div class="card-content">
            <div
              v-for="(value, key) in printableDiskStats"
              :key="key"
              class="media"
            >
              <div class="media-left">
                <p class="title is-6">{{ key }}:</p>
              </div>
              <div class="media-content">
                <label :for="`${key}-progress-bar`">{{ value }} GB</label>
                <progress
                  :id="`${key}-progress-bar`"
                  :value="value"
                  :max="statistics.disk.size"
                  class="progress is-info"
                >
                  {{ value }} GB
                </progress>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import { reactive, computed } from 'vue'
import axios from 'axios'

type Statistics = {
  cpu: {
    user: Number
    system: Number
    idle: Number
  }
  memory: {
    free: Number
    used: Number
    total: Number
  }
  disk: {
    avail: Number
    used: Number
    size: Number
  }
}

let loadingStatistics = true
let statistics: Statistics | object = reactive({})

const printableMemoryStats = computed(() => {
  if (!statistics) return statistics

  return {
    free: statistics.memory.free,
    used: statistics.memory.used,
  }
})

const printableDiskStats = computed(() => {
  if (!statistics) return statistics

  return {
    free: statistics.disk.avail,
    used: statistics.disk.used,
  }
})

loadingStatistics = true
axios({
  method: 'get',
  url: '/api/statistics.json',
}).then(response => {
  loadingStatistics = false
  statistics = response.data
})
</script>

<style scoped>
.card {
  .media-left {
    width: 100px;
  }
}
</style>
