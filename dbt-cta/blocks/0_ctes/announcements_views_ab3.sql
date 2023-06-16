{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('announcements_views_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'user_id',
        'announcement_id',
    ]) }} as _airbyte_announcements_views_hashid,
    tmp.*
from {{ ref('announcements_views_ab2') }} tmp
-- announcements_views
where 1 = 1

