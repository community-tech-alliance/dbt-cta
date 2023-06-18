{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('coorganizations_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'event_id',
        'organization_id',
    ]) }} as _airbyte_coorganizations_hashid,
    tmp.*
from {{ ref('coorganizations_ab2') }} tmp
-- coorganizations
where 1 = 1

