{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payments_card_details_ab1') }}
select
    _airbyte_payments_hashid,
    cast(card as {{ type_json() }}) as card,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(avs_status as {{ dbt_utils.type_string() }}) as avs_status,
    cast(cvv_status as {{ dbt_utils.type_string() }}) as cvv_status,
    cast(entry_method as {{ dbt_utils.type_string() }}) as entry_method,
    cast(card_payment_timeline as {{ type_json() }}) as card_payment_timeline,
    cast(statement_description as {{ dbt_utils.type_string() }}) as statement_description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payments_card_details_ab1') }}
-- card_details at payments/card_details
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

