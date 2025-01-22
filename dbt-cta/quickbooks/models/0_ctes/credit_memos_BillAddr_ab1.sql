{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('credit_memos_base') }}
select
    _airbyte_credit_memos_hashid,
    {{ json_extract_scalar('BillAddr', ['Line4'], ['Line4']) }} as Line4,
    {{ json_extract_scalar('BillAddr', ['Long'], ['Long']) }} as Long,
    {{ json_extract_scalar('BillAddr', ['Id'], ['Id']) }} as Id,
    {{ json_extract_scalar('BillAddr', ['Line1'], ['Line1']) }} as Line1,
    {{ json_extract_scalar('BillAddr', ['Lat'], ['Lat']) }} as Lat,
    {{ json_extract_scalar('BillAddr', ['Line2'], ['Line2']) }} as Line2,
    {{ json_extract_scalar('BillAddr', ['Line3'], ['Line3']) }} as Line3,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('credit_memos_base') }}
-- BillAddr at credit_memos/BillAddr
where
    1 = 1
    and BillAddr is not null
