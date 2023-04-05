{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('checkout_sessions_payment_method_options_acss_debit_base') }}
select
    _airbyte_acss_debit_hashid,
    {{ json_extract_string_array('mandate_options', ['default_for'], ['default_for']) }} as default_for,
    {{ json_extract_scalar('mandate_options', ['payment_schedule'], ['payment_schedule']) }} as payment_schedule,
    {{ json_extract_scalar('mandate_options', ['transaction_type'], ['transaction_type']) }} as transaction_type,
    {{ json_extract_scalar('mandate_options', ['custom_mandate_url'], ['custom_mandate_url']) }} as custom_mandate_url,
    {{ json_extract_scalar('mandate_options', ['interval_description'], ['interval_description']) }} as interval_description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_payment_method_options_acss_debit_base') }} as table_alias
-- mandate_options at checkout_sessions_base/payment_method_options/acss_debit/mandate_options
where 1 = 1
and mandate_options is not null
{{ incremental_clause('_airbyte_emitted_at') }}

