{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('customers_ParentRef_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_customers_hashid',
        'value',
    ]) }} as _airbyte_ParentRef_hashid,
    tmp.*
from {{ ref('customers_ParentRef_ab2') }} tmp
-- ParentRef at customers/ParentRef
where 1 = 1

