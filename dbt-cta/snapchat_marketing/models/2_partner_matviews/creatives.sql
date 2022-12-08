{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_creatives_hashid'
) }}

SELECT
     _airbyte_creatives_hashid
    ,MAX(id) as id
    ,MAX(name) as name
    ,MAX(type) as type
    ,MAX(headline) as headline
    ,MAX(shareable) as shareable
    ,MAX(ad_product) as ad_product
    ,MAX(brand_name) as brand_name
    ,MAX(created_at) as created_at
    ,MAX(updated_at) as updated_at
    ,MAX(render_type) as render_type
    ,MAX(ad_account_id) as ad_account_id
    ,MAX(review_status) as review_status
    ,MAX(call_to_action) as call_to_action
    ,MAX(packaging_status) as packaging_status
    ,MAX(top_snap_media_id) as top_snap_media_id
    ,MAX(web_view_properties) as web_view_properties
    ,MAX(utm_source) as utm_source
    ,MAX(utm_medium) as utm_medium
    ,MAX(utm_campaign) as utm_campaign
    ,MAX(utm_term) as utm_term
    ,MAX(utm_content) as utm_content
    ,MAX(review_status_details) as review_status_details
    ,MAX(top_snap_crop_position) as top_snap_crop_position
    ,MAX(forced_view_eligibility) as forced_view_eligibility
    ,MAX(_airbyte_ab_id) as _airbyte_ab_id
    ,MAX(_airbyte_emitted_at) as _airbyte_emitted_at
    ,MAX(_airbyte_normalized_at) as _airbyte_normalized_at
FROM {{ source('cta', 'creatives_base') }}
GROUP BY _airbyte_creatives_hashid