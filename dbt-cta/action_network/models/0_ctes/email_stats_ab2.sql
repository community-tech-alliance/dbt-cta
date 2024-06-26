{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('email_stats_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(stats as {{ dbt_utils.type_string() }}) as stats,
    cast(header as {{ dbt_utils.type_string() }}) as header,
    cast(email_id as {{ dbt_utils.type_bigint() }}) as email_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(total_sent as {{ dbt_utils.type_bigint() }}) as total_sent,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(actions_count as {{ dbt_utils.type_bigint() }}) as actions_count,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('email_stats_ab1') }}
-- email_stats
where 1 = 1
