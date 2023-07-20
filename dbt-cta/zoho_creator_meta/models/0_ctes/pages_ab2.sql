{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('pages_ab1') }}
select
    cast(application_link_name as {{ dbt_utils.type_string() }}) as application_link_name,
    cast(link_name as {{ dbt_utils.type_string() }}) as link_name,
    cast(display_name as {{ dbt_utils.type_string() }}) as display_name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pages_ab1') }}
-- pages
where 1 = 1

