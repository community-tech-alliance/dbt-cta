{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- Final base SQL model
-- depends_on: {{ ref('account_native_ads_stats_creatives_ab3') }}
select
    _airbyte_account_native_ads_stats_hashid,
    url,
    size,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_creatives_hashid
from {{ ref('account_native_ads_stats_creatives_ab3') }}
-- creatives at account_native_ads_stats/creatives from {{ ref('account_native_ads_stats_base') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

