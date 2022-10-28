{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('checkout_sessions_line_items_price_transform_quantity_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_price_hashid',
        'round',
        'divide_by',
    ]) }} as _airbyte_transform_quantity_hashid,
    tmp.*
from {{ ref('checkout_sessions_line_items_price_transform_quantity_ab2') }} tmp
-- transform_quantity at checkout_sessions_line_items/price/transform_quantity
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

