{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('accounts_ParentRef_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_accounts_hashid',
        'value',
    ]) }} as _airbyte_ParentRef_hashid,
    tmp.*
from {{ ref('accounts_ParentRef_ab2') }} as tmp
-- ParentRef at accounts/ParentRef
where 1 = 1
