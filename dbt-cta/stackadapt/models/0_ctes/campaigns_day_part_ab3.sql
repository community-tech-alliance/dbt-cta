{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw_v2",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaigns_day_part_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_campaigns_hashid',
        boolean_to_string('enabled'),
        'end_hour',
        'timezone',
        'start_hour',
    ]) }} as _airbyte_day_part_hashid,
    tmp.*
from {{ ref('campaigns_day_part_ab2') }} as tmp
-- day_part at campaigns_base/day_part
where 1 = 1
