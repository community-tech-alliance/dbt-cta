{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('companies_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(note as {{ dbt_utils.type_string() }}) as note,
    domains,
    cast(industry as {{ dbt_utils.type_string() }}) as industry,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(account_tier as {{ dbt_utils.type_string() }}) as account_tier,
    cast(health_score as {{ dbt_utils.type_string() }}) as health_score,
    cast(renewal_date as {{ dbt_utils.type_string() }}) as renewal_date,
    cast(custom_fields as {{ type_json() }}) as custom_fields,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('companies_ab1') }}
-- companies
where 1 = 1

