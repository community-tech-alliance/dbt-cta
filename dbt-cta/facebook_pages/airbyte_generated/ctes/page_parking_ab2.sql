{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_default",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('page_parking_ab1') }}
select
    _airbyte_page_hashid,
    cast(lot as {{ dbt_utils.type_bigint() }}) as lot,
    cast(street as {{ dbt_utils.type_bigint() }}) as street,
    cast(valet as {{ dbt_utils.type_bigint() }}) as valet,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page_parking_ab1') }}
-- parking at page/parking
where 1 = 1

