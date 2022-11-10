{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payment_intents_last_payment_error_ab1') }}
select
    _airbyte_payment_intents_hashid,
    cast(code as {{ dbt_utils.type_string() }}) as code,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(param as {{ dbt_utils.type_string() }}) as param,
    cast(charge as {{ dbt_utils.type_string() }}) as charge,
    cast(doc_url as {{ dbt_utils.type_string() }}) as doc_url,
    cast(message as {{ dbt_utils.type_string() }}) as message,
    cast(decline_code as {{ dbt_utils.type_string() }}) as decline_code,
    cast(payment_method as {{ type_json() }}) as payment_method,
    cast(payment_method_type as {{ dbt_utils.type_string() }}) as payment_method_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_last_payment_error_ab1') }}
-- last_payment_error at payment_intents_base/last_payment_error
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

