{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('locations_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(status as {{ dbt_utils.type_bigint() }}) as status,
    cast(address as {{ dbt_utils.type_string() }}) as address,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    cast(event_id as {{ dbt_utils.type_bigint() }}) as event_id,
    cast(latitude as {{ dbt_utils.type_float() }}) as latitude,
    cast(zip_code as {{ dbt_utils.type_string() }}) as zip_code,
    cast(longitude as {{ dbt_utils.type_float() }}) as longitude,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(location_name as {{ dbt_utils.type_string() }}) as location_name,
    cast(event_campaign_id as {{ dbt_utils.type_bigint() }}) as event_campaign_id,
    cast(event_campaign_upload_id as {{ dbt_utils.type_bigint() }}) as event_campaign_upload_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('locations_ab1') }}
-- locations
where 1 = 1
