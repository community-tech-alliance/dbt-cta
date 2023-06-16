{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    schema = "sv_blocks",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('lists_scd') }}
select
    _airbyte_unique_key,
    list_folder_id,
    query,
    search_params,
    created_at,
    repopulation_status,
    primary_emails_count,
    people_count,
    queryable,
    phones_count,
    updated_at,
    refreshed_at,
    user_id,
    name,
    id,
    households_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_lists_hashid
from {{ ref('lists_scd') }}
-- lists from {{ source('sv_blocks', '_airbyte_raw_lists') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

