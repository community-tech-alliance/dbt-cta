{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('recordings_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'sid',
        'uri',
        'price',
        'source',
        'status',
        'call_sid',
        'channels',
        'duration',
        'media_url',
        'error_code',
        'price_unit',
        'start_time',
        'account_sid',
        'api_version',
        'date_created',
        'date_updated',
        'conference_sid',
        object_to_string('subresource_uris'),
        object_to_string('encryption_details'),
    ]) }} as _airbyte_recordings_hashid,
    tmp.*
from {{ ref('recordings_ab2') }} tmp
-- recordings
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

