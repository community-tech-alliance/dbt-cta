FROM ghcr.io/dbt-labs/dbt-bigquery:1.8.2

WORKDIR /dbt
ADD dbt-cta/packages.yml /dbt/packages.yml
ADD dbt-cta/package-lock.yml /dbt/package-lock.yml
ADD dbt-cta/dbt_project.yml /dbt/dbt_project.yml

RUN dbt deps

COPY dbt-cta/ .

