{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('locations_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(mcc as {{ dbt_utils.type_string() }}) as mcc,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(address as {{ type_json() }}) as address,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    cast(timezone as {{ dbt_utils.type_string() }}) as timezone,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(merchant_id as {{ dbt_utils.type_string() }}) as merchant_id,
    cast(website_url as {{ dbt_utils.type_string() }}) as website_url,
    capabilities,
    cast(facebook_url as {{ dbt_utils.type_string() }}) as facebook_url,
    cast(phone_number as {{ dbt_utils.type_string() }}) as phone_number,
    cast(business_name as {{ dbt_utils.type_string() }}) as business_name,
    cast(language_code as {{ dbt_utils.type_string() }}) as language_code,
    cast(business_email as {{ dbt_utils.type_string() }}) as business_email,
    cast(business_hours as {{ type_json() }}) as business_hours,
    cast(twitter_username as {{ dbt_utils.type_string() }}) as twitter_username,
    cast(instagram_username as {{ dbt_utils.type_string() }}) as instagram_username,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('locations_ab1') }}
-- locations
where 1 = 1
