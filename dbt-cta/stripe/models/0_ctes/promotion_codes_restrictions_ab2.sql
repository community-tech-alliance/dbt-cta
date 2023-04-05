{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('promotion_codes_restrictions_ab1') }}
select
    _airbyte_promotion_codes_hashid,
    cast(minimum_amount as {{ dbt_utils.type_bigint() }}) as minimum_amount,
    {{ cast_to_boolean('first_time_transaction') }} as first_time_transaction,
    cast(minimum_amount_currency as {{ dbt_utils.type_string() }}) as minimum_amount_currency,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('promotion_codes_restrictions_ab1') }}
-- restrictions at promotion_codes_base/restrictions
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

