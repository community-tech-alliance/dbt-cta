{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('checkout_sessions_customer_details_tax_ids_ab3') }}
select
    _airbyte_customer_details_hashid,
    type,
    value,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_tax_ids_hashid
from {{ ref('checkout_sessions_customer_details_tax_ids_ab3') }}
-- tax_ids at checkout_sessions/customer_details/tax_ids from {{ ref('checkout_sessions_customer_details') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

