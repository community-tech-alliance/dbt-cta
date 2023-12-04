{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_default",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('page') }}
select
    _airbyte_page_hashid,
    {{ json_extract_scalar('payment_options', ['discover'], ['discover']) }} as discover,
    {{ json_extract_scalar('payment_options', ['amex'], ['amex']) }} as amex,
    {{ json_extract_scalar('payment_options', ['cash_only'], ['cash_only']) }} as cash_only,
    {{ json_extract_scalar('payment_options', ['visa'], ['visa']) }} as visa,
    {{ json_extract_scalar('payment_options', ['mastercard'], ['mastercard']) }} as mastercard,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page') }} as table_alias
-- payment_options at page/payment_options
where 1 = 1
and payment_options is not null

