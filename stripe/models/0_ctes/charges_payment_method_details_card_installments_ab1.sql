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
    {{ json_extract('table_alias', 'installments', ['plan'], ['plan']) }} as plan,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_payment_method_details_card') }} as table_alias
-- installments at charges_base/payment_method_details/card/installments
where 1 = 1
and installments is not null
{{ incremental_clause('_airbyte_emitted_at') }}

