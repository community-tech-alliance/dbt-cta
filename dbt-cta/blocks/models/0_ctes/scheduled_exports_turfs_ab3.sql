{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('scheduled_exports_turfs_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'scheduled_export_id',
        'turf_id',
    ]) }} as _airbyte_scheduled_exports_turfs_hashid,
    tmp.*
from {{ ref('scheduled_exports_turfs_ab2') }} as tmp
-- scheduled_exports_turfs
where 1 = 1
