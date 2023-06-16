{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('organization_memberships_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'member_id',
        'updated_at',
        'responsibility',
        'organization_id',
        'created_at',
        'id',
        'responsibility_id',
    ]) }} as _airbyte_organization_memberships_hashid,
    tmp.*
from {{ ref('organization_memberships_ab2') }} tmp
-- organization_memberships
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

