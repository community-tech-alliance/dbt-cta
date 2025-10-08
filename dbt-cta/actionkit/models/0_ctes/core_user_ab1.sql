{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'core_user') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   _airbyte_generation_id,
   id,
   zip,
   city,
   email,
   plus4,
   state,
   postal,
   prefix,
   region,
   source,
   suffix,
   country,
   lang_id,
   rand_id,
   address1,
   address2,
   password,
   last_name,
   created_at,
   first_name,
   updated_at,
   middle_name,
   email_domain,
   subscription_status
from {{ source('cta', 'core_user') }}
