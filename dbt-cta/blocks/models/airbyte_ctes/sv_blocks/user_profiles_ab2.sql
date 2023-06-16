{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('user_profiles_ab1') }}
select
    cast(facebook_url as {{ dbt_utils.type_string() }}) as facebook_url,
    cast(gender as {{ dbt_utils.type_string() }}) as gender,
    cast({{ empty_string_to_null('date_of_birth') }} as {{ type_date() }}) as date_of_birth,
    cast(bio as {{ dbt_utils.type_string() }}) as bio,
    cast(extras as {{ dbt_utils.type_string() }}) as extras,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(google_url as {{ dbt_utils.type_string() }}) as google_url,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(website_url as {{ dbt_utils.type_string() }}) as website_url,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(phone_number as {{ dbt_utils.type_string() }}) as phone_number,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(linkedin_url as {{ dbt_utils.type_string() }}) as linkedin_url,
    cast(twitter_url as {{ dbt_utils.type_string() }}) as twitter_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('user_profiles_ab1') }}
-- user_profiles
where 1 = 1

