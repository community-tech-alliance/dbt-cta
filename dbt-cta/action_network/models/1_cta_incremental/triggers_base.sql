{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('triggers_ab4') }}
select
    id,
    uuid,
    title,
    step_id,
    group_id,
    ladder_id,
    permalink,
    created_at,
    updated_at,
    webhook_id,
    action_type,
    trigger_type,
    exclude_uploads,
    only_text_to_join,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_triggers_hashid
from {{ ref('triggers_ab4') }}
