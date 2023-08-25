{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('checkout_sessions_shipping_address_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_shipping_hashid',
        'city',
        'line1',
        'line2',
        'state',
        'country',
        'postal_code',
    ]) }} as _airbyte_address_hashid,
    tmp.*
from {{ ref('checkout_sessions_shipping_address_ab2') }} as tmp
-- address at checkout_sessions_base/shipping/address
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

