{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('canvassers_ab1') }}
select
    cast(notes as {{ dbt_utils.type_string() }}) as notes,
    cast(address as {{ dbt_utils.type_string() }}) as address,
    cast(county as {{ dbt_utils.type_string() }}) as county,
    cast(extras as {{ dbt_utils.type_string() }}) as extras,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(created_by_user_id as {{ dbt_utils.type_bigint() }}) as created_by_user_id,
    {{ cast_to_boolean('archived') }} as archived,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(turf_id as {{ dbt_utils.type_bigint() }}) as turf_id,
    cast(organization_id as {{ dbt_utils.type_bigint() }}) as organization_id,
    cast(vdrs as {{ dbt_utils.type_string() }}) as vdrs,
    cast(phone_number as {{ dbt_utils.type_string() }}) as phone_number,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast(slug as {{ dbt_utils.type_string() }}) as slug,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(person_id as {{ dbt_utils.type_bigint() }}) as person_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('canvassers_ab1') }}
-- canvassers
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

