{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('page_contact_address_ab1') }}
select
    _airbyte_page_hashid,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast(street1 as {{ dbt_utils.type_string() }}) as street1,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(street2 as {{ dbt_utils.type_string() }}) as street2,
    cast(region as {{ dbt_utils.type_string() }}) as region,
    cast(postal_code as {{ dbt_utils.type_string() }}) as postal_code,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page_contact_address_ab1') }}
-- contact_address at page/contact_address
where 1 = 1

