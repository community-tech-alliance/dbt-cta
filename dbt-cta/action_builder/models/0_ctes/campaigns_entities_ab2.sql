{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaigns_entities_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(entity_id as {{ dbt_utils.type_bigint() }}) as entity_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    cast(latest_assessment_id as {{ dbt_utils.type_bigint() }}) as latest_assessment_id,
    cast(latest_assessment_level as {{ dbt_utils.type_bigint() }}) as latest_assessment_level,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_entities_ab1') }}
-- campaigns_entities
where 1 = 1

