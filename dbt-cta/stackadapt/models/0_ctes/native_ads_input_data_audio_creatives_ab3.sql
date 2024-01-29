{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw_v2",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('native_ads_input_data_audio_creatives_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_input_data_hashid',
        'width',
        'height',
        's3_url',
        'bitrate',
        'duration',
        'file_type',
    ]) }} as _airbyte_audio_creatives_hashid,
    tmp.*
from {{ ref('native_ads_input_data_audio_creatives_ab2') }} as tmp
-- audio_creatives at native_ads/input_data/audio_creatives
where 1 = 1
