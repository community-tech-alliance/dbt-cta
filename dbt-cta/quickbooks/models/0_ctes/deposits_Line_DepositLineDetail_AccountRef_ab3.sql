{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('deposits_Line_DepositLineDetail_AccountRef_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_DepositLineDetail_hashid',
        'name',
        'value',
    ]) }} as _airbyte_AccountRef_hashid,
    tmp.*
from {{ ref('deposits_Line_DepositLineDetail_AccountRef_ab2') }} as tmp
-- AccountRef at deposits/Line/DepositLineDetail/AccountRef
where 1 = 1
