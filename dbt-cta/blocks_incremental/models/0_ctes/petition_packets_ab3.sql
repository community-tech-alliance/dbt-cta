{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('petition_packets_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'filename',
        'updated_at',
        'shift_id',
        'county',
        'created_at',
        'id',
        'assignee_id',
        'file_locator'
    ]) }} as _airbyte_petition_packets_hashid,
    tmp.*
from {{ ref('petition_packets_ab2') }} as tmp
-- petition_packets
where 1 = 1
