<script setup lang="ts">
import { RouterView } from 'vue-router'
</script>

<template>
  <header>
    <section class="container">
      <h1 class="title is-1">Simple Status Page</h1>
      <p class="subtitle is-4">
        Display a list of network disconnections
      </p>
    </section>
  </header>

  <RouterView />
</template>
