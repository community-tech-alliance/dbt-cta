{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('invoices_base') }}
select
    _airbyte_invoices_hashid,
    {{ json_extract_scalar('BillEmail', ['Address'], ['Address']) }} as Address,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('invoices_base') }}
-- BillEmail at invoices/BillEmail
where
    1 = 1
    and BillEmail is not null
