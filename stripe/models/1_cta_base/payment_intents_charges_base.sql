{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('payment_intents_charges_ab3') }}
select
    _airbyte_payment_intents_hashid,
    url,
    data,
    object,
    has_more,
    total_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_charges_hashid
from {{ ref('payment_intents_charges_ab3') }}
-- charges at payment_intents/charges from {{ ref('payment_intents') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

