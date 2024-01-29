{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- depends_on: {{ ref('transcriptions_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'sid',
        'uri',
        'type',
        'price',
        'status',
        'duration',
        'price_unit',
        'account_sid',
        'api_version',
        'date_created',
        'date_updated',
        'recording_sid',
        'transcription_text',
    ]) }} as _airbyte_transcriptions_hashid,
    tmp.*
from {{ ref('transcriptions_ab2') }} as tmp
-- transcriptions
where 1 = 1
