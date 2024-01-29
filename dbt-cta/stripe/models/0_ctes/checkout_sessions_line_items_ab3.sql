{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('checkout_sessions_line_items_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        object_to_string('price'),
        array_to_string('taxes'),
        'object',
        'currency',
        'quantity',
        array_to_string('discounts'),
        'description',
        'amount_total',
        'amount_subtotal',
        'checkout_session_id',
        'checkout_session_expires_at',
    ]) }} as _airbyte_checkout_sessions_line_items_hashid,
    tmp.*
from {{ ref('checkout_sessions_line_items_ab2') }} as tmp
-- checkout_sessions_line_items
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

