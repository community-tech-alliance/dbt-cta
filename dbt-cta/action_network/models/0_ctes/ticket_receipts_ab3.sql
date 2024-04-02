{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('ticket_receipts_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'city',
        'email',
        'phone',
        'state',
        'amount',
        'address',
        'country',
        'is_comp',
        'is_free',
        'payer_id',
        'tag_list',
        'zip_code',
        'last_name',
        'created_at',
        'first_name',
        'tip_amount',
        'updated_at',
        'checkout_id',
        'custom_amount',
        'custom_fields',
        'checkout_status',
        'stripe_charge_id',
        'wepay_account_id',
        'stripe_account_id',
        'ticketed_event_id',
        'originating_system',
    ]) }} as _airbyte_ticket_receipts_hashid,
    tmp.*
from {{ ref('ticket_receipts_ab2') }} as tmp
-- ticket_receipts
where 1 = 1
