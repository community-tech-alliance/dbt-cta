{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw_v2",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('campaigns_base') }}
select
    _airbyte_campaigns_hashid,
    json_extract_scalar(day_part, '$.enabled') as enabled,
    json_extract_scalar(day_part, '$.end_hour') as end_hour,
    json_extract_scalar(day_part, '$.timezone') as timezone,
    json_extract_scalar(day_part, '$.start_hour') as start_hour,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_base') }}
where day_part is not null
