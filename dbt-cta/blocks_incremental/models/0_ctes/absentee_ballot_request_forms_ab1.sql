
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'absentee_ballot_request_forms') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   id,
   extras,
   gender,
   batch_id,
   shift_id,
   last_name,
   created_at,
   first_name,
   updated_at,
   us_citizen,
   election_id,
   middle_name,
   name_suffix,
   phone_number,
   request_date,
   date_of_birth,
   email_address,
   created_by_user_id,
   eligible_voting_age,
   residential_address_id,
   ballot_delivery_address_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'extras',
    'gender',
    'batch_id',
    'shift_id',
    'last_name',
    'first_name',
    'us_citizen',
    'election_id',
    'middle_name',
    'name_suffix',
    'phone_number',
    'request_date',
    'date_of_birth',
    'email_address',
    'created_by_user_id',
    'eligible_voting_age',
    'residential_address_id',
    'ballot_delivery_address_id'
    ]) }} as _airbyte_absentee_ballot_request_forms_hashid
from {{ source('cta', 'absentee_ballot_request_forms') }}