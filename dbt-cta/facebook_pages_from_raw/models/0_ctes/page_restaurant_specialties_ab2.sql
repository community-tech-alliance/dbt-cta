{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('page_restaurant_specialties_ab1') }}
select
    _airbyte_page_hashid,
    cast(lunch as {{ dbt_utils.type_bigint() }}) as lunch,
    cast(coffee as {{ dbt_utils.type_bigint() }}) as coffee,
    cast(drinks as {{ dbt_utils.type_bigint() }}) as drinks,
    cast(breakfast as {{ dbt_utils.type_bigint() }}) as breakfast,
    cast(dinner as {{ dbt_utils.type_bigint() }}) as dinner,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page_restaurant_specialties_ab1') }}
-- restaurant_specialties at page/restaurant_specialties
where 1 = 1

