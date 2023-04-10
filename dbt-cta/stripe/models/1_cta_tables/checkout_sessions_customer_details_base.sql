{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('checkout_sessions_customer_details_ab3') }}
select
    _airbyte_checkout_sessions_hashid,
    email,
    phone,
    tax_ids,
    tax_exempt,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_customer_details_hashid
from {{ ref('checkout_sessions_customer_details_ab3') }}
-- customer_details at checkout_sessions_base/customer_details from {{ ref('checkout_sessions_base') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

