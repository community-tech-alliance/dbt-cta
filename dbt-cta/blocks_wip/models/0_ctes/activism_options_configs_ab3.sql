{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('activism_options_configs_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        array_to_string('skills'),
        array_to_string('campaigns'),
        array_to_string('languages'),
        'turf_id',
        'id',
        array_to_string('issues'),
    ]) }} as _airbyte_activism_options_configs_hashid,
    tmp.*
from {{ ref('activism_options_configs_ab2') }} tmp
-- activism_options_configs
where 1 = 1

