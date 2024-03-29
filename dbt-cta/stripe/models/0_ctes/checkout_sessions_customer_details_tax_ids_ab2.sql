{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('checkout_sessions_customer_details_tax_ids_ab1') }}
select
    _airbyte_customer_details_hashid,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(value as {{ dbt_utils.type_string() }}) as value,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_customer_details_tax_ids_ab1') }}
-- tax_ids at checkout_sessions_base/customer_details/tax_ids
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

