{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('actions_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'updated_at',
        'id'
    ]) }} as _airbyte_actions_hashid,
    tmp.*
from {{ ref('actions_ab2') }} tmp
-- actions
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

