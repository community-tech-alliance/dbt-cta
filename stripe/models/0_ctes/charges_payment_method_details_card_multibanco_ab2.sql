{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('charges_payment_method_details_card_multibanco_ab1') }}
select
    _airbyte_card_hashid,
    cast(entity as {{ dbt_utils.type_string() }}) as entity,
    cast(reference as {{ dbt_utils.type_string() }}) as reference,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_payment_method_details_card_multibanco_ab1') }}
-- multibanco at charges/payment_method_details/card/multibanco
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

