{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('subscriptions_discount_ab3') }}
select
    _airbyte_subscriptions_hashid,
    {{ adapter.quote('end') }},
    coupon,
    object,
    customer,
    start_date,
    subscription,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_discount_hashid
from {{ ref('subscriptions_discount_ab3') }}
-- discount at subscriptions/discount from {{ ref('subscriptions') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

