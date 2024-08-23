{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('account_native_ads_stats_creatives_ab1') }}
select
    _airbyte_account_native_ads_stats_hashid,
    cast(url as {{ dbt_utils.type_string() }}) as url,
    cast(size as {{ dbt_utils.type_string() }}) as size,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('account_native_ads_stats_creatives_ab1') }}
-- creatives at account_native_ads_stats/creatives
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at') }}

