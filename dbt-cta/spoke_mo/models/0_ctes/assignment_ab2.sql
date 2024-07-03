{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('assignment_ab1') }}
select
    cast(max_contacts as {{ dbt_utils.type_bigint() }}) as max_contacts,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('assignment_ab1') }}
-- assignment
where 1 = 1


