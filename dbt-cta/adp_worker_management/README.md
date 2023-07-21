# ADP Worker Management

CTA's custom Airbyte connector delivers all data for this sync into BigQuery in a single JSON payload, `workers`. This includes some fields that are arrays, for which any individual worker might potentially have multiple rows (eg, email addresses). These are unnested in all of the models besides `workers`.
