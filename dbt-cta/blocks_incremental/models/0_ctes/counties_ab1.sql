{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'counties') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    updated_at,
    name,
    created_at,
    description,
    id,
    state,
   {{ dbt_utils.surrogate_key([
     'name',
    'description',
    'id',
    'state'
    ]) }} as _airbyte_counties_hashid
from {{ source('cta', 'counties') }}
