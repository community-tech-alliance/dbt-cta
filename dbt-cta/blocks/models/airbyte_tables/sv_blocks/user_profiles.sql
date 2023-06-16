{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='user_profiles_scd'
                        )
                    %}
                    {%
                        if scd_table_relation is not none
                    %}
                    {%
                            do adapter.drop_relation(scd_table_relation)
                    %}
                    {% endif %}
                        "],
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
-- user_profiles from {{ source('sv_blocks', '_airbyte_raw_user_profiles') }}
where 1 = 1

