{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('people_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'gender',
        array_to_string('ethnicity'),
        'email_source',
        'interest_level',
        'prefix',
        'birth_date',
        'call_stoppage',
        'extras',
        'created_at',
        'denominations',
        'external_id',
        'issues',
        'skills',
        'search_terms',
        'mailing_address_id',
        'residential_address_id',
        'suffix_name',
        'primary_phone_number',
        boolean_to_string('requested_public_record_exception'),
        'updated_at',
        'voter_source_id',
        boolean_to_string('receives_sms'),
        'leadership_score',
        'registered_state',
        'id',
        'first_name',
        'assigned_to_user_id',
        'slug',
        'voter_status',
        'languages',
        'primary_email_address',
        'primary_language',
        'last_name',
        'middle_name',
        'external_ids',
        'registration_date',
        'best_contact_method',
        'party_id',
        'creator_id',
        'pronouns',
        'work_organization_id',
        'position',
    ]) }} as _airbyte_people_hashid,
    tmp.*
from {{ ref('people_ab2') }} tmp
-- people
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

