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
            <div v-for="(value, key) in statistics.cpu" class="media">
              <div class="media-left">
                <p class="title is-6">{{key}}:</p>
              </div>
              <div class="media-content">
                <label :for="`${key}-progress-bar`">{{ value }}%</label>
                <progress
                  :id="`${key}-progress-bar`"
                  :value="value"
                  class="progress is-info"
                  max="100">
                  {{value}}%
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
            <div v-for="(value, key) in printableMemoryStats" class="media">
              <div class="media-left">
                <p class="title is-6">{{key}}:</p>
              </div>
              <div class="media-content">
                <label :for="`${key}-progress-bar`">{{ value }} MB</label>
                <progress
                  :id="`${key}-progress-bar`"
                  :value="value"
                  :max="statistics.memory.total"
                  class="progress is-info">
                  {{value}}
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
            <div v-for="(value, key) in printableDiskStats" class="media">
              <div class="media-left">
                <p class="title is-6">{{key}}:</p>
              </div>
              <div class="media-content">
                <label :for="`${key}-progress-bar`">{{ value }} GB</label>
                <progress
                  :id="`${key}-progress-bar`"
                  :value="value"
                  :max="statistics.disk.size"
                  class="progress is-info">
                  {{value}} GB
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
import axios from 'axios';

export default {
  data() {
    return {
      loadingStatistics: true,
      statistics: {},
    }
  },
  computed: {
    printableMemoryStats() {
      if (!this.statistics) return {};

      return {
        free: this.statistics.memory.free,
        used: this.statistics.memory.used,
      }
    },
    printableDiskStats() {
      if (!this.statistics) return {};

      return {
        free: this.statistics.disk.avail,
        used: this.statistics.disk.used,
      }
    },
  },
  mounted() {
    this.loadingStatistics = true;
    axios({
      method: 'get',
      url: '/api/statistics.json'
    }).then((response) => {
      this.loadingStatistics = false;
      this.statistics = response.data
    });
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
