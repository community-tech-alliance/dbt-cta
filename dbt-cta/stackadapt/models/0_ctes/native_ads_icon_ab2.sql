{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw_v2",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('native_ads_icon_ab1') }}
select
    _airbyte_native_ads_hashid,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(url as {{ dbt_utils.type_string() }}) as url,
    cast(width as {{ dbt_utils.type_bigint() }}) as width,
    cast(height as {{ dbt_utils.type_bigint() }}) as height,
    cast(file_name as {{ dbt_utils.type_string() }}) as file_name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('native_ads_icon_ab1') }}
-- icon at native_ads/icon
where 1 = 1

