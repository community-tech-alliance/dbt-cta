{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_organizations_teams') }}
select
    {{ json_extract_scalar('_airbyte_data', ['organization_id'], ['organization_id']) }} as organization_id,
    {{ json_extract_scalar('_airbyte_data', ['team_id'], ['team_id']) }} as team_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_organizations_teams') }}
-- organizations_teams
where 1 = 1
