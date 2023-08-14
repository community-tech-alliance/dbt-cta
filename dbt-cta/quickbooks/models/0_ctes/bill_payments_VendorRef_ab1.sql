{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('bill_payments') }}
select
    _airbyte_bill_payments_hashid,
    {{ json_extract_scalar('VendorRef', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('VendorRef', ['value'], ['value']) }} as value,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('bill_payments') }} as table_alias
-- VendorRef at bill_payments/VendorRef
where 1 = 1
and VendorRef is not null

