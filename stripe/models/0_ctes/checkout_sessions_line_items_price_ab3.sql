{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('checkout_sessions_line_items_price_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_checkout_sessions_line_items_hashid',
        'id',
        'type',
        object_to_string('tiers'),
        boolean_to_string('active'),
        'object',
        'created',
        'product',
        'currency',
        boolean_to_string('livemode'),
        object_to_string('metadata'),
        'nickname',
        object_to_string('recurring'),
        'lookup_key',
        'tiers_mode',
        'unit_amount',
        'tax_behavior',
        'billing_scheme',
        object_to_string('transform_quantity'),
        'unit_amount_decimal',
    ]) }} as _airbyte_price_hashid,
    tmp.*
from {{ ref('checkout_sessions_line_items_price_ab2') }} tmp
-- price at checkout_sessions_line_items/price
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

