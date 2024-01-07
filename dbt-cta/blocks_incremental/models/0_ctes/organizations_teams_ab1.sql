
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'organizations_teams') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   organization_id,
   team_id,
   {{ dbt_utils.surrogate_key([
     'organization_id',
    'team_id'
    ]) }} as _airbyte_organizations_teams_hashid
from {{ source('cta', 'organizations_teams') }}