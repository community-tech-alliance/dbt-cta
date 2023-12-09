{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('page_voip_info_ab1') }}
select
    _airbyte_page_hashid,
    cast(reason_code as {{ dbt_utils.type_bigint() }}) as reason_code,
    {{ cast_to_boolean('is_callable') }} as is_callable,
    {{ cast_to_boolean('has_permission') }} as has_permission,
    {{ cast_to_boolean('is_callable_webrtc') }} as is_callable_webrtc,
    {{ cast_to_boolean('is_pushable') }} as is_pushable,
    cast(reason_description as {{ dbt_utils.type_string() }}) as reason_description,
    {{ cast_to_boolean('has_mobile_app') }} as has_mobile_app,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page_voip_info_ab1') }}
-- voip_info at page/voip_info
where 1 = 1

