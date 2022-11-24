FROM gitpod/workspace-full

# Env vars
ENV PYTHONIOENCODING=utf-8
ENV LANG=C.UTF-8

ARG build_for=linux/amd64

# dbt args
ARG dbt_core_ref=dbt-core@main
ARG dbt_bigquery_ref=dbt-bigquery@main
ARG dbt_third_party

RUN echo "deb https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list \
    && curl https://repo.charm.sh/apt/gpg.key | sudo apt-key add -

RUN wget https://cache.agilebits.com/dist/1P/op2/pkg/v2.7.1-beta.01/op_linux_amd64_v2.7.1-beta.01.zip \
    && unzip op_linux_amd64_v2.7.1-beta.01.zip \
    && sudo mv op /usr/local/bin

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" \
    | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
        && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add -

RUN sudo apt-get update -y \
  && sudo apt-get dist-upgrade -y \
  && sudo apt-get install -y --no-install-recommends \
  && sudo apt-get install -y \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    build-essential \
    ssh-client \
    gnupg \
    google-cloud-cli \
    kubectl \
    libpq-dev \
    screen \
    make \
    gum


RUN python -m pip install --upgrade pip setuptools wheel --no-cache-dir

RUN python -m pip install --no-cache-dir "git+https://github.com/dbt-labs/${dbt_core_ref}#egg=dbt-core&subdirectory=core"

RUN python -m pip install --no-cache-dir "git+https://github.com/dbt-labs/${dbt_bigquery_ref}#egg=dbt-bigquery"

RUN python -m pip install --no-cache-dir "${dbt_third_party}"

