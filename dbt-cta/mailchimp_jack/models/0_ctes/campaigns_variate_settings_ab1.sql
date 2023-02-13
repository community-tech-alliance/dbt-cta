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
    {{ json_extract_string_array('variate_settings', ['contents'], ['contents']) }} as contents,
    {{ json_extract_scalar('variate_settings', ['test_size'], ['test_size']) }} as test_size,
    {{ json_extract_scalar('variate_settings', ['wait_time'], ['wait_time']) }} as wait_time,
    {{ json_extract_string_array('variate_settings', ['from_names'], ['from_names']) }} as from_names,
    {{ json_extract_string_array('variate_settings', ['send_times'], ['send_times']) }} as send_times,
    {{ json_extract_array('variate_settings', ['combinations'], ['combinations']) }} as combinations,
    {{ json_extract_string_array('variate_settings', ['subject_lines'], ['subject_lines']) }} as subject_lines,
    {{ json_extract_scalar('variate_settings', ['winner_criteria'], ['winner_criteria']) }} as winner_criteria,
    {{ json_extract_string_array('variate_settings', ['reply_to_addresses'], ['reply_to_addresses']) }} as reply_to_addresses,
    {{ json_extract_scalar('variate_settings', ['winning_campaign_id'], ['winning_campaign_id']) }} as winning_campaign_id,
    {{ json_extract_scalar('variate_settings', ['winning_combination_id'], ['winning_combination_id']) }} as winning_combination_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_scd') }} as table_alias
-- variate_settings at campaigns/variate_settings
where 1 = 1
and variate_settings is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

