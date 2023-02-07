{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_usvote_foundation",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('states_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'abbr',
        'name',
        'resource_uri',
    ]) }} as _airbyte_states_hashid,
    tmp.*
from {{ ref('states_ab2') }} tmp
-- states
where 1 = 1

