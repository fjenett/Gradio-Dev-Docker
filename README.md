# Gradio Component Development

A Docker based Gradio development environment.

## Usage

### Build container image

First build the container (only once):
```commandline
docker buildx build . -t gradio-dev
```

### Run container

Run the container:
```commandline
 docker run --rm --name gradio-dev -p 8080:7860 -p 8081:3000 -v $(pwd)/app.py:/gradio-dev/gradio/app.py -v $(pwd)/src/ui/:/gradio-dev/gradio/ui/ gradio-dev
```

**Currently only the hot reloading of the backend (Python side) works. The frontend side does not.**

There are stubs in the `src/` directory to get started with a new component. More background here:
https://gradio.app/creating_a_new_component/

### Stop container

Stop and auto remove the running container:
```commandline
docker stop gradio-dev
```

## Links

- https://gradio.app/creating_a_new_component/
- https://github.com/gradio-app/gradio