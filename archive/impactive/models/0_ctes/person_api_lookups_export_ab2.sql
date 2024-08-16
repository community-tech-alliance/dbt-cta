{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('person_api_lookups_export_ab1') }}
select
    cast(person_lookup_id as {{ dbt_utils.type_bigint() }}) as person_lookup_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast({{ empty_string_to_null('exported_at') }} as {{ type_date() }}) as exported_at,
    cast(api_match_id as {{ dbt_utils.type_string() }}) as api_match_id,
    cast(api_username as {{ dbt_utils.type_string() }}) as api_username,
    cast(person_lookup_type as {{ dbt_utils.type_string() }}) as person_lookup_type,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(api_key as {{ dbt_utils.type_string() }}) as api_key,
    cast(api_type as {{ dbt_utils.type_string() }}) as api_type,
    {{ cast_to_boolean('success') }} as success,
    cast(van_database_mode as {{ dbt_utils.type_bigint() }}) as van_database_mode,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('person_api_lookups_export_ab1') }}
-- person_api_lookups_export
where 1 = 1

