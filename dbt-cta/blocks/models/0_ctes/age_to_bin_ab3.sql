{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('age_to_bin_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'label',
        'age',
    ]) }} as _airbyte_age_to_bin_hashid,
    tmp.*
from {{ ref('age_to_bin_ab2') }} tmp
-- age_to_bin
where 1 = 1

