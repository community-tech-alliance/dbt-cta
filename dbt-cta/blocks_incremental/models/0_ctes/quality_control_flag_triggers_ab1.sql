{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'quality_control_flag_triggers') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    name,
    metadata,
    stops_qc,
    resource_type,
    needs_reupload,
    threshold_type,
    threshold_value,
    minimum_scan_count,
    default_action_plan,
    implies_canvasser_issue,
    threshold_range_in_days,
    visual_review_response_id,
    phone_verification_response,
    threshold_requires_responses,
    canvasser_collection_threshold,
    phone_verification_question_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'name',
    'metadata',
    'stops_qc',
    'resource_type',
    'needs_reupload',
    'threshold_type',
    'minimum_scan_count',
    'default_action_plan',
    'implies_canvasser_issue',
    'threshold_range_in_days',
    'visual_review_response_id',
    'phone_verification_response',
    'threshold_requires_responses',
    'canvasser_collection_threshold',
    'phone_verification_question_id'
    ]) }} as _airbyte_quality_control_flag_triggers_hashid
from {{ source('cta', 'quality_control_flag_triggers') }}
