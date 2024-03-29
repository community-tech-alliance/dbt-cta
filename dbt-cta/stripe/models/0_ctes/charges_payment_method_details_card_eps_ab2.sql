{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('charges_payment_method_details_card_eps_ab1') }}
select
    _airbyte_card_hashid,
    cast(verified_name as {{ dbt_utils.type_string() }}) as verified_name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_payment_method_details_card_eps_ab1') }}
-- eps at charges_base/payment_method_details/card/eps
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

