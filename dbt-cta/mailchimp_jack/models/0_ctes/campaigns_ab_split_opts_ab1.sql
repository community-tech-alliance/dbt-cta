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
    {{ json_extract_scalar('ab_split_opts', ['subject_a'], ['subject_a']) }} as subject_a,
    {{ json_extract_scalar('ab_split_opts', ['subject_b'], ['subject_b']) }} as subject_b,
    {{ json_extract_scalar('ab_split_opts', ['wait_time'], ['wait_time']) }} as wait_time,
    {{ json_extract_scalar('ab_split_opts', ['split_size'], ['split_size']) }} as split_size,
    {{ json_extract_scalar('ab_split_opts', ['split_test'], ['split_test']) }} as split_test,
    {{ json_extract_scalar('ab_split_opts', ['wait_units'], ['wait_units']) }} as wait_units,
    {{ json_extract_scalar('ab_split_opts', ['from_name_a'], ['from_name_a']) }} as from_name_a,
    {{ json_extract_scalar('ab_split_opts', ['from_name_b'], ['from_name_b']) }} as from_name_b,
    {{ json_extract_scalar('ab_split_opts', ['pick_winner'], ['pick_winner']) }} as pick_winner,
    {{ json_extract_scalar('ab_split_opts', ['send_time_a'], ['send_time_a']) }} as send_time_a,
    {{ json_extract_scalar('ab_split_opts', ['send_time_b'], ['send_time_b']) }} as send_time_b,
    {{ json_extract_scalar('ab_split_opts', ['reply_email_a'], ['reply_email_a']) }} as reply_email_a,
    {{ json_extract_scalar('ab_split_opts', ['reply_email_b'], ['reply_email_b']) }} as reply_email_b,
    {{ json_extract_scalar('ab_split_opts', ['send_time_winner'], ['send_time_winner']) }} as send_time_winner,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_scd') }} as table_alias
-- ab_split_opts at campaigns/ab_split_opts
where 1 = 1
and ab_split_opts is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

