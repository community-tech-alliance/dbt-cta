{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('organizations_base') }}
select
    id as organization_id,
    {{ json_extract_scalar('configuration_settings', ['notifications_enabled'], ['notifications_enabled']) }} as notifications_enabled,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('organizations_base') }}
-- configuration_settings at organizations/configuration_settings
where
    1 = 1
    and configuration_settings is not null
