{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('roles_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        boolean_to_string('needs_training'),
        boolean_to_string('admin'),
        'created_at',
        'description',
        'abilities',
        'depth',
        'updated_at',
        'parent_id',
        'permissions',
        'name',
        'id',
        'lft',
        'rgt',
        'dashboard_layout_id',
    ]) }} as _airbyte_roles_hashid,
    tmp.*
from {{ ref('roles_ab2') }} tmp
-- roles
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

