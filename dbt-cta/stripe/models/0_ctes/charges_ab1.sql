{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_charges') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract('table_alias', '_airbyte_data', ['card'], ['card']) }} as card,
    {{ json_extract_scalar('_airbyte_data', ['paid'], ['paid']) }} as paid,
    {{ json_extract_scalar('_airbyte_data', ['order'], ['order']) }} as {{ adapter.quote('order') }},
    {{ json_extract_scalar('_airbyte_data', ['amount'], ['amount']) }} as amount,
    {{ json_extract_scalar('_airbyte_data', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('_airbyte_data', ['review'], ['review']) }} as review,
    {{ json_extract('table_alias', '_airbyte_data', ['source'], ['source']) }} as source,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['created'], ['created']) }} as created,
    {{ json_extract_scalar('_airbyte_data', ['dispute'], ['dispute']) }} as dispute,
    {{ json_extract_scalar('_airbyte_data', ['invoice'], ['invoice']) }} as invoice,
    {{ json_extract('table_alias', '_airbyte_data', ['outcome'], ['outcome']) }} as outcome,
    {{ json_extract('table_alias', '_airbyte_data', ['refunds'], ['refunds']) }} as refunds,
    {{ json_extract_scalar('_airbyte_data', ['captured'], ['captured']) }} as captured,
    {{ json_extract_scalar('_airbyte_data', ['currency'], ['currency']) }} as currency,
    {{ json_extract_scalar('_airbyte_data', ['customer'], ['customer']) }} as customer,
    {{ json_extract_scalar('_airbyte_data', ['livemode'], ['livemode']) }} as livemode,
    {{ json_extract('table_alias', '_airbyte_data', ['metadata'], ['metadata']) }} as metadata,
    {{ json_extract_scalar('_airbyte_data', ['refunded'], ['refunded']) }} as refunded,
    {{ json_extract('table_alias', '_airbyte_data', ['shipping'], ['shipping']) }} as shipping,
    {{ json_extract_scalar('_airbyte_data', ['application'], ['application']) }} as application,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['destination'], ['destination']) }} as destination,
    {{ json_extract_scalar('_airbyte_data', ['failure_code'], ['failure_code']) }} as failure_code,
    {{ json_extract_scalar('_airbyte_data', ['on_behalf_of'], ['on_behalf_of']) }} as on_behalf_of,
    {{ json_extract('table_alias', '_airbyte_data', ['fraud_details'], ['fraud_details']) }} as fraud_details,
    {{ json_extract_scalar('_airbyte_data', ['receipt_email'], ['receipt_email']) }} as receipt_email,
    {{ json_extract_scalar('_airbyte_data', ['payment_intent'], ['payment_intent']) }} as payment_intent,
    {{ json_extract_scalar('_airbyte_data', ['receipt_number'], ['receipt_number']) }} as receipt_number,
    {{ json_extract_scalar('_airbyte_data', ['transfer_group'], ['transfer_group']) }} as transfer_group,
    {{ json_extract_scalar('_airbyte_data', ['amount_refunded'], ['amount_refunded']) }} as amount_refunded,
    {{ json_extract_scalar('_airbyte_data', ['application_fee'], ['application_fee']) }} as application_fee,
    {{ json_extract_scalar('_airbyte_data', ['failure_message'], ['failure_message']) }} as failure_message,
    {{ json_extract_scalar('_airbyte_data', ['source_transfer'], ['source_transfer']) }} as source_transfer,
    {{ json_extract_scalar('_airbyte_data', ['balance_transaction'], ['balance_transaction']) }} as balance_transaction,
    {{ json_extract_scalar('_airbyte_data', ['statement_descriptor'], ['statement_descriptor']) }} as statement_descriptor,
    {{ json_extract_scalar('_airbyte_data', ['statement_description'], ['statement_description']) }} as statement_description,
    {{ json_extract('table_alias', '_airbyte_data', ['payment_method_details'], ['payment_method_details']) }} as payment_method_details,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_charges') }} as table_alias
-- charges
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

