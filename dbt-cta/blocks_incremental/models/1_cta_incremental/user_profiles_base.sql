{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('user_profiles_ab3') }}
select
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
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_user_profiles_hashid
from {{ ref('user_profiles_ab3') }}
-- user_profiles from {{ source('cta', '_airbyte_raw_user_profiles') }}

