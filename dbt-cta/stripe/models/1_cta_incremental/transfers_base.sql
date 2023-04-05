{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_transfers_hashid',
    
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('transfers_ab3') }}
select
    id,
    date,
    amount,
    object,
    created,
    currency,
    livemode,
    metadata,
    reversed,
    automatic,
    recipient,
    reversals,
    description,
    destination,
    source_type,
    arrival_date,
    transfer_group,
    amount_reversed,
    source_transaction,
    balance_transaction,
    statement_descriptor,
    statement_description,
    failure_balance_transaction,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_transfers_hashid
from {{ ref('transfers_ab3') }}
-- transfers from {{ source('cta', '_airbyte_raw_transfers') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

