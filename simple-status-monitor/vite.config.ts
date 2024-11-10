import { fileURLToPath, URL } from 'node:url'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vite.dev/config/
export default defineConfig({
  base: '/simple-status-monitor',
  server: {
    host: '0.0.0.0',
    proxy: {
      '/simple-status-monitor/api': {
        target: 'http://raspberrypi.local:3000',
        changeOrigin: true,
        secure: false,
        rewrite: (path) => path.replace(/^\/simple-status-monitor\/api/, ''),
      },
    },
  },
  plugins: [
    vue(),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  }
})
