{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('quality_control_flag_triggers_ab1') }}
select
    cast(minimum_scan_count as {{ dbt_utils.type_bigint() }}) as minimum_scan_count,
    cast(phone_verification_response as {{ dbt_utils.type_string() }}) as phone_verification_response,
    cast(metadata as {{ dbt_utils.type_string() }}) as metadata,
    {{ cast_to_boolean('stops_qc') }} as stops_qc,
    cast(threshold_range_in_days as {{ dbt_utils.type_bigint() }}) as threshold_range_in_days,
    cast(resource_type as {{ dbt_utils.type_string() }}) as resource_type,
    {{ cast_to_boolean('threshold_requires_responses') }} as threshold_requires_responses,
    cast(default_action_plan as {{ dbt_utils.type_string() }}) as default_action_plan,
    cast(phone_verification_question_id as {{ dbt_utils.type_bigint() }}) as phone_verification_question_id,
    cast(threshold_value as {{ dbt_utils.type_float() }}) as threshold_value,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(canvasser_collection_threshold as {{ dbt_utils.type_bigint() }}) as canvasser_collection_threshold,
    {{ cast_to_boolean('needs_reupload') }} as needs_reupload,
    cast(threshold_type as {{ dbt_utils.type_string() }}) as threshold_type,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(visual_review_response_id as {{ dbt_utils.type_bigint() }}) as visual_review_response_id,
    {{ cast_to_boolean('implies_canvasser_issue') }} as implies_canvasser_issue,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('quality_control_flag_triggers_ab1') }}
-- quality_control_flag_triggers
where 1 = 1

