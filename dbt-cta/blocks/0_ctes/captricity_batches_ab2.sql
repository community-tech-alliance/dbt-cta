{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('captricity_batches_ab1') }}
select
    cast({{ empty_string_to_null('rejected_at') }} as {{ type_timestamp_without_timezone() }}) as rejected_at,
    cast({{ empty_string_to_null('submitted_at') }} as {{ type_timestamp_without_timezone() }}) as submitted_at,
    cast(voter_registration_scan_batch_id as {{ dbt_utils.type_bigint() }}) as voter_registration_scan_batch_id,
    cast(remote_id as {{ dbt_utils.type_bigint() }}) as remote_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(reject_reason as {{ dbt_utils.type_string() }}) as reject_reason,
    cast(petition_packet_id as {{ dbt_utils.type_bigint() }}) as petition_packet_id,
    cast(api_log as {{ dbt_utils.type_string() }}) as api_log,
    cast({{ empty_string_to_null('imported_at') }} as {{ type_timestamp_without_timezone() }}) as imported_at,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(petitions_book_id as {{ dbt_utils.type_bigint() }}) as petitions_book_id,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('captricity_batches_ab1') }}
-- captricity_batches
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

