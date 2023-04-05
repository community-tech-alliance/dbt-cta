{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payment_intents_charges_ab1') }}
select
    _airbyte_payment_intents_hashid,
    cast(url as {{ dbt_utils.type_string() }}) as url,
    data,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    {{ cast_to_boolean('has_more') }} as has_more,
    cast(total_count as {{ dbt_utils.type_bigint() }}) as total_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_charges_ab1') }}
-- charges at payment_intents_base/charges
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

