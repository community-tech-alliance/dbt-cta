{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_share_options') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['from'], ['from']) }} as {{ adapter.quote('from') }},
    {{ json_extract_scalar('_airbyte_data', ['message'], ['message']) }} as message,
    {{ json_extract_scalar('_airbyte_data', ['subject'], ['subject']) }} as subject,
    {{ json_extract_scalar('_airbyte_data', ['reply_to'], ['reply_to']) }} as reply_to,
    {{ json_extract_scalar('_airbyte_data', ['share_id'], ['share_id']) }} as share_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['share_type'], ['share_type']) }} as share_type,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['direct_link'], ['direct_link']) }} as direct_link,
    {{ json_extract_scalar('_airbyte_data', ['email_share'], ['email_share']) }} as email_share,
    {{ json_extract_scalar('_airbyte_data', ['redirect_url'], ['redirect_url']) }} as redirect_url,
    {{ json_extract_scalar('_airbyte_data', ['facebook_link'], ['facebook_link']) }} as facebook_link,
    {{ json_extract_scalar('_airbyte_data', ['twitter_share'], ['twitter_share']) }} as twitter_share,
    {{ json_extract_scalar('_airbyte_data', ['arbitrary_html'], ['arbitrary_html']) }} as arbitrary_html,
    {{ json_extract_scalar('_airbyte_data', ['email_response'], ['email_response']) }} as email_response,
    {{ json_extract_scalar('_airbyte_data', ['facebook_share'], ['facebook_share']) }} as facebook_share,
    {{ json_extract_scalar('_airbyte_data', ['facebook_title'], ['facebook_title']) }} as facebook_title,
    {{ json_extract_scalar('_airbyte_data', ['limit_redirect'], ['limit_redirect']) }} as limit_redirect,
    {{ json_extract_scalar('_airbyte_data', ['email_template_id'], ['email_template_id']) }} as email_template_id,
    {{ json_extract_scalar('_airbyte_data', ['facebook_pixel_id'], ['facebook_pixel_id']) }} as facebook_pixel_id,
    {{ json_extract_scalar('_airbyte_data', ['google_conversion_id'], ['google_conversion_id']) }} as google_conversion_id,
    {{ json_extract_scalar('_airbyte_data', ['unpublished_redirect'], ['unpublished_redirect']) }} as unpublished_redirect,
    {{ json_extract_scalar('_airbyte_data', ['speechifai_email_html'], ['speechifai_email_html']) }} as speechifai_email_html,
    {{ json_extract_scalar('_airbyte_data', ['speechifai_campaign_id'], ['speechifai_campaign_id']) }} as speechifai_campaign_id,
    {{ json_extract_scalar('_airbyte_data', ['google_conversion_label'], ['google_conversion_label']) }} as google_conversion_label,
    {{ json_extract_scalar('_airbyte_data', ['facebook_image_file_name'], ['facebook_image_file_name']) }} as facebook_image_file_name,
    {{ json_extract_scalar('_airbyte_data', ['facebook_image_file_size'], ['facebook_image_file_size']) }} as facebook_image_file_size,
    {{ json_extract_scalar('_airbyte_data', ['facebook_image_content_type'], ['facebook_image_content_type']) }} as facebook_image_content_type,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_share_options') }}
-- share_options
where 1 = 1
