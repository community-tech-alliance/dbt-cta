{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('campaigns_recipients_segment_opts') }}
{{ unnest_cte(ref('campaigns_recipients_segment_opts'), 'segment_opts', 'conditions') }}
select
    _airbyte_segment_opts_hashid,
    {{ json_extract_scalar(unnested_column_value('conditions'), ['op'], ['op']) }} as op,
    {{ json_extract_scalar(unnested_column_value('conditions'), ['field'], ['field']) }} as field,
    {{ json_extract_scalar(unnested_column_value('conditions'), ['value'], ['value']) }} as value,
    {{ json_extract_scalar(unnested_column_value('conditions'), ['condition_type'], ['condition_type']) }} as condition_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_recipients_segment_opts') }} as table_alias
-- conditions at campaigns/recipients/segment_opts/conditions
{{ cross_join_unnest('segment_opts', 'conditions') }}
where 1 = 1
and conditions is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

