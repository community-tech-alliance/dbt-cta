{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_service_charges_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_orders_hashid',
        'uid',
        'name',
        boolean_to_string('taxable'),
        object_to_string('total_money'),
        object_to_string('amount_money'),
        object_to_string('applied_money'),
        object_to_string('total_tax_money'),
        'calculation_phase',
    ]) }} as _airbyte_service_charges_hashid,
    tmp.*
from {{ ref('orders_service_charges_ab2') }} tmp
-- service_charges at orders/service_charges
where 1 = 1

