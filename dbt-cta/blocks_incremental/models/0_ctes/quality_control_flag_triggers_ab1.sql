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
    minimum_scan_count,
    phone_verification_response,
    metadata,
    stops_qc,
    threshold_range_in_days,
    resource_type,
    threshold_requires_responses,
    default_action_plan,
    phone_verification_question_id,
    threshold_value,
    name,
    canvasser_collection_threshold,
    needs_reupload,
    threshold_type,
    id,
    visual_review_response_id,
    implies_canvasser_issue,
   {{ dbt_utils.surrogate_key([
     'minimum_scan_count',
    'phone_verification_response',
    'metadata',
    'stops_qc',
    'threshold_range_in_days',
    'resource_type',
    'threshold_requires_responses',
    'default_action_plan',
    'phone_verification_question_id',
    'name',
    'canvasser_collection_threshold',
    'needs_reupload',
    'threshold_type',
    'id',
    'visual_review_response_id',
    'implies_canvasser_issue'
    ]) }} as _airbyte_quality_control_flag_triggers_hashid
from {{ source('cta', 'quality_control_flag_triggers') }}
