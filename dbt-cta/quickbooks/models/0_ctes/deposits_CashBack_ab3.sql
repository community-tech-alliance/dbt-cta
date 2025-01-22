{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('deposits_CashBack_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_deposits_hashid',
        'Amount',
        object_to_string('AccountRef'),
        'Memo',
    ]) }} as _airbyte_CashBack_hashid,
    tmp.*
from {{ ref('deposits_CashBack_ab2') }} as tmp
-- CashBack at deposits/CashBack
where 1 = 1
