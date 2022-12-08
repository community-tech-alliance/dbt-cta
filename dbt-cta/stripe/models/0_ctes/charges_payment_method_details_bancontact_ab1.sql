{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('charges_payment_method_details_base') }}
select
    _airbyte_payment_method_details_hashid,
    {{ json_extract_scalar('bancontact', ['bic'], ['bic']) }} as bic,
    {{ json_extract_scalar('bancontact', ['bank_code'], ['bank_code']) }} as bank_code,
    {{ json_extract_scalar('bancontact', ['bank_name'], ['bank_name']) }} as bank_name,
    {{ json_extract_scalar('bancontact', ['iban_last4'], ['iban_last4']) }} as iban_last4,
    {{ json_extract_scalar('bancontact', ['verified_name'], ['verified_name']) }} as verified_name,
    {{ json_extract_scalar('bancontact', ['preferred_language'], ['preferred_language']) }} as preferred_language,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_payment_method_details_base') }} as table_alias
-- bancontact at charges_base/payment_method_details/bancontact
where 1 = 1
and bancontact is not null
{{ incremental_clause('_airbyte_emitted_at') }}

