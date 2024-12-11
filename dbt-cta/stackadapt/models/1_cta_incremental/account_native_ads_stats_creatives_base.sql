{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- Final base SQL model
-- depends_on: {{ ref('account_native_ads_stats_creatives_ab4') }}
select
    _airbyte_account_native_ads_stats_hashid,
    url,
    size,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_creatives_hashid
from {{ ref('account_native_ads_stats_creatives_ab4') }}
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at') }}

