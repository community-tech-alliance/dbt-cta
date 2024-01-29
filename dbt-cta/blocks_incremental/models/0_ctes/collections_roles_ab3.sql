{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('collections_roles_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'collection_id',
        'role_id',
    ]) }} as _airbyte_collections_roles_hashid,
    tmp.*
from {{ ref('collections_roles_ab2') }} as tmp
-- collections_roles
where 1 = 1
