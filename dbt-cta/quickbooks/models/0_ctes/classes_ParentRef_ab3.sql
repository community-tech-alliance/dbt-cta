{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('classes_ParentRef_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_classes_hashid',
        'name',
        'value',
    ]) }} as _airbyte_ParentRef_hashid,
    tmp.*
from {{ ref('classes_ParentRef_ab2') }} as tmp
-- ParentRef at classes/ParentRef
where 1 = 1
