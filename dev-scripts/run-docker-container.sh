#! /bin/bash

docker run \
  --name gradio-dev \
  -d --rm \
  -p 7860:7860 \
  -p 3000:3000 \
  -v $(pwd)/app.py:/gradio-dev/gradio/app.py \
  -v $(pwd)/src/ui/packages/my-package/:/gradio-dev/gradio/ui/packages/my-package/ \
  -v $(pwd)/src/ui/packages/app/src/components/directory.ts:/gradio-dev/gradio/ui/packages/app/src/components/directory.ts \
  -v $(pwd)/src/ui/packages/app/package.json:/gradio-dev/gradio/ui/packages/app/package.json \
  -v $(pwd)/src/ui/packages/app/src/components/MyComponent/:/gradio-dev/gradio/ui/packages/app/src/components/MyComponent/ \
  -v $(pwd)/src/gradio/test/test_components.py:/gradio-dev/gradio/gradio/test/test_components.py \
  -v $(pwd)/src/gradio/__init__.py:/gradio-dev/gradio/gradio/__init__.py \
  -v $(pwd)/src/gradio/components.py:/gradio-dev/gradio/gradio/components.py \
  gradio-dev
