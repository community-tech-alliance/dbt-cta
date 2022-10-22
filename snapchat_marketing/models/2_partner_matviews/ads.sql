{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'airbyte_ads_hashid'
) }}

SELECT
     _airbyte_ads_hashid
    ,MAX(id) as id
    ,MAX(name) as name
    ,MAX(type) as type
    ,MAX(status) as status
    ,MAX(created_at) as created_at
    ,MAX(updated_at) as updated_at
    ,MAX(ad_squad_id) as ad_squad_id
    ,MAX(creative_id) as creative_id
    ,MAX(render_type) as render_type
    ,MAX(review_status) as review_status
    ,MAX(ARRAY_TO_STRING(delivery_status,',')) as delivery_status
    ,MAX(_airbyte_ab_id) as _airbyte_ab_id
    ,MAX(_airbyte_emitted_at) as _airbyte_emitted_at
    ,MAX(_airbyte_normalized_at) as _airbyte_normalized_at
FROM {{ source('cta', 'ads_base') }}
GROUP BY _airbyte_ads_hashid