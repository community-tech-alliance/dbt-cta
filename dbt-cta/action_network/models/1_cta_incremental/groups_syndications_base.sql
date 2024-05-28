{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('groups_syndications_ab4') }}
select
    id,
    read,
    email_id,
    group_id,
    notified,
    action_id,
    created_at,
    updated_at,
    action_type,
    syndication_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_groups_syndications_hashid
from {{ ref('groups_syndications_ab4') }}