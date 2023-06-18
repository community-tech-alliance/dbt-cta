{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('scheduled_exports_ab1') }}
select
    cast(day_of_the_week as {{ dbt_utils.type_string() }}) as day_of_the_week,
    {{ cast_to_boolean('paused') }} as paused,
    cast(columns as {{ dbt_utils.type_string() }}) as columns,
    cast(attachment_name as {{ dbt_utils.type_string() }}) as attachment_name,
    cast(format as {{ dbt_utils.type_string() }}) as format,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(uuid as {{ dbt_utils.type_string() }}) as uuid,
    cast(table_name as {{ dbt_utils.type_string() }}) as table_name,
    cast(frequency as {{ dbt_utils.type_string() }}) as frequency,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(time_zone_identifier as {{ dbt_utils.type_string() }}) as time_zone_identifier,
    cast(recipients as {{ dbt_utils.type_string() }}) as recipients,
    cast({{ empty_string_to_null('last_processed_at') }} as {{ type_timestamp_without_timezone() }}) as last_processed_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(hour_of_the_day as {{ dbt_utils.type_bigint() }}) as hour_of_the_day,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('scheduled_exports_ab1') }}
-- scheduled_exports
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

