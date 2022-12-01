{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('customers_address_ab1') }}
select
    _airbyte_customers_hashid,
    cast(locality as {{ dbt_utils.type_string() }}) as locality,
    cast(postal_code as {{ dbt_utils.type_string() }}) as postal_code,
    cast(address_line_1 as {{ dbt_utils.type_string() }}) as address_line_1,
    cast(address_line_2 as {{ dbt_utils.type_string() }}) as address_line_2,
    cast(administrative_district_level_1 as {{ dbt_utils.type_string() }}) as administrative_district_level_1,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customers_address_ab1') }}
-- address at customers/address
where 1 = 1

