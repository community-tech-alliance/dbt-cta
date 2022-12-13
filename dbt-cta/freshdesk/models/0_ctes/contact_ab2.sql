{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('contact_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    {{ cast_to_boolean('active') }} as active,
    cast(mobile as {{ dbt_utils.type_string() }}) as mobile,
    cast(address as {{ dbt_utils.type_string() }}) as address,
    cast(language as {{ dbt_utils.type_string() }}) as language,
    cast(job_title as {{ dbt_utils.type_string() }}) as job_title,
    cast(time_zone as {{ dbt_utils.type_string() }}) as time_zone,
    cast(company_id as {{ dbt_utils.type_bigint() }}) as company_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(twitter_id as {{ dbt_utils.type_string() }}) as twitter_id,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(csat_rating as {{ dbt_utils.type_bigint() }}) as csat_rating,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(facebook_id as {{ dbt_utils.type_bigint() }}) as facebook_id,
    cast(custom_fields as {{ type_json() }}) as custom_fields,
    cast(preferred_source as {{ dbt_utils.type_string() }}) as preferred_source,
    cast(unique_external_id as {{ dbt_utils.type_string() }}) as unique_external_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('contact_ab1') }}
-- contacts
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

