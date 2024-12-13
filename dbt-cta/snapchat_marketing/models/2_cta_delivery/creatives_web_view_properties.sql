{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'creative_id'
) }}

select *
from {{ source('cta', 'creatives_web_view_properties_base') }}
