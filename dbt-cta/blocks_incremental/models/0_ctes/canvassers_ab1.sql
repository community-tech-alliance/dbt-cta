
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
   notes,
   address,
   county,
   extras,
   last_name,
   created_at,
   created_by_user_id,
   archived,
   updated_at,
   turf_id,
   organization_id,
   vdrs,
   phone_number,
   id,
   first_name,
   email,
   person_id,
   {{ dbt_utils.surrogate_key([
     'notes',
    'address',
    'county',
    'extras',
    'last_name',
    'created_by_user_id',
    'archived',
    'turf_id',
    'organization_id',
    'vdrs',
    'phone_number',
    'id',
    'first_name',
    'email',
    'person_id'
    ]) }} as _airbyte_canvassers_hashid
from {{ source('cta', 'canvassers') }}