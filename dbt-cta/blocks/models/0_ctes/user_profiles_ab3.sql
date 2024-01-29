{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('user_profiles_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'facebook_url',
        'gender',
        'date_of_birth',
        'bio',
        'extras',
        'created_at',
        'google_url',
        'updated_at',
        'website_url',
        'user_id',
        'phone_number',
        'id',
        'linkedin_url',
        'twitter_url',
    ]) }} as _airbyte_user_profiles_hashid,
    tmp.*
from {{ ref('user_profiles_ab2') }} tmp
-- user_profiles
where 1 = 1

