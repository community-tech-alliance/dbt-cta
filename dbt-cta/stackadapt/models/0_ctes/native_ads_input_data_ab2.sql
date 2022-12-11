{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('native_ads_input_data_ab1') }}
select
    _airbyte_native_ads_hashid,
    cast(width as {{ dbt_utils.type_bigint() }}) as width,
    cast(height as {{ dbt_utils.type_bigint() }}) as height,
    cast(heading as {{ dbt_utils.type_string() }}) as heading,
    cast(img_url as {{ dbt_utils.type_string() }}) as img_url,
    cast(js_code as {{ dbt_utils.type_string() }}) as js_code,
    cast(tagline as {{ dbt_utils.type_string() }}) as tagline,
    cast(is_expandable as {{ dbt_utils.type_string() }}) as is_expandable,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('native_ads_input_data_ab1') }}
-- input_data at native_ads/input_data
where 1 = 1

