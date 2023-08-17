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
-- depends_on: {{ ref('question_response_ab3') }}
select
    campaign_contact_id,
    created_at,
    id,
    value,
    interaction_step_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_question_response_hashid
from {{ ref('question_response_ab3') }}
-- question_response from {{ source('cta', '_airbyte_raw_question_response') }}
where 1=1

