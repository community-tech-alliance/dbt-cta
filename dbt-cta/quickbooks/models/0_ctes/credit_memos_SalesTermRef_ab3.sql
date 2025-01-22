{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('credit_memos_SalesTermRef_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_credit_memos_hashid',
        'name',
        'value',
    ]) }} as _airbyte_SalesTermRef_hashid,
    tmp.*
from {{ ref('credit_memos_SalesTermRef_ab2') }} as tmp
-- SalesTermRef at credit_memos/SalesTermRef
where 1 = 1
