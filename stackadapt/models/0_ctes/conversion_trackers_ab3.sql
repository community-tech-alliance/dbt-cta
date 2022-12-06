{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_vfp_stackadapt_raw",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('conversion_trackers_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'user_id',
        'conv_type',
        'post_time',
        'count_type',
        'description',
    ]) }} as _airbyte_conversion_trackers_hashid,
    tmp.*
from {{ ref('conversion_trackers_ab2') }} tmp
-- conversion_trackers
where 1 = 1

