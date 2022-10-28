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
    {{ json_extract_scalar('three_d_secure', ['version'], ['version']) }} as version,
    {{ json_extract_scalar('three_d_secure', ['succeeded'], ['succeeded']) }} as succeeded,
    {{ json_extract_scalar('three_d_secure', ['authenticated'], ['authenticated']) }} as authenticated,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_payment_method_details_card') }} as table_alias
-- three_d_secure at charges/payment_method_details/card/three_d_secure
where 1 = 1
and three_d_secure is not null
{{ incremental_clause('_airbyte_emitted_at') }}

