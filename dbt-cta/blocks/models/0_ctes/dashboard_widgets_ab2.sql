{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('dashboard_widgets_ab1') }}
select
    cast(widget_id as {{ dbt_utils.type_bigint() }}) as widget_id,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    measurable_ids,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(position as {{ dbt_utils.type_bigint() }}) as position,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(measurable_type as {{ dbt_utils.type_string() }}) as measurable_type,
    cast(dashboard_layout_id as {{ dbt_utils.type_bigint() }}) as dashboard_layout_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('dashboard_widgets_ab1') }}
-- dashboard_widgets
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

