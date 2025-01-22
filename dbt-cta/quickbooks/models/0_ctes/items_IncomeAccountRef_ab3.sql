{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('items_IncomeAccountRef_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_items_hashid',
        'name',
        'value',
    ]) }} as _airbyte_IncomeAccountRef_hashid,
    tmp.*
from {{ ref('items_IncomeAccountRef_ab2') }} as tmp
-- IncomeAccountRef at items/IncomeAccountRef
where 1 = 1
