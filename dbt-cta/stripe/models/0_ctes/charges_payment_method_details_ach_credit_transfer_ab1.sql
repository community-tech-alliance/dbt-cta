{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('charges_payment_method_details_base') }}
select
    _airbyte_payment_method_details_hashid,
    {{ json_extract_scalar('ach_credit_transfer', ['bank_name'], ['bank_name']) }} as bank_name,
    {{ json_extract_scalar('ach_credit_transfer', ['swift_code'], ['swift_code']) }} as swift_code,
    {{ json_extract_scalar('ach_credit_transfer', ['account_number'], ['account_number']) }} as account_number,
    {{ json_extract_scalar('ach_credit_transfer', ['routing_number'], ['routing_number']) }} as routing_number,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_payment_method_details_base') }} as table_alias
-- ach_credit_transfer at charges_base/payment_method_details/ach_credit_transfer
where 1 = 1
and ach_credit_transfer is not null
{{ incremental_clause('_airbyte_emitted_at') }}

