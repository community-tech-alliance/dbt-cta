{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('purchases_Line_AccountBasedExpenseLineDetail_AccountRef_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_AccountBasedExpenseLineDetail_hashid',
        'name',
        'value',
    ]) }} as _airbyte_AccountRef_hashid,
    tmp.*
from {{ ref('purchases_Line_AccountBasedExpenseLineDetail_AccountRef_ab2') }} tmp
-- AccountRef at purchases/Line/AccountBasedExpenseLineDetail/AccountRef
where 1 = 1

