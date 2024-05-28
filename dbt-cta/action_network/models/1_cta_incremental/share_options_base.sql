{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
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
