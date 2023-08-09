{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('invoices') }}
select
    _airbyte_invoices_hashid,
    {{ json_extract_scalar('CustomerRef', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('CustomerRef', ['value'], ['value']) }} as value,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('invoices') }} as table_alias
-- CustomerRef at invoices/CustomerRef
where 1 = 1
and CustomerRef is not null

