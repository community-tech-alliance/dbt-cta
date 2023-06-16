{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('voter_registration_scan_batches_ab1') }}
select
    cast(scans_count as {{ dbt_utils.type_bigint() }}) as scans_count,
    {{ cast_to_boolean('needs_separation') }} as needs_separation,
    cast({{ empty_string_to_null('qc_deadline') }} as {{ type_timestamp_without_timezone() }}) as qc_deadline,
    cast(scans_with_phones_count as {{ dbt_utils.type_bigint() }}) as scans_with_phones_count,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(created_by_user_id as {{ dbt_utils.type_bigint() }}) as created_by_user_id,
    cast(file_data as {{ dbt_utils.type_string() }}) as file_data,
    cast({{ empty_string_to_null('separating_at') }} as {{ type_timestamp_without_timezone() }}) as separating_at,
    {{ cast_to_boolean('scans_need_delivery') }} as scans_need_delivery,
    {{ cast_to_boolean('separating') }} as separating,
    cast(original_filename as {{ dbt_utils.type_string() }}) as original_filename,
    cast(file_hash as {{ dbt_utils.type_string() }}) as file_hash,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(shift_id as {{ dbt_utils.type_bigint() }}) as shift_id,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(assignee_id as {{ dbt_utils.type_bigint() }}) as assignee_id,
    cast(file_locator as {{ dbt_utils.type_string() }}) as file_locator,
    cast(van_batch_id as {{ dbt_utils.type_string() }}) as van_batch_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('voter_registration_scan_batches_ab1') }}
-- voter_registration_scan_batches
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

