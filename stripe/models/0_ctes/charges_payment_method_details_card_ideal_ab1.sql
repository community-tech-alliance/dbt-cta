{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('charges_payment_method_details_card') }}
select
    _airbyte_card_hashid,
    {{ json_extract_scalar('ideal', ['bic'], ['bic']) }} as bic,
    {{ json_extract_scalar('ideal', ['bank'], ['bank']) }} as bank,
    {{ json_extract_scalar('ideal', ['iban_last4'], ['iban_last4']) }} as iban_last4,
    {{ json_extract_scalar('ideal', ['verified_name'], ['verified_name']) }} as verified_name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_payment_method_details_card') }} as table_alias
-- ideal at charges_base/payment_method_details/card/ideal
where 1 = 1
and ideal is not null
{{ incremental_clause('_airbyte_emitted_at') }}

