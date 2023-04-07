{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('offices') }}
{{ unnest_cte(ref('offices'), 'offices', 'officials') }}
select
    _airbyte_offices_hashid,
    {{ json_extract_scalar(unnested_column_value('officials'), ['id'], ['id']) }} as id,
    {{ json_extract_scalar(unnested_column_value('officials'), ['fax'], ['fax']) }} as fax,
    {{ json_extract_scalar(unnested_column_value('officials'), ['email'], ['email']) }} as email,
    {{ json_extract_scalar(unnested_column_value('officials'), ['phone'], ['phone']) }} as phone,
    {{ json_extract_scalar(unnested_column_value('officials'), ['title'], ['title']) }} as title,
    {{ json_extract_scalar(unnested_column_value('officials'), ['suffix'], ['suffix']) }} as suffix,
    {{ json_extract_scalar(unnested_column_value('officials'), ['initial'], ['initial']) }} as initial,
    {{ json_extract_scalar(unnested_column_value('officials'), ['last_name'], ['last_name']) }} as last_name,
    {{ json_extract_scalar(unnested_column_value('officials'), ['first_name'], ['first_name']) }} as first_name,
    {{ json_extract_scalar(unnested_column_value('officials'), ['office_uri'], ['office_uri']) }} as office_uri,
    {{ json_extract_scalar(unnested_column_value('officials'), ['office_type'], ['office_type']) }} as office_type,
    {{ json_extract_scalar(unnested_column_value('officials'), ['resource_uri'], ['resource_uri']) }} as resource_uri,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('offices') }} as table_alias
-- officials at offices/officials
{{ cross_join_unnest('offices', 'officials') }}
where 1 = 1
and officials is not null

