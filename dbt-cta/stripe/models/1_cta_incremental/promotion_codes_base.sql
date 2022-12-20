{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_promotion_codes_hashid',
    schema = "stripe_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('promotion_codes_ab3') }}
select
    id,
    code,
    active,
    coupon,
    object,
    created,
    customer,
    livemode,
    metadata,
    expires_at,
    restrictions,
    max_redemptions,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_promotion_codes_hashid
from {{ ref('promotion_codes_ab3') }}
-- promotion_codes from {{ source('cta', '_airbyte_raw_promotion_codes') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

