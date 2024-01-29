{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- depends_on: {{ ref('queues_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'sid',
        'uri',
        'max_size',
        'account_sid',
        'current_size',
        'date_created',
        'date_updated',
        'friendly_name',
        object_to_string('subresource_uris'),
        'average_wait_time',
    ]) }} as _airbyte_queues_hashid,
    tmp.*
from {{ ref('queues_ab2') }} as tmp
-- queues
where 1 = 1
