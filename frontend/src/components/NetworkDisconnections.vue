<template>
  <section class="container">
    <p v-if="loading" class="loading">Loading</p>
    <table v-else class="table">
      <thead>
        <tr>
          <th>id</th>
          <th>disconnected at</th>
          <th>reconnected at</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="disconnection in disconnections" :key="disconnection.id">
          <td>{{ disconnection.id }}</td>
          <td>{{ formatUnixTimestamp(disconnection.disconnected_at) }}</td>
          <td>{{ formatUnixTimestamp(disconnection.reconnected_at) }}</td>
        </tr>
      </tbody>
    </table>
  </section>
</template>

<script type="module" lang="ts">
import axios from 'axios'

type Disconnection = {
  id: number
  created_at: number
  disconnected_at: number
  reconnected_at: number
}

export default {
  data(): { loading: boolean, disconnections: Disconnection[] } {
    return {
      loading: true,
      disconnections: [],
    }
  },
  methods: {
    formatUnixTimestamp(timestamp: number): string {
      const date = new Date(timestamp);
      return new Intl.DateTimeFormat('default', {
        day: '2-digit',
        month: '2-digit',
        year: 'numeric',
        hour: '2-digit',
        minute: '2-digit',
      }).format(date).replace(',', '');
    }
  },
  mounted() {
    this.loading = true;
    axios({
      method: 'get',
      url: '/api/network_disconnections',
    }).then(response => {
      this.disconnections = response.data;
      this.loading = false;
    })
  },
}
</script>
