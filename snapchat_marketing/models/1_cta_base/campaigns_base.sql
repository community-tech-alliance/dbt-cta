{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}

-- depends_on: {{ ref('campaigns_ab3') }}
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
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_campaigns_hashid
from {{ ref('campaigns_ab3') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

