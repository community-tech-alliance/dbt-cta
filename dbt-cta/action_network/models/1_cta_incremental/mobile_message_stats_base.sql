{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('mobile_message_stats_ab4') }}
select
    id,
    stats,
    header,
    created_at,
    updated_at,
    actions_count,
    mobile_message_id,
    mobile_message_field_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_mobile_message_stats_hashid
from {{ ref('mobile_message_stats_ab4') }}
