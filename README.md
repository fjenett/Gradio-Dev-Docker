# Gradio Component Development

A Docker based Gradio development environment.

I'm giving this a try to speed up experiments that are part of a larger research project trying to bring AI into design 
education: [KITeGG / gestaltung.ai](https://gestaltung.ai).



## Status

This is **WIP** as in it is tailored to my own way of working.

At the moment everything just started to work for the first time. See *usage* below on how to try things out.

## Usage

These are the steps to get started:
1) Download or fork-&-clone this repo to get a fresh copy
2) Build the Docker image
3) Run the docker image and open front- and backend dev servers in a browser
4) Edit `app.py` to change the basic layout of your Gradio interface 
   - Use backend server to check 
5) Edit the `MyComponent.svelte` files inside `src/` to shape / alter your custom component 
   - Use frontend server to check
6) Repeat 4–5 and start / stop container until you're done and happy
7) Deploy your custom files (`app.py` and contents of `src/`) with a fresh copy of the original Gradio repo
   - (*Note to self: probably needs more instructions here*)

### Build container image

Before you can get started you need to build the Docker image first. Since this is just setting up the environment you 
should only need to do this once after cloning or updating this repository.

If you are unfamiliar with Docker, then have a speed read over their [getting started](https://docs.docker.com/get-started/). 
Also, obviously you need to [install Docker](https://docs.docker.com/get-docker/) on your machine.

Build the image:
```commandline
./dev-scripts/build-docker-image.sh
```

You can have a look inside the `Dockerfile` if you are curious what is going on here. 

Once the image has been built, it is listed here:
```commandline
docker images
```

### Run a container

Now start a container (an instance of your Docker image). This starts the dev environment.

I've put the command into a shell script as it is quite large and easier to maintain in a file. Go have a look inside 
`./dev-scripts/run-docker-container.sh`.

Run the container:
```commandline
 ./dev-scripts/run-docker-container.sh
 
 # Optional: see it running
 docker ps
 
 # Optional: visit the running log of both servers
 # I keep this open to see that changes to the files actually 
 # trigger a rebuild/reload with the dev servers
 docker logs -f gradio-dev
 
 # Stop the server once done:
 ./dev-scripts/stop-docker-container.sh
```

The frontend now runs [here](http://localhost:3000), and the backend [here](http://localhost:7860).

#### Backend (dev) server:

Called *backend* because it hot-reloads based on the Python side of things, that is the *backend* (server side) of a Gradio project.

Watches `app.py` and the `gradio/` directory.

#### Frontend (dev) server:

Hot-reloads for frontend (browser side) parts of a Gradio project.

Based on `vite dev` running through `pnpm --filter dev`.

Needs the backend dev server (above) to run. That means if the python side fails, then this will also fail to start up. 
Fix python server first.

Changes to the Svelte or other files in `ui/` cause a rebuild and reload.   
Note that these are **not reflected** in the 
interface served through the backend server until you restart (stop-start) the container. This is because the frontend 
needs to be compiled into the backend before it starts up and that is (currently) not relfected in the hot-reloading process.

### Component development

Inside `src/` are template files to start with. These are mapped into the running container (see 
`./dev-scripts/run-docker-container.sh`) and you can edit them in place. Any change should trigger a reload with one of 
the two servers above (`gradio/` --> backend server, `ui/` --> frontend server).

```
src
|-- gradio
|   |-- __init__.py
|   |-- components.py
|   `-- test
|       `-- test_components.py
`-- ui
    `-- packages
        |-- app
        |   `-- src
        |       |-- components
        |       |   |-- MyComponent
        |       |   |   |-- MyComponent.svelte
        |       |   |   |-- MyComponent.test.ts
        |       |   |   `-- index.ts
        |       |   `-- directory.ts
        |       `-- custom-components
        `-- my-package
            |-- README.md
            |-- package.json
            `-- src
                |-- MyComponent.svelte
                `-- index.ts
```

If you add, move or rename files you will need to update the run command (see start script) to map these files into the 
container.

More background information is available here:
https://gradio.app/creating_a_new_component/

Also make sure to take the video tour by Abubakar Abid here:
https://www.youtube.com/watch?v=kWGK95gaRZE

## Links

- https://gradio.app/creating_a_new_component/
- https://github.com/gradio-app/gradio
- https://www.youtube.com/watch?v=kWGK95gaRZE

## Footer

- KITeGG is founded by [BMBF](https://www.bmbf.de/) and the states of RLP, NRW, BW, HE.
  - https://twitter.com/gestaltungai
  - https://gestaltung.ai/
  - https://www.instagram.com/gestaltungai/