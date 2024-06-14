{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'import_lcv') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    dob,
    ssn,
    city,
    email,
    felony,
    gender,
    region,
    address,
    citizen,
    zipcode,
    location,
    restored,
    last_name,
    organizer,
    signature,
    first_name,
    middle_name,
    phone_number,
    date_delivered,
    signature_date,
   {{ dbt_utils.surrogate_key([
     'dob',
    'ssn',
    'city',
    'email',
    'felony',
    'gender',
    'region',
    'address',
    'citizen',
    'zipcode',
    'location',
    'restored',
    'last_name',
    'organizer',
    'signature',
    'first_name',
    'middle_name',
    'phone_number',
    'date_delivered',
    'signature_date'
    ]) }} as _airbyte_import_lcv_hashid
from {{ source('cta', 'import_lcv') }}
