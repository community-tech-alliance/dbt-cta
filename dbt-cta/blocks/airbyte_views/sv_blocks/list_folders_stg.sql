{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('list_folders_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'updated_at',
        'user_id',
        'name',
        'created_at',
        'id',
    ]) }} as _airbyte_list_folders_hashid,
    tmp.*
from {{ ref('list_folders_ab2') }} tmp
-- list_folders
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

