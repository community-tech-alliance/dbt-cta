{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw_v2",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('account_native_ads_stats') }}
{{ unnest_cte(ref('account_native_ads_stats'), 'account_native_ads_stats', 'creatives') }}
select
    _airbyte_account_native_ads_stats_hashid,
    {{ json_extract_scalar(unnested_column_value('creatives'), ['url'], ['url']) }} as url,
    {{ json_extract_scalar(unnested_column_value('creatives'), ['size'], ['size']) }} as size,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('account_native_ads_stats') }} as table_alias
-- creatives at account_native_ads_stats/creatives
{{ cross_join_unnest('account_native_ads_stats', 'creatives') }}
where 1 = 1
and creatives is not null
{{ incremental_clause('_airbyte_emitted_at') }}

