{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('turf_tags_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'tag_id',
        'created_at',
        'updated_at',
        'turf_assignment_id',
    ]) }} as _airbyte_turf_tags_hashid,
    tmp.*
from {{ ref('turf_tags_ab2') }} tmp
-- turf_tags
where 1 = 1

