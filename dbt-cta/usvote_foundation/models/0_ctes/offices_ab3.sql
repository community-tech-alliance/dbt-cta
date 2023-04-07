{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('offices_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'type',
        'geoid',
        'hours',
        'notes',
        'region',
        'status',
        'updated',
        array_to_string('addresses'),
        array_to_string('officials'),
        'resource_uri',
    ]) }} as _airbyte_offices_hashid,
    tmp.*
from {{ ref('offices_ab2') }} tmp
-- offices
where 1 = 1

