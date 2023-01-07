# Gradio Component Development

A Docker based Gradio development environment.

I'm giving this a try to speed up experiments that are part of a larger research project trying to bring AI into design education: [KITeGG / gestaltung.ai](https://gestaltung.ai).

## Status

This is **WIP** as in it is tailored to my own way of working.

At the moment everything just started to work for the first time. See *usage* below on how to try things out.

## Usage

### Build container image

Before you can get started you need to build the Docker image first. Since this is just setting up the environment you should only need to do this once after cloning or updating this repository.

If you are unfamiliar with Docker, then have a speed read over their [getting started](https://docs.docker.com/get-started/). Also, obviously you need to [install Docker](https://docs.docker.com/get-docker/) on your machine.

Build the image:
```commandline
docker buildx build . -t gradio-dev
```

You can have a look inside the `Dockerfile` if you are curious what is going on here. 

Once the image has been built, it is listed here:
```commandline
docker images
```

### Run a container

Now start a container (an instance of your Docker image). This starts the dev environment.

I've put the command into a shell script as it is quite large and easier to maintain in a file. Go have a look inside `./dev-scripts/run-docker-container.sh`.

Run the container:
```commandline
 ./dev-scripts/run-docker-container.sh
```

Stop (and auto remove) a running container:
```commandline
docker stop gradio-dev
```

### Component development

Inside `src/` are template files to start with. These are mapped into the running container (see `./dev-scripts/run-docker-container.sh`). You can edit them in place and they are triggering a rebuild/reload inside the container.

If you add / rename files you will need to update the run command (see start script) to map these files into the container.

More background is available here:
https://gradio.app/creating_a_new_component/

## Links

- https://gradio.app/creating_a_new_component/
- https://github.com/gradio-app/gradio
- https://www.youtube.com/watch?v=kWGK95gaRZE