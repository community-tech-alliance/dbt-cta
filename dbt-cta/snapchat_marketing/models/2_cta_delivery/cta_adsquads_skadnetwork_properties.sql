{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'ad_squad_id'
) }}

select *
from {{ source('cta', 'adsquads_skadnetwork_properties_base') }}
