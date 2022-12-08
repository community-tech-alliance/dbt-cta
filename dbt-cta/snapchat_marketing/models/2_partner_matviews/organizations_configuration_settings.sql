{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'airbyte_configuration_settings_hashid'
) }}

SELECT
    _airbyte_configuration_settings_hashid
    ,MAX(_airbyte_organizations_hashid) as _airbyte_organizations_hashid
    ,MAX(notifications_enabled) as notifications_enabled
    ,MAX(_airbyte_ab_id) as _airbyte_ab_id
    ,MAX(_airbyte_emitted_at) as _airbyte_emitted_at
    ,MAX(_airbyte_normalized_at) as _airbyte_normalized_at
FROM {{ source('cta', 'organizations_configuration_settings_base') }}
GROUP BY _airbyte_configuration_settings_hashid
