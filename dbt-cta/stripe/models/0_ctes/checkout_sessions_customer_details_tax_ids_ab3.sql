{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('checkout_sessions_customer_details_tax_ids_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_customer_details_hashid',
        'type',
        'value',
    ]) }} as _airbyte_tax_ids_hashid,
    tmp.*
from {{ ref('checkout_sessions_customer_details_tax_ids_ab2') }} as tmp
-- tax_ids at checkout_sessions_base/customer_details/tax_ids
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

