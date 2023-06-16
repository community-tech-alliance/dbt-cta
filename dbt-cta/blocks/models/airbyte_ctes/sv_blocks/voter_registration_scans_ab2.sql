{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('voter_registration_scans_ab1') }}
select
    cast(remote_captricity_batch_file_id as {{ dbt_utils.type_bigint() }}) as remote_captricity_batch_file_id,
    cast(notes as {{ dbt_utils.type_string() }}) as notes,
    cast(reviewed_by_user_id as {{ dbt_utils.type_bigint() }}) as reviewed_by_user_id,
    cast(voter_registration_scan_batch_id as {{ dbt_utils.type_bigint() }}) as voter_registration_scan_batch_id,
    cast(delivery_id as {{ dbt_utils.type_bigint() }}) as delivery_id,
    cast({{ empty_string_to_null('reviewed_at') }} as {{ type_timestamp_without_timezone() }}) as reviewed_at,
    cast(county as {{ dbt_utils.type_string() }}) as county,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(jpg_data as {{ dbt_utils.type_string() }}) as jpg_data,
    cast(file_data as {{ dbt_utils.type_string() }}) as file_data,
    cast(scan_number as {{ dbt_utils.type_bigint() }}) as scan_number,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(turn_in_location_id as {{ dbt_utils.type_bigint() }}) as turn_in_location_id,
    cast(digitization_data as {{ dbt_utils.type_string() }}) as digitization_data,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('voter_registration_scans_ab1') }}
-- voter_registration_scans
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

