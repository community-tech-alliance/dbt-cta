{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('addresses_electoral_districts_ab1') }}
select
    cast(address_id as {{ dbt_utils.type_bigint() }}) as address_id,
    cast(electoral_district_ocd_id as {{ dbt_utils.type_string() }}) as electoral_district_ocd_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('addresses_electoral_districts_ab1') }}
-- addresses_electoral_districts
where 1 = 1

