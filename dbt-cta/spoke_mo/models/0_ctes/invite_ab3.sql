{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('invite_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        boolean_to_string('is_valid'),
        'created_at',
        'id',
        adapter.quote('hash'),
    ]) }} as _airbyte_invite_hashid,
    tmp.*
from {{ ref('invite_ab2') }} tmp
-- invite
where 1 = 1


