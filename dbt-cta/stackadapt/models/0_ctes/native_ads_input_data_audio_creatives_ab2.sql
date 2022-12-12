{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw_v2",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('native_ads_input_data_audio_creatives_ab1') }}
select
    _airbyte_input_data_hashid,
    cast(width as {{ dbt_utils.type_bigint() }}) as width,
    cast(height as {{ dbt_utils.type_bigint() }}) as height,
    cast(s3_url as {{ dbt_utils.type_string() }}) as s3_url,
    cast(bitrate as {{ dbt_utils.type_bigint() }}) as bitrate,
    cast(duration as {{ dbt_utils.type_float() }}) as duration,
    cast(file_type as {{ dbt_utils.type_string() }}) as file_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('native_ads_input_data_audio_creatives_ab1') }}
-- audio_creatives at native_ads/input_data/audio_creatives
where 1 = 1

