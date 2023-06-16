{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('notes_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'updated_at',
        'created_at',
        'id',
        'created_by_user_id',
        'content',
        'person_id',
    ]) }} as _airbyte_notes_hashid,
    tmp.*
from {{ ref('notes_ab2') }} tmp
-- notes
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

