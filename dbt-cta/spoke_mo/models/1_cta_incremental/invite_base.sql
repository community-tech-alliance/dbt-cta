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
-- depends_on: {{ ref('invite_ab4') }}
select
    is_valid,
    created_at,
    id,
    {{ adapter.quote('hash') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_invite_hashid
from {{ ref('invite_ab4') }}
-- invite from {{ source('cta', '_airbyte_raw_invite') }}
where 1=1

