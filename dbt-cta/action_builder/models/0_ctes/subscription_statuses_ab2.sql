{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('subscription_statuses_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(owner_id as {{ dbt_utils.type_bigint() }}) as owner_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(owner_type as {{ dbt_utils.type_string() }}) as owner_type,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    cast(created_by_id as {{ dbt_utils.type_bigint() }}) as created_by_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('subscription_statuses_ab1') }}
-- subscription_statuses
where 1 = 1

