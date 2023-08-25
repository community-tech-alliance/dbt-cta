{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('charges_payment_method_details_card_base') }}
select
    _airbyte_card_hashid,
    {{ json_extract_scalar('sepa_debit', ['last4'], ['last4']) }} as last4,
    {{ json_extract_scalar('sepa_debit', ['country'], ['country']) }} as country,
    {{ json_extract_scalar('sepa_debit', ['mandate'], ['mandate']) }} as mandate,
    {{ json_extract_scalar('sepa_debit', ['bank_code'], ['bank_code']) }} as bank_code,
    {{ json_extract_scalar('sepa_debit', ['branch_code'], ['branch_code']) }} as branch_code,
    {{ json_extract_scalar('sepa_debit', ['fingerprint'], ['fingerprint']) }} as fingerprint,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_payment_method_details_card_base') }}
-- sepa_debit at charges_base/payment_method_details/card/sepa_debit
where
    1 = 1
    and sepa_debit is not null
{{ incremental_clause('_airbyte_emitted_at') }}

