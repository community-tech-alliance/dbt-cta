{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('announcements_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'starts_at',
        'updated_at',
        'user_id',
        'created_at',
        'id',
        'ends_at',
        'message',
    ]) }} as _airbyte_announcements_hashid,
    tmp.*
from {{ ref('announcements_ab2') }} as tmp
-- announcements
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

