{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('turf_assignments_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'user_id',
        'created_at',
        'updated_at',
        'campaign_id',
        boolean_to_string('restriction_enabled'),
    ]) }} as _airbyte_turf_assignments_hashid,
    tmp.*
from {{ ref('turf_assignments_ab2') }} tmp
-- turf_assignments
where 1 = 1

