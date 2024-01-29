{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('transfers_reversals_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_transfers_hashid',
        'url',
        array_to_string('data'),
        'object',
        boolean_to_string('has_more'),
        'total_count',
    ]) }} as _airbyte_reversals_hashid,
    tmp.*
from {{ ref('transfers_reversals_ab2') }} as tmp
-- reversals at transfers_base/reversals
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

