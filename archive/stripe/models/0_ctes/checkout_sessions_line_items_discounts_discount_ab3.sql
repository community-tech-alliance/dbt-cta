{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('checkout_sessions_line_items_discounts_discount_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_discounts_hashid',
        'id',
        adapter.quote('end'),
        'start',
        object_to_string('coupon'),
        'object',
        'invoice',
        'customer',
        'invoice_item',
        'subscription',
        'promotion_code',
        'checkout_session',
    ]) }} as _airbyte_discount_hashid,
    tmp.*
from {{ ref('checkout_sessions_line_items_discounts_discount_ab2') }} as tmp
-- discount at checkout_sessions_line_items/discounts/discount
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

