{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('transfers_reversals_ab3') }}
select
    _airbyte_transfers_hashid,
    url,
    data,
    object,
    has_more,
    total_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_reversals_hashid
from {{ ref('transfers_reversals_ab3') }}
-- reversals at transfers/reversals from {{ ref('transfers') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

