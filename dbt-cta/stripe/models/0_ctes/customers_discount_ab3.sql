{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('customers_discount_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_customers_hashid',
        adapter.quote('end'),
        'start',
        object_to_string('coupon'),
        'object',
        'customer',
        'subscription',
    ]) }} as _airbyte_discount_hashid,
    tmp.*
from {{ ref('customers_discount_ab2') }} as tmp
-- discount at customers_base/discount
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

