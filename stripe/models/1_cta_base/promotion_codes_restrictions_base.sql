{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('promotion_codes_restrictions_ab3') }}
select
    _airbyte_promotion_codes_hashid,
    minimum_amount,
    first_time_transaction,
    minimum_amount_currency,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_restrictions_hashid
from {{ ref('promotion_codes_restrictions_ab3') }}
-- restrictions at promotion_codes/restrictions from {{ ref('promotion_codes') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

