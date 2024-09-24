{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('customers_Mobile_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_customers_hashid',
        'FreeFormNumber',
    ]) }} as _airbyte_Mobile_hashid,
    tmp.*
from {{ ref('customers_Mobile_ab2') }} as tmp
-- Mobile at customers/Mobile
where 1 = 1
