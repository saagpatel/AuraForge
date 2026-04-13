import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import tailwindcss from "@tailwindcss/vite";

const host = process.env.TAURI_DEV_HOST || "127.0.0.1";
const cacheDir = process.env.VITE_CACHE_DIR || "node_modules/.vite";

export default defineConfig(async () => ({
  plugins: [react(), tailwindcss()],
  clearScreen: false,
  cacheDir,
  build: {
    rollupOptions: {
      output: {
        manualChunks: {
          "vendor-react": ["react", "react-dom"],
          "vendor-markdown": ["react-markdown", "remark-gfm"],
        },
      },
    },
  },
  server: {
    port: 1420,
    strictPort: true,
    // Use an explicit IPv4 loopback so Tauri and local probes don't diverge on localhost resolution.
    host,
    hmr: host
      ? {
          protocol: "ws",
          host,
          port: 1421,
        }
      : undefined,
    watch: {
      ignored: ["**/src-tauri/**"],
    },
  },
}));
