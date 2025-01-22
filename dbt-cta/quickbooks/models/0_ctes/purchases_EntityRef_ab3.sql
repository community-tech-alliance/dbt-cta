{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('purchases_EntityRef_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_purchases_hashid',
        'name',
        'type',
        'value',
    ]) }} as _airbyte_EntityRef_hashid,
    tmp.*
from {{ ref('purchases_EntityRef_ab2') }} as tmp
-- EntityRef at purchases/EntityRef
where 1 = 1
