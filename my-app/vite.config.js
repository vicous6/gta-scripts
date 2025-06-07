import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import path from "path"
import tailwindcss from '@tailwindcss/vite'
export default defineConfig({
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
  base: './',
  plugins: [react(),tailwindcss()],
  build: {
    outDir: '../html', // <- This is where FiveM expects the UI
    emptyOutDir: true,
  },
})
