{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('voter_registration_scan_batch_cover_sheets_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'updated_at',
        'voter_registration_scan_batch_id',
        'created_at',
        'id',
        'file_data',
    ]) }} as _airbyte_voter_registration_scan_batch_cover_sheets_hashid,
    tmp.*
from {{ ref('voter_registration_scan_batch_cover_sheets_ab2') }} tmp
-- voter_registration_scan_batch_cover_sheets
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

