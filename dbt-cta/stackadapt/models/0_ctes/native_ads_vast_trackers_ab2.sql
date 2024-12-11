{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw_v2",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('native_ads_vast_trackers_ab1') }}
select
    _airbyte_native_ads_hashid,
    cast(url as {{ dbt_utils.type_string() }}) as url,
    cast(event_type as {{ dbt_utils.type_string() }}) as event_type,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('native_ads_vast_trackers_ab1') }}
-- vast_trackers at native_ads/vast_trackers
where 1 = 1
