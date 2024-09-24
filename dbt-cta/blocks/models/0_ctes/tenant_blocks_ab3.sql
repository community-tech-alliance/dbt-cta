{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('tenant_blocks_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'tenant_id',
        'updated_at',
        'created_at',
        'id',
        'block_id'
    ]) }} as _airbyte_tenant_blocks_hashid,
    tmp.*
from {{ ref('tenant_blocks_ab2') }} as tmp
-- tenant_blocks
where 1 = 1
