{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('widgets_ab1') }}
select
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(number_of_measurables as {{ dbt_utils.type_bigint() }}) as number_of_measurables,
    cast(column_span as {{ dbt_utils.type_bigint() }}) as column_span,
    cast(block_id as {{ dbt_utils.type_bigint() }}) as block_id,
    cast(widget_type as {{ dbt_utils.type_bigint() }}) as widget_type,
    cast(measurable_type as {{ dbt_utils.type_string() }}) as measurable_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('widgets_ab1') }}
-- widgets
