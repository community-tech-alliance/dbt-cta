{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('email_fields_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(text as {{ dbt_utils.type_string() }}) as text,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(email_id as {{ dbt_utils.type_bigint() }}) as email_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(field_type as {{ dbt_utils.type_string() }}) as field_type,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(builder_html as {{ dbt_utils.type_string() }}) as builder_html,
    cast(builder_json as {{ dbt_utils.type_string() }}) as builder_json,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('email_fields_ab1') }}
-- email_fields
where 1 = 1

