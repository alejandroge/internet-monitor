<template>
  <section class="container">
    <h3 class="title is-3">Disconnections</h3>

    <table class="table">
      <thead>
        <tr>
          <th>id</th>
          <th>disconnected at</th>
          <th>reconnected at</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="disconnection in disconnectionData.disconnections" :key="disconnection.id">
          <td>{{ disconnection.id }}</td>
          <td>{{ disconnection.disconnected_at }}</td>
          <td>{{ disconnection.reconnected_at }}</td>
        </tr>
      </tbody>
    </table>
  </section>
</template>

<script type="module" lang="ts">
import axios from 'axios';

export default {
  data() {
    return {
      disconnectionData: {},
    }
  },
  mounted() {
    axios({
      method: 'get',
      url: '/api/network_disconnections.json'
    }).then((response) => {
      this.disconnectionData = response.data
    });
  },
}
</script>
