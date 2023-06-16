{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('visual_review_responses_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'shift_type',
        boolean_to_string('implies_not_form'),
        'updated_at',
        'response',
        boolean_to_string('active'),
        'created_at',
        'description',
        'grouping_metadata',
        'id',
        boolean_to_string('implies_incomplete_form'),
    ]) }} as _airbyte_visual_review_responses_hashid,
    tmp.*
from {{ ref('visual_review_responses_ab2') }} tmp
-- visual_review_responses
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

