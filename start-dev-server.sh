#! /bin/bash

mkdir ./logs
touch ./logs/logs-frontend.log
touch ./logs/logs-backend.log

echo "Starting frontend dev server"
cd ui && \
  pnpm --filter @gradio/app dev --host 0.0.0.0 0<&- &>./logs/logs-frontend.log &

echo "Starting backend dev server"
uvicorn app:app --port 7860 --reload --log-level warning --reload-dir "/gradio-dev/gradio/gradio" --reload-dir "." # 0<&- &>./logs/logs-backend.log &

tail -f /dev/null