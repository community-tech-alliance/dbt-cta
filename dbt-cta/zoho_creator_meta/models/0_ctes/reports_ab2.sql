{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('reports_ab1') }}
select
    cast(application_link_name as {{ dbt_utils.type_string() }}) as application_link_name,
    cast(type as {{ dbt_utils.type_bigint() }}) as type,
    cast(link_name as {{ dbt_utils.type_string() }}) as link_name,
    cast(display_name as {{ dbt_utils.type_string() }}) as display_name,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('reports_ab1') }}
-- reports
where 1 = 1
