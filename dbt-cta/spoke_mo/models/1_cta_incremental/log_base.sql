{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('log_ab3') }}
select
    from_num,
    to_num,
    created_at,
    error_code,
    id,
    body,
    message_sid,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_log_hashid
from {{ ref('log_ab3') }}
-- log from {{ source('cta', '_airbyte_raw_log') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

