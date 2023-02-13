{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('campaigns_scd') }}
select
    _airbyte_campaigns_hashid,
    {{ json_extract_scalar('settings', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('settings', ['to_name'], ['to_name']) }} as to_name,
    {{ json_extract_scalar('settings', ['reply_to'], ['reply_to']) }} as reply_to,
    {{ json_extract_scalar('settings', ['timewarp'], ['timewarp']) }} as timewarp,
    {{ json_extract_scalar('settings', ['folder_id'], ['folder_id']) }} as folder_id,
    {{ json_extract_scalar('settings', ['from_name'], ['from_name']) }} as from_name,
    {{ json_extract_scalar('settings', ['auto_tweet'], ['auto_tweet']) }} as auto_tweet,
    {{ json_extract_scalar('settings', ['inline_css'], ['inline_css']) }} as inline_css,
    {{ json_extract_scalar('settings', ['auto_footer'], ['auto_footer']) }} as auto_footer,
    {{ json_extract_scalar('settings', ['fb_comments'], ['fb_comments']) }} as fb_comments,
    {{ json_extract_scalar('settings', ['template_id'], ['template_id']) }} as template_id,
    {{ json_extract_scalar('settings', ['authenticate'], ['authenticate']) }} as authenticate,
    {{ json_extract_string_array('settings', ['auto_fb_post'], ['auto_fb_post']) }} as auto_fb_post,
    {{ json_extract_scalar('settings', ['preview_text'], ['preview_text']) }} as preview_text,
    {{ json_extract_scalar('settings', ['subject_line'], ['subject_line']) }} as subject_line,
    {{ json_extract_scalar('settings', ['drag_and_drop'], ['drag_and_drop']) }} as drag_and_drop,
    {{ json_extract_scalar('settings', ['use_conversation'], ['use_conversation']) }} as use_conversation,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_scd') }} as table_alias
-- settings at campaigns/settings
where 1 = 1
and settings is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

