{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'organization_id'
) }}

select *
from {{ source('cta', 'organizations_configuration_settings_base') }}
