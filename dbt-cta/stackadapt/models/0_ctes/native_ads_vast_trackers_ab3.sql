{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw_v2",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('native_ads_vast_trackers_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_native_ads_hashid',
        'url',
        'event_type',
    ]) }} as _airbyte_vast_trackers_hashid,
    tmp.*
from {{ ref('native_ads_vast_trackers_ab2') }} as tmp
-- vast_trackers at native_ads/vast_trackers
where 1 = 1
