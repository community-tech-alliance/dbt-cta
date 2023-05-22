{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('syndications_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'uuid',
        'stats',
        'title',
        'hidden',
        'status',
        'user_id',
        'email_id',
        'group_id',
        'action_id',
        'permalink',
        'created_at',
        'updated_at',
        'action_type',
        'description',
        'first_publish',
        'salesforce_id',
        'display_creator',
        'first_permalink',
        'photo_file_name',
        'photo_file_size',
        'originating_system',
        'photo_content_type',
    ]) }} as _airbyte_syndications_hashid,
    tmp.*
from {{ ref('syndications_ab2') }} tmp
-- syndications
where 1 = 1

