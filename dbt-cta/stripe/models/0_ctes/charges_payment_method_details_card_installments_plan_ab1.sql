{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('charges_payment_method_details_card_installments_base') }}
select
    _airbyte_installments_hashid,
    {{ json_extract_scalar('plan', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('plan', ['count'], ['count']) }} as count,
    {{ json_extract_scalar('plan', ['interval'], ['interval']) }} as {{ adapter.quote('interval') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_payment_method_details_card_installments_base') }} as table_alias
-- plan at charges_base/payment_method_details/card/installments/plan
where 1 = 1
and plan is not null
{{ incremental_clause('_airbyte_emitted_at') }}

