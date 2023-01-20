{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('deliverability_report_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(domain as {{ dbt_utils.type_string() }}) as domain,
    cast(url_path as {{ dbt_utils.type_string() }}) as url_path,
    cast(count_sent as {{ dbt_utils.type_bigint() }}) as count_sent,
    cast({{ empty_string_to_null('computed_at') }} as {{ type_timestamp_with_timezone() }}) as computed_at,
    cast(count_error as {{ dbt_utils.type_bigint() }}) as count_error,
    cast(count_total as {{ dbt_utils.type_bigint() }}) as count_total,
    cast({{ empty_string_to_null('period_ends_at') }} as {{ type_timestamp_with_timezone() }}) as period_ends_at,
    cast(count_delivered as {{ dbt_utils.type_bigint() }}) as count_delivered,
    cast({{ empty_string_to_null('period_starts_at') }} as {{ type_timestamp_with_timezone() }}) as period_starts_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('deliverability_report_ab1') }}
-- deliverability_report
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

