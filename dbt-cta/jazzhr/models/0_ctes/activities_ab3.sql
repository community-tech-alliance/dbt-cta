{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('activities_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'date',
        'user_id',
        'action',
        'id',
        'time',
        'team_id',
        'category',
        'object_id',
    ]) }} as _airbyte_activities_hashid,
    tmp.*
from {{ ref('activities_ab2') }} as tmp
-- activities
where 1 = 1
