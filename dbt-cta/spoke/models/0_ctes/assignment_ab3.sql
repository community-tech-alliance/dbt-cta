{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('assignment_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'user_id',
        'created_at',
        'updated_at',
        'campaign_id',
        'max_contacts',
    ]) }} as _airbyte_assignment_hashid,
    tmp.*
from {{ ref('assignment_ab2') }} tmp
-- assignment
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

