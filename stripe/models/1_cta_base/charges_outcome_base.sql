{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('charges_outcome_ab3') }}
select
    _airbyte_charges_hashid,
    type,
    reason,
    risk_level,
    risk_score,
    network_status,
    seller_message,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_outcome_hashid
from {{ ref('charges_outcome_ab3') }}
-- outcome at charges/outcome from {{ ref('charges') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

