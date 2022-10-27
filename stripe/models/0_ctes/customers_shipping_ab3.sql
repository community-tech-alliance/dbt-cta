{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('customers_shipping_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_customers_hashid',
        'name',
        'phone',
        object_to_string('address'),
    ]) }} as _airbyte_shipping_hashid,
    tmp.*
from {{ ref('customers_shipping_ab2') }} tmp
-- shipping at customers/shipping
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

