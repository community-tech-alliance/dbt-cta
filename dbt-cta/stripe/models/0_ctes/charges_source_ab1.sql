{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('charges_base') }}
select
    _airbyte_charges_hashid,
    {{ json_extract_scalar('source', ['id'], ['id']) }} as id,
    {{ json_extract('table_alias', 'source', ['eps'], ['eps']) }} as eps,
    {{ json_extract('table_alias', 'source', ['card'], ['card']) }} as card,
    {{ json_extract_scalar('source', ['flow'], ['flow']) }} as flow,
    {{ json_extract_scalar('source', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('source', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('source', ['brand'], ['brand']) }} as brand,
    {{ json_extract('table_alias', 'source', ['ideal'], ['ideal']) }} as ideal,
    {{ json_extract_scalar('source', ['last4'], ['last4']) }} as last4,
    {{ json_extract('table_alias', 'source', ['owner'], ['owner']) }} as owner,
    {{ json_extract_scalar('source', ['usage'], ['usage']) }} as usage,
    {{ json_extract('table_alias', 'source', ['alipay'], ['alipay']) }} as alipay,
    {{ json_extract_scalar('source', ['amount'], ['amount']) }} as amount,
    {{ json_extract_scalar('source', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('source', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('source', ['country'], ['country']) }} as country,
    {{ json_extract_scalar('source', ['created'], ['created']) }} as created,
    {{ json_extract_scalar('source', ['funding'], ['funding']) }} as funding,
    {{ json_extract_scalar('source', ['currency'], ['currency']) }} as currency,
    {{ json_extract_scalar('source', ['customer'], ['customer']) }} as customer,
    {{ json_extract_scalar('source', ['exp_year'], ['exp_year']) }} as exp_year,
    {{ json_extract_scalar('source', ['livemode'], ['livemode']) }} as livemode,
    {{ json_extract('table_alias', 'source', ['metadata'], ['metadata']) }} as metadata,
    {{ json_extract('table_alias', 'source', ['receiver'], ['receiver']) }} as receiver,
    {{ json_extract('table_alias', 'source', ['redirect'], ['redirect']) }} as redirect,
    {{ json_extract_scalar('source', ['cvc_check'], ['cvc_check']) }} as cvc_check,
    {{ json_extract_scalar('source', ['exp_month'], ['exp_month']) }} as exp_month,
    {{ json_extract('table_alias', 'source', ['bancontact'], ['bancontact']) }} as bancontact,
    {{ json_extract('table_alias', 'source', ['multibanco'], ['multibanco']) }} as multibanco,
    {{ json_extract_scalar('source', ['address_zip'], ['address_zip']) }} as address_zip,
    {{ json_extract_scalar('source', ['fingerprint'], ['fingerprint']) }} as fingerprint,
    {{ json_extract_scalar('source', ['address_city'], ['address_city']) }} as address_city,
    {{ json_extract_scalar('source', ['address_line1'], ['address_line1']) }} as address_line1,
    {{ json_extract_scalar('source', ['address_line2'], ['address_line2']) }} as address_line2,
    {{ json_extract_scalar('source', ['address_state'], ['address_state']) }} as address_state,
    {{ json_extract_scalar('source', ['client_secret'], ['client_secret']) }} as client_secret,
    {{ json_extract_scalar('source', ['dynamic_last4'], ['dynamic_last4']) }} as dynamic_last4,
    {{ json_extract_scalar('source', ['address_country'], ['address_country']) }} as address_country,
    {{ json_extract_scalar('source', ['address_zip_check'], ['address_zip_check']) }} as address_zip_check,
    {{ json_extract('table_alias', 'source', ['ach_credit_transfer'], ['ach_credit_transfer']) }} as ach_credit_transfer,
    {{ json_extract_scalar('source', ['address_line1_check'], ['address_line1_check']) }} as address_line1_check,
    {{ json_extract_scalar('source', ['tokenization_method'], ['tokenization_method']) }} as tokenization_method,
    {{ json_extract_scalar('source', ['statement_descriptor'], ['statement_descriptor']) }} as statement_descriptor,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_base') }} as table_alias
-- source at charges_base/source
where 1 = 1
and source is not null
{{ incremental_clause('_airbyte_emitted_at') }}

