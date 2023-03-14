{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'organization_id'
) }}

SELECT
    *
FROM {{ source('cta', 'organizations_configuration_settings_base') }}
