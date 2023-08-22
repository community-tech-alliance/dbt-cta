{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('mobile_message_stats_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'stats',
        'header',
        'created_at',
        'updated_at',
        'actions_count',
        'mobile_message_id',
        'mobile_message_field_id',
    ]) }} as _airbyte_mobile_message_stats_hashid,
    tmp.*
from {{ ref('mobile_message_stats_ab2') }} as tmp
-- mobile_message_stats
where 1 = 1
