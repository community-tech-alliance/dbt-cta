{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('venues_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'maximum_size',
        'rooms_available',
        'updated_at',
        'name',
        'address_id',
        boolean_to_string('it_support'),
        'largest_size',
        'created_at',
        boolean_to_string('public_transportation'),
        'id',
        'parking_spots',
        boolean_to_string('hosted_event'),
    ]) }} as _airbyte_venues_hashid,
    tmp.*
from {{ ref('venues_ab2') }} tmp
-- venues
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

