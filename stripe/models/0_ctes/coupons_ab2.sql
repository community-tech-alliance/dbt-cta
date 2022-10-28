{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('coupons_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    {{ cast_to_boolean('valid') }} as valid,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(created as {{ dbt_utils.type_bigint() }}) as created,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    cast(duration as {{ dbt_utils.type_string() }}) as duration,
    {{ cast_to_boolean('livemode') }} as livemode,
    cast(metadata as {{ type_json() }}) as metadata,
    cast(redeem_by as {{ dbt_utils.type_string() }}) as redeem_by,
    cast(amount_off as {{ dbt_utils.type_bigint() }}) as amount_off,
    cast(percent_off as {{ dbt_utils.type_float() }}) as percent_off,
    cast(times_redeemed as {{ dbt_utils.type_bigint() }}) as times_redeemed,
    cast(max_redemptions as {{ dbt_utils.type_bigint() }}) as max_redemptions,
    cast(duration_in_months as {{ dbt_utils.type_bigint() }}) as duration_in_months,
    cast(percent_off_precise as {{ dbt_utils.type_float() }}) as percent_off_precise,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('coupons_ab1') }}
-- coupons
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

