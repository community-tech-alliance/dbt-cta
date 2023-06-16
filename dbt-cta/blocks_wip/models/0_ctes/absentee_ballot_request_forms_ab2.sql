{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('absentee_ballot_request_forms_ab1') }}
select
    cast(gender as {{ dbt_utils.type_string() }}) as gender,
    {{ cast_to_boolean('eligible_voting_age') }} as eligible_voting_age,
    cast(batch_id as {{ dbt_utils.type_bigint() }}) as batch_id,
    cast(name_suffix as {{ dbt_utils.type_string() }}) as name_suffix,
    cast({{ empty_string_to_null('date_of_birth') }} as {{ type_date() }}) as date_of_birth,
    cast(extras as {{ dbt_utils.type_string() }}) as extras,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(middle_name as {{ dbt_utils.type_string() }}) as middle_name,
    cast(created_by_user_id as {{ dbt_utils.type_bigint() }}) as created_by_user_id,
    {{ cast_to_boolean('us_citizen') }} as us_citizen,
    cast(residential_address_id as {{ dbt_utils.type_bigint() }}) as residential_address_id,
    cast(email_address as {{ dbt_utils.type_string() }}) as email_address,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(shift_id as {{ dbt_utils.type_bigint() }}) as shift_id,
    cast(election_id as {{ dbt_utils.type_string() }}) as election_id,
    cast({{ empty_string_to_null('request_date') }} as {{ type_date() }}) as request_date,
    cast(phone_number as {{ dbt_utils.type_string() }}) as phone_number,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast(ballot_delivery_address_id as {{ dbt_utils.type_bigint() }}) as ballot_delivery_address_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('absentee_ballot_request_forms_ab1') }}
-- absentee_ballot_request_forms
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

