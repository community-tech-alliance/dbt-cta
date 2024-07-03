{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw_v2",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('native_ads_input_data_display_js_creative_ab1') }}
select
    _airbyte_input_data_hashid,
    cast(width as {{ dbt_utils.type_bigint() }}) as width,
    cast(height as {{ dbt_utils.type_bigint() }}) as height,
    cast(img_url as {{ dbt_utils.type_string() }}) as img_url,
    cast(js_code as {{ dbt_utils.type_string() }}) as js_code,
    safe_cast(is_expandable as boolean) as is_expandable,
    cast(js_code_macro as {{ dbt_utils.type_string() }}) as js_code_macro,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('native_ads_input_data_display_js_creative_ab1') }}
-- display_js_creative at native_ads/input_data/display_js_creative
where 1 = 1
