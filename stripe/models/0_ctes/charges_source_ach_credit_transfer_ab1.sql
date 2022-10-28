{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('charges_source') }}
select
    _airbyte_source_hashid,
    {{ json_extract_scalar('ach_credit_transfer', ['bank_name'], ['bank_name']) }} as bank_name,
    {{ json_extract_scalar('ach_credit_transfer', ['swift_code'], ['swift_code']) }} as swift_code,
    {{ json_extract_scalar('ach_credit_transfer', ['fingerprint'], ['fingerprint']) }} as fingerprint,
    {{ json_extract_scalar('ach_credit_transfer', ['account_number'], ['account_number']) }} as account_number,
    {{ json_extract_scalar('ach_credit_transfer', ['routing_number'], ['routing_number']) }} as routing_number,
    {{ json_extract_scalar('ach_credit_transfer', ['refund_account_number'], ['refund_account_number']) }} as refund_account_number,
    {{ json_extract_scalar('ach_credit_transfer', ['refund_routing_number'], ['refund_routing_number']) }} as refund_routing_number,
    {{ json_extract_scalar('ach_credit_transfer', ['refund_account_holder_name'], ['refund_account_holder_name']) }} as refund_account_holder_name,
    {{ json_extract_scalar('ach_credit_transfer', ['refund_account_holder_type'], ['refund_account_holder_type']) }} as refund_account_holder_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_source') }} as table_alias
-- ach_credit_transfer at charges/source/ach_credit_transfer
where 1 = 1
and ach_credit_transfer is not null
{{ incremental_clause('_airbyte_emitted_at') }}

