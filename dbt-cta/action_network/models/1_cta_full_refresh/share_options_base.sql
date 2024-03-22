{% set partitions_to_replace = [
    "timestamp_trunc(current_timestamp, day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 2 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 3 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 4 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 5 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 6 day), day)"
] %}
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    partitions = partitions_to_replace,
    unique_key = "_airbyte_raw_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('share_options_ab4') }}
select
    id,
    {{ adapter.quote('from') }},
    message,
    subject,
    reply_to,
    share_id,
    created_at,
    share_type,
    updated_at,
    direct_link,
    email_share,
    redirect_url,
    facebook_link,
    twitter_share,
    arbitrary_html,
    email_response,
    facebook_share,
    facebook_title,
    limit_redirect,
    email_template_id,
    facebook_pixel_id,
    google_conversion_id,
    unpublished_redirect,
    speechifai_email_html,
    speechifai_campaign_id,
    google_conversion_label,
    facebook_image_file_name,
    facebook_image_file_size,
    facebook_image_content_type,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_share_options_hashid
from {{ ref('share_options_ab4') }}
-- share_options from {{ source('cta_raw', '_airbyte_raw_share_options') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_extracted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}
