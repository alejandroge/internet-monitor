<template>
  <section class="container">
    <div class="tabs">
      <ul>
        <li
            v-for="id, key in tabs" :key="id"
            :class="{ 'is-active': isActiveTab(id) }">
          <a @click="changeActiveTab(id)">
            {{ tabLabels[id] }}
          </a>
        </li>
      </ul>
    </div>
  </section>

  <NetworkDisconnections v-show="activeTab === tabs.disconnections" />
  <SystemStats v-show="activeTab === tabs.systemStats" />
</template>

<script setup lang="ts">
import NetworkDisconnections from '../components/NetworkDisconnections.vue';
import SystemStats from '../components/SystemStats.vue';
</script>

<script type="module" lang="ts">
import axios from 'axios';

const Tabs = {
  disconnections: 1,
  systemStats: 2,
}

export default {
  data() {
    return {
      activeTab: Tabs.disconnections,
      tabLabels: {
        [Tabs.disconnections]: "Disconnections",
        [Tabs.systemStats]: "System Stats",
      },
      tabs: Tabs,
    }
  },
  computed: {
  },
  methods: {
    isActiveTab(id) {
      return this.activeTab === id;
    },
    changeActiveTab(id) {
      this.activeTab = id;
    },
  },
  mounted() {
  },
}
</script>
