{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'organization_id'

) }}

-- depends_on: {{ ref('organizations_configuration_settings_ab2') }}
select
    organization_id,
    notifications_enabled,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('organizations_configuration_settings_ab2') }}
