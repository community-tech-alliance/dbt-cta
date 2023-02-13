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
    {{ json_extract_scalar('recipients', ['list_id'], ['list_id']) }} as list_id,
    {{ json_extract_scalar('recipients', ['list_name'], ['list_name']) }} as list_name,
    {{ json_extract('table_alias', 'recipients', ['segment_opts'], ['segment_opts']) }} as segment_opts,
    {{ json_extract_scalar('recipients', ['segment_text'], ['segment_text']) }} as segment_text,
    {{ json_extract_scalar('recipients', ['list_is_active'], ['list_is_active']) }} as list_is_active,
    {{ json_extract_scalar('recipients', ['recipient_count'], ['recipient_count']) }} as recipient_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_scd') }} as table_alias
-- recipients at campaigns/recipients
where 1 = 1
and recipients is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

