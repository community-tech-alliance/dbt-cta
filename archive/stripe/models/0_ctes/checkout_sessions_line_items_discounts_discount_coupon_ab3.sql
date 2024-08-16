{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('checkout_sessions_line_items_discounts_discount_coupon_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_discount_hashid',
        'id',
        'name',
        boolean_to_string('valid'),
        'object',
        'created',
        'currency',
        'duration',
        boolean_to_string('livemode'),
        object_to_string('metadata'),
        'redeem_by',
        'amount_off',
        object_to_string('applies_to'),
        'percent_off',
        'times_redeemed',
        'max_redemptions',
        'duration_in_months',
    ]) }} as _airbyte_coupon_hashid,
    tmp.*
from {{ ref('checkout_sessions_line_items_discounts_discount_coupon_ab2') }} as tmp
-- coupon at checkout_sessions_line_items/discounts/discount/coupon
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

