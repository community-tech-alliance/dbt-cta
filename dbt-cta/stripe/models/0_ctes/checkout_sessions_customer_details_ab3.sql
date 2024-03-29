{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('checkout_sessions_customer_details_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_checkout_sessions_hashid',
        'email',
        'phone',
        array_to_string('tax_ids'),
        'tax_exempt',
    ]) }} as _airbyte_customer_details_hashid,
    tmp.*
from {{ ref('checkout_sessions_customer_details_ab2') }} as tmp
-- customer_details at checkout_sessions_base/customer_details
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

