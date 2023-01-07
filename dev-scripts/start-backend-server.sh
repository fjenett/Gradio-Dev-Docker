#! /bin/bash

echo "Starting backend server: http://localhost:7860"

uvicorn app:app --port 7860 --reload --log-level warning --reload-dir "/gradio-dev/gradio/gradio" --reload-dir "."
