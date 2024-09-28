{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('captricity_batches_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'rejected_at',
        'submitted_at',
        'voter_registration_scan_batch_id',
        'remote_id',
        'created_at',
        'reject_reason',
        'petition_packet_id',
        'api_log',
        'imported_at',
        'updated_at',
        'petitions_book_id',
        'id',
        'status',
    ]) }} as _airbyte_captricity_batches_hashid,
    tmp.*
from {{ ref('captricity_batches_ab2') }} as tmp
-- captricity_batches
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

