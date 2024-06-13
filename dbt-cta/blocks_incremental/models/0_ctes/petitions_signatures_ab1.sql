
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'petitions_signatures') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   id,
   city,
   email,
   state,
   county,
   extras,
   page_id,
   zipcode,
   last_name,
   created_at,
   first_name,
   updated_at,
   address_one,
   address_two,
   line_number,
   middle_name,
   page_number,
   reviewer_id,
   phone_number,
   signature_date,
   signature_exists,
   created_by_user_id,
   voter_match_status,
   ostraka_external_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'city',
    'email',
    'state',
    'county',
    'extras',
    'page_id',
    'zipcode',
    'last_name',
    'first_name',
    'address_one',
    'address_two',
    'line_number',
    'middle_name',
    'page_number',
    'reviewer_id',
    'phone_number',
    'signature_date',
    'signature_exists',
    'created_by_user_id',
    'voter_match_status',
    'ostraka_external_id'
    ]) }} as _airbyte_petitions_signatures_hashid
from {{ source('cta', 'petitions_signatures') }}