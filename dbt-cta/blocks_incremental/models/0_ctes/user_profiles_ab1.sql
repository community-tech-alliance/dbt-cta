
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'user_profiles') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   facebook_url,
   gender,
   date_of_birth,
   bio,
   extras,
   created_at,
   google_url,
   updated_at,
   website_url,
   user_id,
   phone_number,
   id,
   linkedin_url,
   twitter_url,
   {{ dbt_utils.surrogate_key([
     'facebook_url',
    'gender',
    'date_of_birth',
    'bio',
    'extras',
    'google_url',
    'website_url',
    'user_id',
    'phone_number',
    'id',
    'linkedin_url',
    'twitter_url'
    ]) }} as _airbyte_user_profiles_hashid
from {{ source('cta', 'user_profiles') }}