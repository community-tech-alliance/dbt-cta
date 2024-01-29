{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('petitions_pages_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'date',
        boolean_to_string('possible_fraud'),
        'box_number',
        'notes',
        'notary_date',
        'notary_id',
        'signatures_count',
        boolean_to_string('notary_seal'),
        'petition_book_id',
        'canvasser_id',
        'county',
        'extras',
        'created_at',
        boolean_to_string('notary_signature'),
        'signers_county',
        'scan_file_data',
        'created_by_user_id',
        'scan_number',
        boolean_to_string('canvasser_signature'),
        'updated_at',
        'notary_county',
        'shift_id',
        'id',
    ]) }} as _airbyte_petitions_pages_hashid,
    tmp.*
from {{ ref('petitions_pages_ab2') }} tmp
-- petitions_pages
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

