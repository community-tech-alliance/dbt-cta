{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('charges_base') }}
select
    _airbyte_charges_hashid,
    {{ json_extract('table_alias', 'payment_method_details', ['card'], ['card']) }} as card,
    {{ json_extract_scalar('payment_method_details', ['type'], ['type']) }} as type,
    {{ json_extract('table_alias', 'payment_method_details', ['alipay'], ['alipay']) }} as alipay,
    {{ json_extract('table_alias', 'payment_method_details', ['ach_debit'], ['ach_debit']) }} as ach_debit,
    {{ json_extract('table_alias', 'payment_method_details', ['bancontact'], ['bancontact']) }} as bancontact,
    {{ json_extract('table_alias', 'payment_method_details', ['ach_credit_transfer'], ['ach_credit_transfer']) }} as ach_credit_transfer,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_base') }} as table_alias
-- payment_method_details at charges_base/payment_method_details
where 1 = 1
and payment_method_details is not null
{{ incremental_clause('_airbyte_emitted_at') }}

