{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('subscriptions_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(plan as {{ type_json() }}) as plan,
    cast(items as {{ type_json() }}) as items,
    cast(start as {{ dbt_utils.type_bigint() }}) as start,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(billing as {{ dbt_utils.type_string() }}) as billing,
    cast(created as {{ dbt_utils.type_bigint() }}) as created,
    cast(customer as {{ dbt_utils.type_string() }}) as customer,
    cast(discount as {{ type_json() }}) as discount,
    cast(ended_at as {{ dbt_utils.type_float() }}) as ended_at,
    {{ cast_to_boolean('livemode') }} as livemode,
    cast(metadata as {{ type_json() }}) as metadata,
    cast(quantity as {{ dbt_utils.type_bigint() }}) as quantity,
    cast(trial_end as {{ dbt_utils.type_float() }}) as trial_end,
    cast(canceled_at as {{ dbt_utils.type_float() }}) as canceled_at,
    cast(tax_percent as {{ dbt_utils.type_float() }}) as tax_percent,
    cast(trial_start as {{ dbt_utils.type_bigint() }}) as trial_start,
    cast(days_until_due as {{ dbt_utils.type_bigint() }}) as days_until_due,
    cast(current_period_end as {{ dbt_utils.type_float() }}) as current_period_end,
    cast(billing_cycle_anchor as {{ dbt_utils.type_float() }}) as billing_cycle_anchor,
    {{ cast_to_boolean('cancel_at_period_end') }} as cancel_at_period_end,
    cast(current_period_start as {{ dbt_utils.type_bigint() }}) as current_period_start,
    cast(application_fee_percent as {{ dbt_utils.type_float() }}) as application_fee_percent,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('subscriptions_ab1') }}
-- subscriptions
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

