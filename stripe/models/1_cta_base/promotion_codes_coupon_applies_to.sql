{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('promotion_codes_coupon_applies_to_ab3') }}
select
    _airbyte_coupon_hashid,
    products,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_applies_to_hashid
from {{ ref('promotion_codes_coupon_applies_to_ab3') }}
-- applies_to at promotion_codes/coupon/applies_to from {{ ref('promotion_codes_coupon') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

