FROM ghcr.io/dbt-labs/dbt-bigquery:1.8.2

WORKDIR /dbt
COPY dbt-cta/ .

RUN dbt deps
