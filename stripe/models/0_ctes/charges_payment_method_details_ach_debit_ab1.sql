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
    {{ json_extract_scalar('ach_debit', ['last4'], ['last4']) }} as last4,
    {{ json_extract_scalar('ach_debit', ['country'], ['country']) }} as country,
    {{ json_extract_scalar('ach_debit', ['bank_name'], ['bank_name']) }} as bank_name,
    {{ json_extract_scalar('ach_debit', ['fingerprint'], ['fingerprint']) }} as fingerprint,
    {{ json_extract_scalar('ach_debit', ['routing_number'], ['routing_number']) }} as routing_number,
    {{ json_extract_scalar('ach_debit', ['account_holder_type'], ['account_holder_type']) }} as account_holder_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_payment_method_details_base') }} as table_alias
-- ach_debit at charges_base/payment_method_details/ach_debit
where 1 = 1
and ach_debit is not null
{{ incremental_clause('_airbyte_emitted_at') }}

