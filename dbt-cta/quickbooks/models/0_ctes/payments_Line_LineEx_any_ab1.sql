{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payments_Line_LineEx_base') }}
{{ unnest_cte(ref('payments_Line_LineEx'), 'LineEx', adapter.quote('any')) }}
select
    _airbyte_LineEx_hashid,
    {{ json_extract_scalar(unnested_column_value(adapter.quote('any')), ['nil'], ['nil']) }} as nil,
    {{ json_extract_scalar(unnested_column_value(adapter.quote('any')), ['typeSubstituted'], ['typeSubstituted']) }} as typeSubstituted,
    {{ json_extract_scalar(unnested_column_value(adapter.quote('any')), ['globalScope'], ['globalScope']) }} as globalScope,
    {{ json_extract_scalar(unnested_column_value(adapter.quote('any')), ['scope'], ['scope']) }} as scope,
    {{ json_extract_scalar(unnested_column_value(adapter.quote('any')), ['name'], ['name']) }} as name,
    {{ json_extract_scalar(unnested_column_value(adapter.quote('any')), ['declaredType'], ['declaredType']) }} as declaredType,
    {{ json_extract('', unnested_column_value(adapter.quote('any')), ['value'], ['value']) }} as value,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payments_Line_LineEx_base') }} as table_alias
-- any at payments/Line/LineEx/any
{{ cross_join_unnest('LineEx', adapter.quote('any')) }}
where 1 = 1
and {{ adapter.quote('any') }} is not null

