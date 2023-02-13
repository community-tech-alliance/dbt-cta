{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('campaigns_variate_settings') }}
{{ unnest_cte(ref('campaigns_variate_settings'), 'variate_settings', 'combinations') }}
select
    _airbyte_variate_settings_hashid,
    {{ json_extract_scalar(unnested_column_value('combinations'), ['id'], ['id']) }} as id,
    {{ json_extract_scalar(unnested_column_value('combinations'), ['reply_to'], ['reply_to']) }} as reply_to,
    {{ json_extract_scalar(unnested_column_value('combinations'), ['from_name'], ['from_name']) }} as from_name,
    {{ json_extract_scalar(unnested_column_value('combinations'), ['send_time'], ['send_time']) }} as send_time,
    {{ json_extract_scalar(unnested_column_value('combinations'), ['recipients'], ['recipients']) }} as recipients,
    {{ json_extract_scalar(unnested_column_value('combinations'), ['subject_line'], ['subject_line']) }} as subject_line,
    {{ json_extract_scalar(unnested_column_value('combinations'), ['content_description'], ['content_description']) }} as content_description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_variate_settings') }} as table_alias
-- combinations at campaigns/variate_settings/combinations
{{ cross_join_unnest('variate_settings', 'combinations') }}
where 1 = 1
and combinations is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

