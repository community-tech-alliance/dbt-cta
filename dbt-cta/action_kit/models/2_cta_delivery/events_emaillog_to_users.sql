{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    tags=["cta_delivery","cdc"]
) }}
select *
from {{ source('cta', 'events_emaillog_to_users_base') }}
