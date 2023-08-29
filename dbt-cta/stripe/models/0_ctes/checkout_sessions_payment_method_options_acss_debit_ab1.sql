{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('checkout_sessions_payment_method_options_base') }}
select
    _airbyte_payment_method_options_hashid,
    {{ json_extract_scalar('acss_debit', ['currency'], ['currency']) }} as currency,
    {{ json_extract('table_alias', 'acss_debit', ['mandate_options'], ['mandate_options']) }} as mandate_options,
    {{ json_extract_scalar('acss_debit', ['verification_method'], ['verification_method']) }} as verification_method,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_payment_method_options_base') }} as table_alias
-- acss_debit at checkout_sessions_base/payment_method_options/acss_debit
where
    1 = 1
    and acss_debit is not null
{{ incremental_clause('_airbyte_emitted_at') }}

