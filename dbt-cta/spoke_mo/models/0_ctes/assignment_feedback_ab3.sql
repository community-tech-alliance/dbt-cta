{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('assignment_feedback_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'feedback',
        'assignment_id',
        boolean_to_string('is_acknowledged'),
        'creator_id',
        'created_at',
        'id',
        boolean_to_string('complete'),
    ]) }} as _airbyte_assignment_feedback_hashid,
    tmp.*
from {{ ref('assignment_feedback_ab2') }} as tmp
-- assignment_feedback
where 1 = 1
