{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'state',
        array_to_string('taxes'),
        object_to_string('source'),
        array_to_string('refunds'),
        array_to_string('returns'),
        array_to_string('tenders'),
        'version',
        'closed_at',
        array_to_string('discounts'),
        'created_at',
        array_to_string('line_items'),
        'updated_at',
        'location_id',
        object_to_string('net_amounts'),
        object_to_string('total_money'),
        array_to_string('fulfillments'),
        object_to_string('return_amounts'),
        array_to_string('service_charges'),
        object_to_string('total_tax_money'),
        object_to_string('total_tip_money'),
        object_to_string('total_discount_money'),
        object_to_string('total_service_charge_money'),
    ]) }} as _airbyte_orders_hashid,
    tmp.*
from {{ ref('orders_ab2') }} tmp
-- orders
where 1 = 1

