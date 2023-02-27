{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('message_media_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'sid',
        'uri',
        'parent_sid',
        'account_sid',
        'content_type',
        'date_created',
        'date_updated',
    ]) }} as _airbyte_message_media_hashid,
    tmp.*
from {{ ref('message_media_ab2') }} tmp
-- message_media
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

