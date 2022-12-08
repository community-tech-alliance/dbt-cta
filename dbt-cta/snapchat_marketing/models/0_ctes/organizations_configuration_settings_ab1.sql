{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta','organizations_base') }}
select
    _airbyte_organizations_hashid,
    {{ json_extract_scalar('configuration_settings', ['notifications_enabled'], ['notifications_enabled']) }} as notifications_enabled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta','organizations_base') }} as table_alias
-- configuration_settings at organizations/configuration_settings
where 1 = 1
and configuration_settings is not null

