{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('invoice_items_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'date',
        object_to_string('plan'),
        'amount',
        'object',
        object_to_string('period'),
        'invoice',
        'currency',
        'customer',
        boolean_to_string('livemode'),
        object_to_string('metadata'),
        'quantity',
        boolean_to_string('proration'),
        'description',
        'unit_amount',
        boolean_to_string('discountable'),
        'subscription',
        'subscription_item',
    ]) }} as _airbyte_invoice_items_hashid,
    tmp.*
from {{ ref('invoice_items_ab2') }} tmp
-- invoice_items
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

