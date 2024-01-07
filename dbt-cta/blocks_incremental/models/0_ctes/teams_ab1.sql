{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'teams') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    active,
    extras,
    created_at,
    leader_id,
    type,
    updated_at,
    turf_id,
    organizer_id,
    name,
    creator_id,
    members_count,
    id,
    slug,
   {{ dbt_utils.surrogate_key([
     'active',
    'extras',
    'leader_id',
    'type',
    'turf_id',
    'organizer_id',
    'name',
    'creator_id',
    'members_count',
    'id',
    'slug'
    ]) }} as _airbyte_teams_hashid
from {{ source('cta', 'teams') }}
