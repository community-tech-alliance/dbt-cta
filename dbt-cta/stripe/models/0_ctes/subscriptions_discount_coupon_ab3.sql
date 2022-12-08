{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('subscriptions_discount_coupon_ab2') }}
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
        'percent_off',
        'times_redeemed',
        'max_redemptions',
        'duration_in_months',
        'percent_off_precise',
    ]) }} as _airbyte_coupon_hashid,
    tmp.*
from {{ ref('subscriptions_discount_coupon_ab2') }} tmp
-- coupon at subscriptions_base/discount/coupon
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

