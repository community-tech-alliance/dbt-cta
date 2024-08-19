{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'ad_account_id'
) }}

-- depends_on: {{ ref('adaccounts_base') }}, {{ ref('adaccounts_regulations_ab2') }}
select
    ad_account_id,
    restricted_delivery_signals,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
    
from {{ ref('adaccounts_regulations_ab2') }}
