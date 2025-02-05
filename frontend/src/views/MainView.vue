<template>
  <section class="container">
    <div class="tabs">
      <ul>
        <li
          v-for="(id, key) in tabs"
          :key="key"
          :class="{ 'is-active': isActiveTab(id) }"
        >
          <a @click="changeActiveTab(id)">
            {{ tabLabels[id] }}
          </a>
        </li>
      </ul>
    </div>
  </section>

  <NetworkDisconnections v-show="activeTab === tabs.disconnections" />
</template>

<script setup lang="ts">
import NetworkDisconnections from '../components/NetworkDisconnections.vue'
</script>

<script type="module" lang="ts">
const Tabs = {
  disconnections: 1,
}

export default {
  data() {
    return {
      activeTab: Tabs.disconnections,
      tabLabels: {
        [Tabs.disconnections]: 'Disconnections',
      },
      tabs: Tabs,
    }
  },
  computed: {},
  methods: {
    isActiveTab(id: number) {
      return this.activeTab === id
    },
    changeActiveTab(id: number) {
      this.activeTab = id
    },
  },
}
</script>
