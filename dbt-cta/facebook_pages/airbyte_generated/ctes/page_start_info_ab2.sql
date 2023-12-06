{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_default",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('page_start_info_ab1') }}
select
    _airbyte_page_hashid,
    cast(date as {{ dbt_utils.type_string() }}) as date,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page_start_info_ab1') }}
-- start_info at page/start_info
where 1 = 1

