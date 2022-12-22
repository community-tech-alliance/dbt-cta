{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('team_member_wages') }}
select
    _airbyte_team_member_wages_hashid,
    {{ json_extract_scalar('hourly_rate', ['amount'], ['amount']) }} as amount,
    {{ json_extract_scalar('hourly_rate', ['currency'], ['currency']) }} as currency,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('team_member_wages_base') }} as table_alias
-- hourly_rate at team_member_wages/hourly_rate
where 1 = 1
and hourly_rate is not null

