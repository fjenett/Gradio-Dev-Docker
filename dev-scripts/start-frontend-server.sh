#! /bin/bash

echo "Starting frontend server: http://localhost:3000"

cd ui && pnpm --filter @gradio/app dev --host 0.0.0.0
