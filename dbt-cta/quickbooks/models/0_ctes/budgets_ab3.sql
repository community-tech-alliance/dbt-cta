{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('budgets_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'StartDate',
        'SyncToken',
        boolean_to_string('Active'),
        array_to_string('BudgetDetail'),
        object_to_string('MetaData'),
        'domain',
        'airbyte_cursor',
        'Id',
        'EndDate',
        'BudgetType',
        'Name',
        'BudgetEntryType',
    ]) }} as _airbyte_budgets_hashid,
    tmp.*
from {{ ref('budgets_ab2') }} tmp
-- budgets
where 1 = 1

