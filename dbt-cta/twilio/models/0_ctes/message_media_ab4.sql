{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to get latest updated dates for each hashid
-- depends_on: {{ ref('message_media_ab3') }}
select
    _airbyte_message_media_hashid,
    min(_airbyte_emitted_at) as _airbyte_emitted_at
from {{ ref('message_media_ab3') }} tmp
-- message_media
where 1 = 1
group by _airbyte_message_media_hashid

