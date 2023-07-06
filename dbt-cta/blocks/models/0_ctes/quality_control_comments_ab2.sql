{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('quality_control_comments_ab1') }}
select
    cast(flag_id as {{ dbt_utils.type_bigint() }}) as flag_id,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(body as {{ dbt_utils.type_string() }}) as body,
    cast(author_id as {{ dbt_utils.type_bigint() }}) as author_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('quality_control_comments_ab1') }}
-- quality_control_comments
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

