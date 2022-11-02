{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('email_configs_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    {{ cast_to_boolean('active') }} as active,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(to_email as {{ dbt_utils.type_string() }}) as to_email,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(product_id as {{ dbt_utils.type_bigint() }}) as product_id,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(reply_email as {{ dbt_utils.type_string() }}) as reply_email,
    {{ cast_to_boolean('primary_role') }} as primary_role,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('email_configs_ab1') }}
-- email_configs
where 1 = 1

