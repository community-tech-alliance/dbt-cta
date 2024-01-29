{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('bills_Line_ItemBasedExpenseLineDetail_ItemRef_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_ItemBasedExpenseLineDetail_hashid',
        'name',
        'value',
    ]) }} as _airbyte_ItemRef_hashid,
    tmp.*
from {{ ref('bills_Line_ItemBasedExpenseLineDetail_ItemRef_ab2') }} tmp
-- ItemRef at bills/Line/ItemBasedExpenseLineDetail/ItemRef
where 1 = 1

