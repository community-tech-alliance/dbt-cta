{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('budgets_BudgetDetail_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_budgets_hashid',
        object_to_string('ClassRef'),
        'Amount',
        object_to_string('AccountRef'),
        'BudgetDate',
        object_to_string('CustomerRef'),
        object_to_string('DepartmentRef'),
    ]) }} as _airbyte_BudgetDetail_hashid,
    tmp.*
from {{ ref('budgets_BudgetDetail_ab2') }} tmp
-- BudgetDetail at budgets/BudgetDetail
where 1 = 1

