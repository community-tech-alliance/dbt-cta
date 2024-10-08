{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}

-- depends_on: {{ ref('creatives_ab3') }}
select
    id,
    name,
    type,
    headline,
    shareable,
    ad_product,
    brand_name,
    created_at,
    updated_at,
    render_type,
    ad_account_id,
    review_status,
    call_to_action,
    packaging_status,
    top_snap_media_id,
    web_view_properties,
    review_status_details,
    top_snap_crop_position,
    forced_view_eligibility,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    regexp_extract(web_view_properties, r'utm_source=([^&]+)') as utm_source,
    regexp_extract(web_view_properties, r'utm_medium=([^&]+)') as utm_medium,
    regexp_extract(web_view_properties, r'utm_campaign=([^&]+)') as utm_campaign,
    regexp_extract(web_view_properties, r'utm_term=([^&]+)') as utm_term,
    regexp_extract(regexp_extract(web_view_properties, r'utm_content=([^&]+)'), r'([a-zA-Z0-9]+)') as utm_content,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('creatives_ab3') }}
