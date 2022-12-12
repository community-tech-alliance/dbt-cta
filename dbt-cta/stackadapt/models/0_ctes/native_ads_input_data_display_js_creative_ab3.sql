{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw_v2",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('native_ads_input_data_display_js_creative_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_input_data_hashid',
        'width',
        'height',
        'img_url',
        'js_code',
        boolean_to_string('is_expandable'),
        'js_code_macro',
    ]) }} as _airbyte_display_js_creative_hashid,
    tmp.*
from {{ ref('native_ads_input_data_display_js_creative_ab2') }} tmp
-- display_js_creative at native_ads/input_data/display_js_creative
where 1 = 1

