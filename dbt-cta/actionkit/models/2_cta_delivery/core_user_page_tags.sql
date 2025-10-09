{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    tags=["cta_delivery","cdc"]
) }}
select *
from {{ source('cta', 'core_user_page_tags_base') }}
