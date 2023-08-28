{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('charges_source_base') }}
select
    _airbyte_source_hashid,
    {{ json_extract_scalar('card', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('card', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('card', ['brand'], ['brand']) }} as brand,
    {{ json_extract_scalar('card', ['last4'], ['last4']) }} as last4,
    {{ json_extract_scalar('card', ['country'], ['country']) }} as country,
    {{ json_extract_scalar('card', ['funding'], ['funding']) }} as funding,
    {{ json_extract_scalar('card', ['exp_year'], ['exp_year']) }} as exp_year,
    {{ json_extract_scalar('card', ['cvc_check'], ['cvc_check']) }} as cvc_check,
    {{ json_extract_scalar('card', ['exp_month'], ['exp_month']) }} as exp_month,
    {{ json_extract_scalar('card', ['fingerprint'], ['fingerprint']) }} as fingerprint,
    {{ json_extract_scalar('card', ['dynamic_last4'], ['dynamic_last4']) }} as dynamic_last4,
    {{ json_extract_scalar('card', ['three_d_secure'], ['three_d_secure']) }} as three_d_secure,
    {{ json_extract_scalar('card', ['address_zip_check'], ['address_zip_check']) }} as address_zip_check,
    {{ json_extract_scalar('card', ['address_line1_check'], ['address_line1_check']) }} as address_line1_check,
    {{ json_extract_scalar('card', ['tokenization_method'], ['tokenization_method']) }} as tokenization_method,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_source_base') }}
-- card at charges_base/source/card
where
    1 = 1
    and card is not null
{{ incremental_clause('_airbyte_emitted_at') }}

