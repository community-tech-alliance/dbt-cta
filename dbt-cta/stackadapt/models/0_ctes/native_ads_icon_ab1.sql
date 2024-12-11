{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw_v2",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('native_ads_base') }}

select
    _airbyte_native_ads_hashid,
    JSON_EXTRACT_SCALAR(icon, '$.id') as id,
    JSON_EXTRACT_SCALAR(icon, '$.url') as url,
    JSON_EXTRACT_SCALAR(icon, '$.width') as width,
    JSON_EXTRACT_SCALAR(icon, '$.height') as height,
    JSON_EXTRACT_SCALAR(icon, '$.file_name') as file_name,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('native_ads_base') }}
-- icon at native_ads/icon
where icon is not null