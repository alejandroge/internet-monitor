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
          <td>{{ disconnection.disconnected_at }}</td>
          <td>{{ disconnection.reconnected_at }}</td>
        </tr>
      </tbody>
    </table>
  </section>
</template>

<script type="module" lang="ts">
import axios from 'axios'

type Disconnection = {
  id: number
  created_at: string
  disconnected_at: string
  reconnected_at: string
}

export default {
  data(): { loading: boolean, disconnections: Disconnection[] } {
    return {
      loading: true,
      disconnections: [],
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
