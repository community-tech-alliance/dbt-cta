{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('petitions_books_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'petition_book_number',
        'program_type',
        'canvasser_page_id',
        'notary_id',
        'updated_at',
        'user_id',
        'shift_id',
        'created_at',
        'id',
        'scan_file_filename',
        'scan_file_data',
        'status',
    ]) }} as _airbyte_petitions_books_hashid,
    tmp.*
from {{ ref('petitions_books_ab2') }} tmp
-- petitions_books
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

