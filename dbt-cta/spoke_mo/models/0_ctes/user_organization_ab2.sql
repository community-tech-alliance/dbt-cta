{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('user_organization_ab1') }}
select
    cast(role as {{ dbt_utils.type_string() }}) as role,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(organization_id as {{ dbt_utils.type_bigint() }}) as organization_id,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('user_organization_ab1') }}
-- user_organization
where 1 = 1


