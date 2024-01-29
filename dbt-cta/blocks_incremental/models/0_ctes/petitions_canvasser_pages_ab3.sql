{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('petitions_canvasser_pages_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        boolean_to_string('signed_in'),
        'canvasser_id',
        'sign_out_date',
        'extras',
        'created_at',
        'book_id',
        'sign_in_date',
        'scan_file_data',
        'program_type',
        'updated_at',
        boolean_to_string('signed_out'),
        'shift_id',
        'organization_id',
        'id',
    ]) }} as _airbyte_petitions_canvasser_pages_hashid,
    tmp.*
from {{ ref('petitions_canvasser_pages_ab2') }} as tmp
-- petitions_canvasser_pages
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

