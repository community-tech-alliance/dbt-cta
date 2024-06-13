
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'team_memberships') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   id,
   team_id,
   member_id,
   created_at,
   updated_at,
   responsibility,
   {{ dbt_utils.surrogate_key([
     'id',
    'team_id',
    'member_id',
    'responsibility'
    ]) }} as _airbyte_team_memberships_hashid
from {{ source('cta', 'team_memberships') }}