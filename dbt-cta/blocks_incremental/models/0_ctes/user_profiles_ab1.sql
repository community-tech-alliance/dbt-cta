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
    id,
    bio,
    extras,
    gender,
    user_id,
    created_at,
    google_url,
    updated_at,
    twitter_url,
    website_url,
    facebook_url,
    linkedin_url,
    phone_number,
    date_of_birth,
   {{ dbt_utils.surrogate_key([
     'id',
    'bio',
    'extras',
    'gender',
    'user_id',
    'google_url',
    'twitter_url',
    'website_url',
    'facebook_url',
    'linkedin_url',
    'phone_number',
    'date_of_birth'
    ]) }} as _airbyte_user_profiles_hashid
from {{ source('cta', 'user_profiles') }}
