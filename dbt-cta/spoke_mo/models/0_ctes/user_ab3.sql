{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('user_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        boolean_to_string('terms'),
        'extra',
        'assigned_cell',
        'alias',
        'last_name',
        'created_at',
        'id',
        'cell',
        'auth0_id',
        boolean_to_string('is_superadmin'),
        'first_name',
        'email',
    ]) }} as _airbyte_user_hashid,
    tmp.*
from {{ ref('user_ab2') }} tmp
-- user
where 1 = 1


