{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payments_card_details_card_ab1') }}
select
    _airbyte_card_details_hashid,
    cast(bin as {{ dbt_utils.type_string() }}) as bin,
    cast(last_4 as {{ dbt_utils.type_string() }}) as last_4,
    cast(exp_year as {{ dbt_utils.type_bigint() }}) as exp_year,
    cast(card_type as {{ dbt_utils.type_string() }}) as card_type,
    cast(exp_month as {{ dbt_utils.type_bigint() }}) as exp_month,
    cast(card_brand as {{ dbt_utils.type_string() }}) as card_brand,
    cast(fingerprint as {{ dbt_utils.type_string() }}) as fingerprint,
    cast(prepaid_type as {{ dbt_utils.type_string() }}) as prepaid_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payments_card_details_card_ab1') }}
-- card at payments/card_details/card
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

