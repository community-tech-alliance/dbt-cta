{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    tags=["cta_delivery","cdc"]
) }}
select *
from {{ source('cta', 'core_callaction_local_office_checked_base') }}
