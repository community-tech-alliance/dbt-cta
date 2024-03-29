{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('checkout_sessions_base') }}
select
    _airbyte_checkout_sessions_hashid,
    {{ json_extract('table_alias', 'payment_method_options', ['oxxo'], ['oxxo']) }} as oxxo,
    {{ json_extract('table_alias', 'payment_method_options', ['boleto'], ['boleto']) }} as boleto,
    {{ json_extract('table_alias', 'payment_method_options', ['acss_debit'], ['acss_debit']) }} as acss_debit,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_base') }} as table_alias
-- payment_method_options at checkout_sessions_base/payment_method_options
where
    1 = 1
    and payment_method_options is not null
{{ incremental_clause('_airbyte_emitted_at') }}

