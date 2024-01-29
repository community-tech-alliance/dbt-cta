{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('donation_payments_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'tip',
        'name',
        'error',
        'amount',
        'user_id',
        'group_id',
        'wepay_id',
        'recurring',
        'created_at',
        'error_code',
        'updated_at',
        'donation_id',
        'wepay_status',
        'error_message',
        'fundraising_id',
        'transaction_id',
        'donation_user_id',
        'recurring_period',
    ]) }} as _airbyte_donation_payments_hashid,
    tmp.*
from {{ ref('donation_payments_ab2') }} as tmp
-- donation_payments
where 1 = 1
