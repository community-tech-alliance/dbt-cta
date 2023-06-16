{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    partitions = partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='quality_control_flag_triggers_ab3'
                        )
                    %}
                    {%
                        if scd_table_relation is not none
                    %}
                    {%
                            do adapter.drop_relation(scd_table_relation)
                    %}
                    {% endif %}
                        "]
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('quality_control_flag_triggers_ab3') }}
select
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
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_quality_control_flag_triggers_hashid
from {{ ref('quality_control_flag_triggers_ab3') }}
-- quality_control_flag_triggers from {{ source('sv_blocks', '_airbyte_raw_quality_control_flag_triggers') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

