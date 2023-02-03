{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('donations_recurring_donations_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(donation_id as {{ dbt_utils.type_bigint() }}) as donation_id,
    cast(recurring_donation_id as {{ dbt_utils.type_bigint() }}) as recurring_donation_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('donations_recurring_donations_ab1') }}
-- donations_recurring_donations
where 1 = 1

