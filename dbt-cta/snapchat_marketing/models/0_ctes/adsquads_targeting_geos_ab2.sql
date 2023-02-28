{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('adsquads_targeting_geos_ab1') }}
select
    ad_squad_id,
    cast(country_code as {{ dbt_utils.type_string() }}) as country_code,
    cast(region_id as {{ dbt_utils.type_string() }}) as region_id,
    cast(metro as {{ dbt_utils.type_string() }}) as metro,
    cast(postal_code as {{ dbt_utils.type_string() }}) as postal_code,
    operation,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('adsquads_targeting_geos_ab1') }}
-- geos at adsquads/targeting/geos
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

