{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaign_admin_ab1') }}
select
    cast(ingest_method as {{ dbt_utils.type_string() }}) as ingest_method,
    cast(ingest_data_reference as {{ dbt_utils.type_string() }}) as ingest_data_reference,
    cast(deleted_optouts_count as {{ dbt_utils.type_bigint() }}) as deleted_optouts_count,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_with_timezone() }}) as updated_at,
    {{ cast_to_boolean('ingest_success') }} as ingest_success,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(ingest_result as {{ dbt_utils.type_string() }}) as ingest_result,
    cast(duplicate_contacts_count as {{ dbt_utils.type_bigint() }}) as duplicate_contacts_count,
    cast(contacts_count as {{ dbt_utils.type_bigint() }}) as contacts_count,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaign_admin_ab1') }}
-- campaign_admin
where 1 = 1


