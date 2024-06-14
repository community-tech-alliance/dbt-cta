{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'canvassers') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    vdrs,
    email,
    notes,
    county,
    extras,
    address,
    turf_id,
    archived,
    last_name,
    person_id,
    created_at,
    first_name,
    updated_at,
    phone_number,
    organization_id,
    created_by_user_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'vdrs',
    'email',
    'notes',
    'county',
    'extras',
    'address',
    'turf_id',
    'archived',
    'last_name',
    'person_id',
    'first_name',
    'phone_number',
    'organization_id',
    'created_by_user_id'
    ]) }} as _airbyte_canvassers_hashid
from {{ source('cta', 'canvassers') }}
