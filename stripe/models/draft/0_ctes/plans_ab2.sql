{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('plans_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    tiers,
    {{ cast_to_boolean('active') }} as active,
    cast(amount as {{ dbt_utils.type_bigint() }}) as amount,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(created as {{ dbt_utils.type_bigint() }}) as created,
    cast(product as {{ dbt_utils.type_string() }}) as product,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    cast({{ adapter.quote('interval') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('interval') }},
    {{ cast_to_boolean('livemode') }} as livemode,
    cast(metadata as {{ type_json() }}) as metadata,
    cast(nickname as {{ dbt_utils.type_string() }}) as nickname,
    cast(tiers_mode as {{ dbt_utils.type_string() }}) as tiers_mode,
    cast(usage_type as {{ dbt_utils.type_string() }}) as usage_type,
    cast(billing_scheme as {{ dbt_utils.type_string() }}) as billing_scheme,
    cast(interval_count as {{ dbt_utils.type_bigint() }}) as interval_count,
    cast(aggregate_usage as {{ dbt_utils.type_string() }}) as aggregate_usage,
    cast(transform_usage as {{ dbt_utils.type_string() }}) as transform_usage,
    cast(trial_period_days as {{ dbt_utils.type_bigint() }}) as trial_period_days,
    cast(statement_descriptor as {{ dbt_utils.type_string() }}) as statement_descriptor,
    cast(statement_description as {{ dbt_utils.type_string() }}) as statement_description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('plans_ab1') }}
-- plans
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

