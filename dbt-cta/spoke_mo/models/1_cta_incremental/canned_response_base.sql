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
-- depends_on: {{ ref('canned_response_ab3') }}
select
    answer_actions_data,
    user_id,
    created_at,
    answer_actions,
    id,
    text,
    title,
    campaign_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_canned_response_hashid
from {{ ref('canned_response_ab3') }}
-- canned_response from {{ source('cta', '_airbyte_raw_canned_response') }}
where 1=1

