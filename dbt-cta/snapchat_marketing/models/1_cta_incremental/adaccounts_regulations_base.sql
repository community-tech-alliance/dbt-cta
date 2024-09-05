{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'ad_account_id'
) }}

-- depends_on: {{ ref('adaccounts_base') }}, {{ ref('adaccounts_regulations_ab3') }}
select
    ad_account_id,
    restricted_delivery_signals,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
    
from {{ ref('adaccounts_regulations_ab3') }}
