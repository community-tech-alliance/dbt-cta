{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('deposits_CurrencyRef_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_deposits_hashid',
        'name',
        'value',
    ]) }} as _airbyte_CurrencyRef_hashid,
    tmp.*
from {{ ref('deposits_CurrencyRef_ab2') }} as tmp
-- CurrencyRef at deposits/CurrencyRef
where 1 = 1
