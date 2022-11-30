{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payments_card_details_card_payment_timeline_ab1') }}
select
    _airbyte_card_details_hashid,
    cast(voided_at as {{ dbt_utils.type_string() }}) as voided_at,
    cast(captured_at as {{ dbt_utils.type_string() }}) as captured_at,
    cast(authorized_at as {{ dbt_utils.type_string() }}) as authorized_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payments_card_details_card_payment_timeline_ab1') }}
-- card_payment_timeline at payments/card_details/card_payment_timeline
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

