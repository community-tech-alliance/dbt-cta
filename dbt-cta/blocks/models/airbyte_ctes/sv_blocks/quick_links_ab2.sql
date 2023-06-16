{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('quick_links_ab1') }}
select
    cast(bg_color as {{ dbt_utils.type_string() }}) as bg_color,
    cast(size as {{ dbt_utils.type_bigint() }}) as size,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(icon as {{ dbt_utils.type_string() }}) as icon,
    cast(link as {{ dbt_utils.type_string() }}) as link,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(label as {{ dbt_utils.type_string() }}) as label,
    cast(text_color as {{ dbt_utils.type_string() }}) as text_color,
    cast(block_id as {{ dbt_utils.type_bigint() }}) as block_id,
    cast(target as {{ dbt_utils.type_string() }}) as target,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('quick_links_ab1') }}
-- quick_links
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

