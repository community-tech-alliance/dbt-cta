{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('customers_shipping_ab1') }}
select
    _airbyte_customers_hashid,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    cast(address as {{ type_json() }}) as address,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customers_shipping_ab1') }}
-- shipping at customers/shipping
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

