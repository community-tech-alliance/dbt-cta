{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    materialized = "incremental",
    incremental_strategy = "merge",
    on_schema_change = "sync_all_columns",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('pending_message_part_ab4') }}
select
    service,
    parent_id,
    service_id,
    service_message,
    created_at,
    id,
    contact_number,
    user_number,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_pending_message_part_hashid
from {{ ref('pending_message_part_ab4') }}
-- pending_message_part from {{ source('cta', '_airbyte_raw_pending_message_part') }}
where 1=1

