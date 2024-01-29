{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('quality_control_flag_triggers_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'minimum_scan_count',
        'phone_verification_response',
        'metadata',
        boolean_to_string('stops_qc'),
        'threshold_range_in_days',
        'resource_type',
        boolean_to_string('threshold_requires_responses'),
        'default_action_plan',
        'phone_verification_question_id',
        'threshold_value',
        'name',
        'canvasser_collection_threshold',
        boolean_to_string('needs_reupload'),
        'threshold_type',
        'id',
        'visual_review_response_id',
        boolean_to_string('implies_canvasser_issue'),
    ]) }} as _airbyte_quality_control_flag_triggers_hashid,
    tmp.*
from {{ ref('quality_control_flag_triggers_ab2') }} as tmp
-- quality_control_flag_triggers
where 1 = 1
