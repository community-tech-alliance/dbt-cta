{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('email_activities_3_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'link_id',
        'user_id',
        'email_id',
        'group_id',
        'created_at',
        'subject_id',
        'updated_at',
        'action_type',
        'recipient_id',
        'email_stat_id',
    ]) }} as _airbyte_email_activities_3_hashid,
    tmp.*
from {{ ref('email_activities_3_ab2') }} as tmp
-- email_activities_3
where 1 = 1
