{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('registration_forms_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'distance_from_location',
        'metadata',
        boolean_to_string('eligible_voting_age'),
        'county',
        boolean_to_string('social_security'),
        'uuid',
        'pledge_card_data',
        'score',
        'identification',
        'voting_state',
        'id',
        boolean_to_string('state_id'),
        'longitude',
        'person_id',
        'ovr_status',
        boolean_to_string('hard_copy_collected'),
        'mailing_street_address_two',
        boolean_to_string('completed'),
        'created_by_user_id',
        'registration_date',
        boolean_to_string('secondary_identification'),
        'voting_city',
        'phone_number',
        'form_number',
        'party',
        boolean_to_string('contacted_voter'),
        'mailing_street_address_one',
        'gender',
        'ethnicity',
        boolean_to_string('signature'),
        'date_of_birth',
        'latitude',
        'delivery_id',
        'extras',
        'created_at',
        'voting_street_address_two',
        'voting_zipcode',
        'mailing_zipcode',
        'registration_type',
        array_to_string('redacted_fields'),
        'van_id',
        'name_prefix',
        'updated_at',
        'shift_id',
        'first_name',
        boolean_to_string('online_registration'),
        'por_data',
        'mailing_city',
        'mailing_state',
        'voting_street_address_one',
        'name_suffix',
        'twilio_match_data',
        'last_name',
        'middle_name',
        boolean_to_string('us_citizen'),
        'precinct',
        'email_address',
        'smarty_streets_match_data',
        'scan_id',
        boolean_to_string('attempted'),
    ]) }} as _airbyte_registration_forms_hashid,
    tmp.*
from {{ ref('registration_forms_ab2') }} as tmp
-- registration_forms
where 1 = 1
