{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('share_options_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast({{ adapter.quote('from') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('from') }},
    cast(message as {{ dbt_utils.type_string() }}) as message,
    cast(subject as {{ dbt_utils.type_string() }}) as subject,
    cast(reply_to as {{ dbt_utils.type_string() }}) as reply_to,
    cast(share_id as {{ dbt_utils.type_bigint() }}) as share_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(share_type as {{ dbt_utils.type_string() }}) as share_type,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(direct_link as {{ dbt_utils.type_string() }}) as direct_link,
    cast(email_share as {{ dbt_utils.type_string() }}) as email_share,
    cast(redirect_url as {{ dbt_utils.type_string() }}) as redirect_url,
    cast(facebook_link as {{ dbt_utils.type_string() }}) as facebook_link,
    cast(twitter_share as {{ dbt_utils.type_string() }}) as twitter_share,
    cast(arbitrary_html as {{ dbt_utils.type_string() }}) as arbitrary_html,
    cast(email_response as {{ dbt_utils.type_bigint() }}) as email_response,
    cast(facebook_share as {{ dbt_utils.type_string() }}) as facebook_share,
    cast(facebook_title as {{ dbt_utils.type_string() }}) as facebook_title,
    cast(limit_redirect as {{ dbt_utils.type_string() }}) as limit_redirect,
    cast(email_template_id as {{ dbt_utils.type_bigint() }}) as email_template_id,
    cast(facebook_pixel_id as {{ dbt_utils.type_string() }}) as facebook_pixel_id,
    cast(google_conversion_id as {{ dbt_utils.type_string() }}) as google_conversion_id,
    cast(unpublished_redirect as {{ dbt_utils.type_string() }}) as unpublished_redirect,
    cast(speechifai_email_html as {{ dbt_utils.type_string() }}) as speechifai_email_html,
    cast(speechifai_campaign_id as {{ dbt_utils.type_string() }}) as speechifai_campaign_id,
    cast(google_conversion_label as {{ dbt_utils.type_string() }}) as google_conversion_label,
    cast(facebook_image_file_name as {{ dbt_utils.type_string() }}) as facebook_image_file_name,
    cast(facebook_image_file_size as {{ dbt_utils.type_bigint() }}) as facebook_image_file_size,
    cast(facebook_image_content_type as {{ dbt_utils.type_string() }}) as facebook_image_content_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('share_options_ab1') }}
-- share_options
where 1 = 1

