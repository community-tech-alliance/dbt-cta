{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('petitions_books_scd') }}
select
    _airbyte_unique_key,
    petition_book_number,
    program_type,
    canvasser_page_id,
    notary_id,
    updated_at,
    user_id,
    shift_id,
    created_at,
    id,
    scan_file_filename,
    scan_file_data,
    status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_petitions_books_hashid
from {{ ref('petitions_books_scd') }}
-- petitions_books from {{ source('sv_blocks', '_airbyte_raw_petitions_books') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

