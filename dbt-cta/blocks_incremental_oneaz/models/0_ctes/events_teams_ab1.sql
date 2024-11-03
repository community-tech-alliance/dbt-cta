{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'events_teams') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    team_id,
    event_id,
   {{ dbt_utils.surrogate_key([
     'team_id',
    'event_id'
    ]) }} as _airbyte_events_teams_hashid
from {{ source('cta', 'events_teams') }}
