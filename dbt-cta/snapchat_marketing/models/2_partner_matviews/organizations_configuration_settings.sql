{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'organization_id'
) }}

select *
from {{ source('cta', 'organizations_configuration_settings_base') }}
