{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_geos_hashid'
) }}

select *
from {{ source('cta', 'adsquads_targeting_geos_base') }}
