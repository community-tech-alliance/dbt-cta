{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    tags=["cta_delivery","cursor"]
) }}
select *
from {{ source('cta', 'core_useragent_base') }}
