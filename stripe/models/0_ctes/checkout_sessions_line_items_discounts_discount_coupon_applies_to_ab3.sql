{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('checkout_sessions_line_items_discounts_discount_coupon_applies_to_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_coupon_hashid',
        array_to_string('products'),
    ]) }} as _airbyte_applies_to_hashid,
    tmp.*
from {{ ref('checkout_sessions_line_items_discounts_discount_coupon_applies_to_ab2') }} tmp
-- applies_to at checkout_sessions_line_items/discounts/discount/coupon/applies_to
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

