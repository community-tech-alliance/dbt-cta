{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('import_lcv_ab1') }}
select
    cast(citizen as {{ dbt_utils.type_string() }}) as citizen,
    cast(date_delivered as {{ dbt_utils.type_string() }}) as date_delivered,
    cast(address as {{ dbt_utils.type_string() }}) as address,
    cast(gender as {{ dbt_utils.type_string() }}) as gender,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast(signature as {{ dbt_utils.type_string() }}) as signature,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast(middle_name as {{ dbt_utils.type_string() }}) as middle_name,
    cast(ssn as {{ dbt_utils.type_string() }}) as ssn,
    cast(zipcode as {{ dbt_utils.type_string() }}) as zipcode,
    cast(signature_date as {{ dbt_utils.type_string() }}) as signature_date,
    cast(dob as {{ dbt_utils.type_string() }}) as dob,
    cast(organizer as {{ dbt_utils.type_string() }}) as organizer,
    cast(restored as {{ dbt_utils.type_string() }}) as restored,
    cast(location as {{ dbt_utils.type_string() }}) as location,
    cast(phone_number as {{ dbt_utils.type_string() }}) as phone_number,
    cast(region as {{ dbt_utils.type_string() }}) as region,
    cast(felony as {{ dbt_utils.type_string() }}) as felony,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('import_lcv_ab1') }}
-- import_lcv
where 1 = 1

