{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('checkout_sessions_shipping_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_checkout_sessions_hashid',
        'name',
        object_to_string('address'),
    ]) }} as _airbyte_shipping_hashid,
    tmp.*
from {{ ref('checkout_sessions_shipping_ab2') }} tmp
-- shipping at checkout_sessions_base/shipping
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

