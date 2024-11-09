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

<script type="module" lang="ts">
import axios from 'axios'

type Statistics = {
  cpu: {
    user: number
    system: number
    idle: number
  }
  memory: {
    free: number
    used: number
    total: number
  }
  disk: {
    avail: number
    used: number
    size: number
  }
}

export default {
  data(): { loadingStatistics: boolean; statistics: Statistics } {
    return {
      loadingStatistics: true,
      statistics: {
        cpu: {
          user: 0,
          system: 0,
          idle: 0,
        },
        memory: {
          free: 0,
          used: 0,
          total: 0,
        },
        disk: {
          avail: 0,
          used: 0,
          size: 0,
        },
      },
    }
  },
  computed: {
    printableMemoryStats() {
      return {
        free: this.statistics.memory.free,
        used: this.statistics.memory.used,
      }
    },
    printableDiskStats() {
      return {
        free: this.statistics.disk.avail,
        used: this.statistics.disk.used,
      }
    },
  },
  mounted() {
    this.loadingStatistics = true
    axios({
      method: 'get',
      url: '/api/statistics.json',
    }).then(response => {
      this.loadingStatistics = false
      this.statistics = response.data
    })
  },
}
</script>

<style scoped>
.card {
  .media-left {
    width: 100px;
  }
}
</style>
