{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta','adsquads_targeting_base') }}
{{ unnest_cte(ref('adsquads_targeting_base'), 'targeting', 'geos') }}
select
    _airbyte_targeting_hashid,
    {{ json_extract_scalar(unnested_column_value('geos'), ['country_code'], ['country_code']) }} as country_code,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta','adsquads_targeting_base') }} as table_alias
-- geos at adsquads_base/targeting/geos
{{ cross_join_unnest('targeting', 'geos') }}
where 1 = 1
and geos is not null
{{ incremental_clause('_airbyte_emitted_at') }}

