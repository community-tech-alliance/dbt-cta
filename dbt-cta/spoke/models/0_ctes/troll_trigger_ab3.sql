{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('troll_trigger_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'mode',
        'token',
        'organization_id',
        'compiled_tsquery',
    ]) }} as _airbyte_troll_trigger_hashid,
    tmp.*
from {{ ref('troll_trigger_ab2') }} tmp
-- troll_trigger
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

