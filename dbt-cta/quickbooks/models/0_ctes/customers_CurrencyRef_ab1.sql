{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('customers_base') }}
select
    _airbyte_customers_hashid,
    {{ json_extract_scalar('CurrencyRef', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('CurrencyRef', ['value'], ['value']) }} as value,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customers_base') }}
-- CurrencyRef at customers/CurrencyRef
where
    1 = 1
    and CurrencyRef is not null
