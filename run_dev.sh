#! /bin/bash

echo "Starting frontend dev server"
cd ui && \
  pnpm --filter @gradio/app dev --host 0.0.0.0 0<&- &>/dev/null &

echo "Starting backend dev server"
uvicorn app:app --port 7860 --reload --log-level warning --reload-dir "/gradio-dev/gradio/gradio" --reload-dir "."