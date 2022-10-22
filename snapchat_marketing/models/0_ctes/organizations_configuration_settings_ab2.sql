{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('organizations_configuration_settings_ab1') }}
select
    _airbyte_organizations_hashid,
    {{ cast_to_boolean('notifications_enabled') }} as notifications_enabled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('organizations_configuration_settings_ab1') }}
-- configuration_settings at organizations/configuration_settings
where 1 = 1

