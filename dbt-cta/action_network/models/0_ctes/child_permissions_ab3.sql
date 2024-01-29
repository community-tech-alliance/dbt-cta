{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('child_permissions_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'group_id',
        'hierarchy',
        'created_at',
        'updated_at',
        'permissions',
        'source_group_id',
    ]) }} as _airbyte_child_permissions_hashid,
    tmp.*
from {{ ref('child_permissions_ab2') }} as tmp
-- child_permissions
where 1 = 1
