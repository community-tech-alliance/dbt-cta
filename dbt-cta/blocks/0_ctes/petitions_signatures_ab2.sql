{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('petitions_signatures_ab1') }}
select
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast(county as {{ dbt_utils.type_string() }}) as county,
    cast(extras as {{ dbt_utils.type_string() }}) as extras,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(address_two as {{ dbt_utils.type_string() }}) as address_two,
    cast(middle_name as {{ dbt_utils.type_string() }}) as middle_name,
    cast(created_by_user_id as {{ dbt_utils.type_bigint() }}) as created_by_user_id,
    cast(petition_packet_id as {{ dbt_utils.type_bigint() }}) as petition_packet_id,
    cast(zipcode as {{ dbt_utils.type_string() }}) as zipcode,
    cast(voter_match_status as {{ dbt_utils.type_string() }}) as voter_match_status,
    cast(page_number as {{ dbt_utils.type_bigint() }}) as page_number,
    cast({{ empty_string_to_null('signature_date') }} as {{ type_date() }}) as signature_date,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(address_one as {{ dbt_utils.type_string() }}) as address_one,
    cast(line_number as {{ dbt_utils.type_bigint() }}) as line_number,
    {{ cast_to_boolean('signature_exists') }} as signature_exists,
    cast(reviewer_id as {{ dbt_utils.type_bigint() }}) as reviewer_id,
    cast(phone_number as {{ dbt_utils.type_string() }}) as phone_number,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(petition_page_id as {{ dbt_utils.type_bigint() }}) as petition_page_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('petitions_signatures_ab1') }}
-- petitions_signatures
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

