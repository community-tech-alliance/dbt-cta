{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('budgets_BudgetDetail_CustomerRef_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_BudgetDetail_hashid',
        'name',
        'value',
    ]) }} as _airbyte_CustomerRef_hashid,
    tmp.*
from {{ ref('budgets_BudgetDetail_CustomerRef_ab2') }} as tmp
-- CustomerRef at budgets/BudgetDetail/CustomerRef
where 1 = 1
