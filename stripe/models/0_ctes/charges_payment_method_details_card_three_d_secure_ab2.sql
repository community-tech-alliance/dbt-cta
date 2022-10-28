{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('charges_payment_method_details_card_three_d_secure_ab1') }}
select
    _airbyte_card_hashid,
    cast(version as {{ dbt_utils.type_string() }}) as version,
    {{ cast_to_boolean('succeeded') }} as succeeded,
    {{ cast_to_boolean('authenticated') }} as authenticated,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_payment_method_details_card_three_d_secure_ab1') }}
-- three_d_secure at charges/payment_method_details/card/three_d_secure
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

