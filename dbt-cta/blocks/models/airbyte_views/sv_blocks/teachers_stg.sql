{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('teachers_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'congressional_district',
        'customer_address_id',
        'city',
        'latitude',
        'state_senate_district',
        'last_name',
        'created_at',
        'address_two',
        'county_name',
        'zipcode',
        'county_fips',
        'updated_at',
        'state_house_district',
        'address_one',
        'census_block',
        'organization_id',
        'id',
        'state',
        'first_name',
        'longitude',
        'person_id',
    ]) }} as _airbyte_teachers_hashid,
    tmp.*
from {{ ref('teachers_ab2') }} tmp
-- teachers
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

