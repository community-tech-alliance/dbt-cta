{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('voter_registration_scans_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'remote_captricity_batch_file_id',
        'notes',
        'reviewed_by_user_id',
        'voter_registration_scan_batch_id',
        'delivery_id',
        'reviewed_at',
        'county',
        'created_at',
        'jpg_data',
        'file_data',
        'scan_number',
        'updated_at',
        'turn_in_location_id',
        'digitization_data',
        'id',
    ]) }} as _airbyte_voter_registration_scans_hashid,
    tmp.*
from {{ ref('voter_registration_scans_ab2') }} tmp
-- voter_registration_scans
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

