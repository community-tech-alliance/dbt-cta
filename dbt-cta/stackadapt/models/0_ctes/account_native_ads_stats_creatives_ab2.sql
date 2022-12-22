{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw_v2",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('account_native_ads_stats_creatives_ab1') }}
select
    _airbyte_account_native_ads_stats_hashid,
    cast(url as {{ dbt_utils.type_string() }}) as url,
    cast(size as {{ dbt_utils.type_string() }}) as size,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('account_native_ads_stats_creatives_ab1') }}
-- creatives at account_native_ads_stats/creatives
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

