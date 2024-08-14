{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('charges_outcome_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_charges_hashid',
        'type',
        'reason',
        'risk_level',
        'risk_score',
        'network_status',
        'seller_message',
    ]) }} as _airbyte_outcome_hashid,
    tmp.*
from {{ ref('charges_outcome_ab2') }} as tmp
-- outcome at charges_base/outcome
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

