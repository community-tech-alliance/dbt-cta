{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'locations_organizations') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    organization_id,
    location_id,
   {{ dbt_utils.surrogate_key([
     'organization_id',
    'location_id'
    ]) }} as _airbyte_locations_organizations_hashid
from {{ source('cta', 'locations_organizations') }}
