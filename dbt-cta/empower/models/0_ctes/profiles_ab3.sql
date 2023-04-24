{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('profiles_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'zip',
        'lastUsedEmpowerMts',
        'eid',
        'lastName',
        'canvassedByCtaId',
        'role',
        'notes',
        'address',
        'myCampaignVanId',
        'city',
        'address2',
        'createdMts',
        'parentEid',
        array_to_string('activeCtaIds'),
        'firstName',
        'currentCtaId',
        'vanId',
        'updatedMts',
        'phone',
        'regionId',
        'state',
        'relationship',
        'email',
    ]) }} as _airbyte_profiles_hashid,
    tmp.*
from {{ ref('profiles_ab2') }} tmp
-- profiles
where 1 = 1

