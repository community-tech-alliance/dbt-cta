{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('invoice_items_plan_tiers_ab1') }}
select
    _airbyte_plan_hashid,
    cast(up_to as {{ dbt_utils.type_bigint() }}) as up_to,
    cast(flat_amount as {{ dbt_utils.type_bigint() }}) as flat_amount,
    cast(unit_amount as {{ dbt_utils.type_bigint() }}) as unit_amount,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('invoice_items_plan_tiers_ab1') }}
-- tiers at invoice_items_base/plan/tiers
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

