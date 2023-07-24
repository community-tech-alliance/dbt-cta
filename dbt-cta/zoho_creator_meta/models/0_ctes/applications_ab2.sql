{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('applications_ab1') }}
select
    cast(application_name as {{ dbt_utils.type_string() }}) as application_name,
    cast(date_format as {{ dbt_utils.type_string() }}) as date_format,
    cast(creation_date as {{ dbt_utils.type_string() }}) as creation_date,
    cast(category as {{ dbt_utils.type_bigint() }}) as category,
    cast(link_name as {{ dbt_utils.type_string() }}) as link_name,
    cast(time_zone as {{ dbt_utils.type_string() }}) as time_zone,
    cast(created_by as {{ dbt_utils.type_string() }}) as created_by,
    cast(workspace_name as {{ dbt_utils.type_string() }}) as workspace_name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('applications_ab1') }}
-- applications
where 1 = 1

