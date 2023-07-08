{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('petition_packets_ab1') }}
select
    cast(filename as {{ dbt_utils.type_string() }}) as filename,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(shift_id as {{ dbt_utils.type_bigint() }}) as shift_id,
    cast(county as {{ dbt_utils.type_string() }}) as county,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(assignee_id as {{ dbt_utils.type_bigint() }}) as assignee_id,
    cast(file_locator as {{ dbt_utils.type_string() }}) as file_locator,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('petition_packets_ab1') }}
-- petition_packets

