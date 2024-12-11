{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw_v2",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('native_ads_creatives_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_native_ads_hashid',
        'id',
        'url',
        'width',
        'height',
        'file_name',
    ]) }} as _airbyte_creatives_hashid,
    tmp.*
from {{ ref('native_ads_creatives_ab2') }} as tmp
-- creatives at native_ads/creatives
where 1 = 1
