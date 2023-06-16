{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('petitions_books_ab1') }}
select
    cast(petition_book_number as {{ dbt_utils.type_string() }}) as petition_book_number,
    cast(program_type as {{ dbt_utils.type_string() }}) as program_type,
    cast(canvasser_page_id as {{ dbt_utils.type_bigint() }}) as canvasser_page_id,
    cast(notary_id as {{ dbt_utils.type_bigint() }}) as notary_id,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(shift_id as {{ dbt_utils.type_bigint() }}) as shift_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(scan_file_filename as {{ dbt_utils.type_string() }}) as scan_file_filename,
    cast(scan_file_data as {{ dbt_utils.type_string() }}) as scan_file_data,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('petitions_books_ab1') }}
-- petitions_books
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

