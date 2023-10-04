{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('invoice_line_items_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        object_to_string('plan'),
        'type',
        'amount',
        'object',
        object_to_string('period'),
        'invoice',
        'currency',
        boolean_to_string('livemode'),
        object_to_string('metadata'),
        'quantity',
        boolean_to_string('proration'),
        'invoice_id',
        'description',
        boolean_to_string('discountable'),
        'invoice_item',
        'subscription',
        'subscription_item',
    ]) }} as _airbyte_invoice_line_items_hashid,
    tmp.*
from {{ ref('invoice_line_items_ab2') }} as tmp
-- invoice_line_items
where 1 = 1
