{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('email_stats_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'stats',
        'header',
        'email_id',
        'created_at',
        'total_sent',
        'updated_at',
        'actions_count',
    ]) }} as _airbyte_email_stats_hashid,
    tmp.*
from {{ ref('email_stats_ab2') }} tmp
-- email_stats
where 1 = 1

