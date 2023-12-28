{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('scans_qc_overview_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'distance_from_location',
        boolean_to_string('eligible_voting_age'),
        'canvasser_id',
        'visual_qc_completed_by_user_id',
        'program_state',
        'data_entry_time',
        boolean_to_string('bad_number'),
        'field_start',
        'shift_type',
        'collection_location_id',
        'identification',
        'voter_registration_scan_id',
        'voting_state',
        'collection_location_zip',
        'collection_location_city',
        'collective_name',
        'visual_qc_county',
        boolean_to_string('address_validated'),
        'qc_deadline',
        'mailing_street_address_two',
        'organization_name',
        'canvasser_last_name',
        'shift_start',
        'upload_time',
        'name',
        'voting_city',
        'collection_location_name',
        'phone_number',
        'party',
        'voting_address_latitude',
        'qc_organization',
        'mailing_street_address_one',
        'gender',
        'ethnicity',
        boolean_to_string('signature'),
        'turf_parent_id',
        'date_of_birth',
        'extras',
        'voting_street_address_two',
        'voting_address_longitude',
        'phone_verification_completed_by_user_id',
        'voting_zipcode',
        'mailing_zipcode',
        'registration_type',
        'registration_form_id',
        'packet_filename',
        'name_prefix',
        'collection_location_longitude',
        boolean_to_string('through_visual_qc'),
        'turf_id',
        'van_committee_id',
        'shift_id',
        'collection_location_latitude',
        'shift_end',
        'collection_location_county',
        'first_name',
        'data_entry_county',
        'voter_registration_scan_updated_at',
        boolean_to_string('digital'),
        'mailing_city',
        boolean_to_string('is_registration_form'),
        'voting_street_address_one',
        'name_suffix',
        'data_entry_updated_at',
        'last_name',
        'middle_name',
        'voter_registration_scan_batches_id',
        boolean_to_string('phone_validated'),
        'email_address',
        boolean_to_string('phone_verified'),
        'collection_location_street_address',
        'field_end',
        'canvasser_first_name',
        boolean_to_string('complete'),
        boolean_to_string('has_phone_number_visual_qc'),
        'collection_location_state',
    ]) }} as _airbyte_scans_qc_overview_hashid,
    tmp.*
from {{ ref('scans_qc_overview_ab2') }} as tmp
-- scans_qc_overview
where 1 = 1