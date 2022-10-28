{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_intents_shipping_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_payment_intents_hashid',
        'name',
        'phone',
        object_to_string('address'),
        'carrier',
        'tracking_number',
    ]) }} as _airbyte_shipping_hashid,
    tmp.*
from {{ ref('payment_intents_shipping_ab2') }} tmp
-- shipping at payment_intents/shipping
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

