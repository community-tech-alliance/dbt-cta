{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('voter_registration_scan_batches_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'scans_count',
        boolean_to_string('needs_separation'),
        'qc_deadline',
        'scans_with_phones_count',
        'created_at',
        'created_by_user_id',
        'file_data',
        'separating_at',
        boolean_to_string('scans_need_delivery'),
        boolean_to_string('separating'),
        'original_filename',
        'file_hash',
        'updated_at',
        'shift_id',
        'id',
        'assignee_id',
        'file_locator',
        'van_batch_id',
    ]) }} as _airbyte_voter_registration_scan_batches_hashid,
    tmp.*
from {{ ref('voter_registration_scan_batches_ab2') }} tmp
-- voter_registration_scan_batches
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

