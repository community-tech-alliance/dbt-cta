{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('checkout_sessions_line_items_discounts_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_checkout_sessions_line_items_hashid',
        'amount',
        object_to_string('discount'),
    ]) }} as _airbyte_discounts_hashid,
    tmp.*
from {{ ref('checkout_sessions_line_items_discounts_ab2') }} tmp
-- discounts at checkout_sessions_line_items/discounts
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

