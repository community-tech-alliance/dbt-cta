{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('petitions_canvasser_pages_ab1') }}
select
    {{ cast_to_boolean('signed_in') }} as signed_in,
    cast(canvasser_id as {{ dbt_utils.type_bigint() }}) as canvasser_id,
    cast({{ empty_string_to_null('sign_out_date') }} as {{ type_date() }}) as sign_out_date,
    cast(extras as {{ dbt_utils.type_string() }}) as extras,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(book_id as {{ dbt_utils.type_bigint() }}) as book_id,
    cast({{ empty_string_to_null('sign_in_date') }} as {{ type_date() }}) as sign_in_date,
    cast(scan_file_data as {{ dbt_utils.type_string() }}) as scan_file_data,
    cast(program_type as {{ dbt_utils.type_bigint() }}) as program_type,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    {{ cast_to_boolean('signed_out') }} as signed_out,
    cast(shift_id as {{ dbt_utils.type_bigint() }}) as shift_id,
    cast(organization_id as {{ dbt_utils.type_bigint() }}) as organization_id,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('petitions_canvasser_pages_ab1') }}
-- petitions_canvasser_pages
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

