{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('charges_payment_method_details_card_wallet') }}
select
    _airbyte_wallet_hashid,
    {{ json_extract_scalar('masterpass', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('masterpass', ['email'], ['email']) }} as email,
    {{ json_extract('table_alias', 'masterpass', ['billing_address'], ['billing_address']) }} as billing_address,
    {{ json_extract('table_alias', 'masterpass', ['shipping_address'], ['shipping_address']) }} as shipping_address,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_payment_method_details_card_wallet') }} as table_alias
-- masterpass at charges_base/payment_method_details/card/wallet/masterpass
where 1 = 1
and masterpass is not null
{{ incremental_clause('_airbyte_emitted_at') }}

