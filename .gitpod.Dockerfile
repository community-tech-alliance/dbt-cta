FROM gitpod/workspace-full

RUN echo "deb https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list \
    && curl https://repo.charm.sh/apt/gpg.key | sudo apt-key add -

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" \
    | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
        && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && sudo apt-get update -y

RUN sudo apt-get install -y \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    google-cloud-cli \
    kubectl \
    screen \
    gum
