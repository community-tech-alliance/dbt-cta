{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('business_hours_business_hours') }}
select
    _airbyte_business_hours_2_hashid,
    {{ json_extract_scalar('wednesday', ['end_time'], ['end_time']) }} as end_time,
    {{ json_extract_scalar('wednesday', ['start_time'], ['start_time']) }} as start_time,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('business_hours_business_hours') }} as table_alias
-- wednesday at business_hours/business_hours/wednesday
where 1 = 1
and wednesday is not null

