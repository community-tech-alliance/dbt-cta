{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('user_team_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'team_id',
        'user_id',
        'created_at',
        'updated_at',
    ]) }} as _airbyte_user_team_hashid,
    tmp.*
from {{ ref('user_team_ab2') }} tmp
-- user_team
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

