{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('business_hours_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(time_zone as {{ dbt_utils.type_string() }}) as time_zone,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    {{ cast_to_boolean('is_default') }} as is_default,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(business_hours as {{ type_json() }}) as business_hours,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('business_hours_ab1') }}
-- business_hours
where 1 = 1

