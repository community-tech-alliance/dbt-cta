{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}

-- depends_on: {{ ref('campaigns_ab2') }}
select
    id,
    name,
    status,
    buy_model,
    objective,
    created_at,
    start_time,
    updated_at,
    ad_account_id,
    delivery_status,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_ab2') }}
