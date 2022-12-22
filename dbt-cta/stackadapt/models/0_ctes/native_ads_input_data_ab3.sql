{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw_v2",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('native_ads_input_data_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_native_ads_hashid',
        'heading',
        'tagline',
        'vast_xml',
        'landing_url',
        array_to_string('audio_creatives'),
        array_to_string('video_creatives'),
        array_to_string('display_js_creative'),
    ]) }} as _airbyte_input_data_hashid,
    tmp.*
from {{ ref('native_ads_input_data_ab2') }} tmp
-- input_data at native_ads/input_data
where 1 = 1

