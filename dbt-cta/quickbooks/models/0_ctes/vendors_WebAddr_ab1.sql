{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('vendors_base') }}
select
    _airbyte_vendors_hashid,
    {{ json_extract_scalar('WebAddr', ['URI'], ['URI']) }} as URI,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('vendors_base') }}
-- WebAddr at vendors/WebAddr
where
    1 = 1
    and WebAddr is not null
