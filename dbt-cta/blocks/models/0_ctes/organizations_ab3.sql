{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('organizations_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'street_address',
        'notes',
        'city',
        'extras',
        'created_at',
        'denominations',
        'leader_id',
        'issues',
        'mailing_zipcode',
        'soft_member_count',
        'updated_at',
        'turf_id',
        'id',
        'state',
        'membership_type_legacy',
        'slug',
        'membership_type',
        'mailing_city',
        'website',
        'contact_name',
        'mailing_state',
        'address_id',
        boolean_to_string('active'),
        'created_by_user_id',
        'zipcode',
        'name',
        'organization_type',
        'phone_number',
        'members_count',
        'influence_level',
        'mailing_street_address',
    ]) }} as _airbyte_organizations_hashid,
    tmp.*
from {{ ref('organizations_ab2') }} tmp
-- organizations
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

