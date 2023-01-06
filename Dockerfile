FROM python:3.7.16

# Set default shell to be /bin/bash (not /bin/sh)
ENV SHELL=/bin/bash
SHELL ["/bin/bash", "-c"]

# Install NVM (node version manager)
# https://stackoverflow.com/questions/25899912/how-to-install-nvm-in-docker/60137919#28390848
# https://stackoverflow.com/questions/25899912/how-to-install-nvm-in-docker/60137919#50958281
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 16.19.0
WORKDIR $NVM_DIR
RUN wget https://raw.githubusercontent.com/creationix/nvm/master/install.sh
RUN . $NVM_DIR/install.sh
# RUN echo "export NODE_PATH=$NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules" >> ~/.bashrc
ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
# RUN echo "export PATH=$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH" >> ~/.bashrc
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
RUN source /root/.bashrc && \
    nvm install 16

# Install PNPM
# https://github.com/pnpm/pnpm/issues/4495
RUN wget -qO- https://get.pnpm.io/install.sh | sh -
ENV PNPM_HOME="/root/.local/share/pnpm"
ENV PATH="${PATH}:${PNPM_HOME}"

# Get Gradio source
ENV WORKDIR=/gradio-dev
WORKDIR $WORKDIR
RUN git clone --depth 1 https://github.com/gradio-app/gradio.git
WORKDIR $WORKDIR/gradio

# Install Gradio
# https://github.com/gradio-app/gradio/blob/main/CONTRIBUTING.md
RUN npm install -g vite
RUN chmod +x scripts/*.sh
RUN scripts/install_gradio.sh
RUN export NODE_OPTIONS=--max-old-space-size=32768 && \
    scripts/build_frontend.sh
RUN scripts/install_test_requirements.sh
RUN scripts/create_test_requirements.sh

# Load example hello world
COPY . .

ENV GRADIO_SERVER_PORT 7860
ENV GRADIO_SERVER_NAME 0.0.0.0
EXPOSE $GRADIO_SERVER_PORT

# frontend dev server port
EXPOSE 3000

# CMD ["/usr/local/bin/python", "app.py"]

# CMD ["/usr/local/bin/gradio", "app.py"]
#CMD ["uvicorn", "app:app", \
#                "--reload", \
#                "--port", "7860", \
#                "--log-level", "warning", \
#                "--reload-dir", "/gradio-dev/gradio/gradio", \
#                "--reload-dir", "." \
#    ]
# uvicorn app:app --reload --log-level warning --reload-dir "/gradio-dev/gradio/gradio" --reload-dir "."

# pnpm dev

# CMD ["tail", "-f", "/dev/null"]

CMD ["/bin/bash", "start-dev-server.sh"]