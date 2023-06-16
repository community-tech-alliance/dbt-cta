{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('canvassers_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'notes',
        'address',
        'county',
        'extras',
        'last_name',
        'created_at',
        'created_by_user_id',
        boolean_to_string('archived'),
        'updated_at',
        'turf_id',
        'organization_id',
        'vdrs',
        'phone_number',
        'id',
        'first_name',
        'slug',
        'email',
        'person_id',
    ]) }} as _airbyte_canvassers_hashid,
    tmp.*
from {{ ref('canvassers_ab2') }} tmp
-- canvassers
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

