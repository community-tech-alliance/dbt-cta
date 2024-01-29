{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('registrations_export_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'encode_id',
        boolean_to_string('has_state_identification'),
        'voterbase_id',
        'city',
        'date_of_birth',
        'registration_status',
        'contact_referral_full_name',
        'created_at',
        'team_id',
        'contact_id',
        'zip_code',
        'unit_number',
        'updated_at',
        boolean_to_string('sms_opt_in'),
        boolean_to_string('different_address'),
        'voter_registration_status',
        'activity_id',
        'id',
        'first_name',
        'email',
        'campaign_id',
        'activity_title',
        'referral_link',
        boolean_to_string('email_opt_in'),
        'address',
        'completed_voter_registration_at',
        'last_name',
        'county_name',
        'contact_referral_id',
        'team_name',
        'exported_at',
        'state_abbrev',
        'phone',
    ]) }} as _airbyte_registrations_export_hashid,
    tmp.*
from {{ ref('registrations_export_ab2') }} tmp
-- registrations_export
where 1 = 1

