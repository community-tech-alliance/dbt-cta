{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'shifts') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    tags,
    type,
    notes,
    extras,
    status,
    field_end,
    locked_at,
    shift_end,
    created_at,
    shift_type,
    updated_at,
    campaign_id,
    field_start,
    location_id,
    qc_external,
    shift_start,
    canvasser_id,
    completed_at,
    ready_for_qc_at,
    signatures_count,
    custom_field_data,
    locked_by_user_id,
    created_by_user_id,
    staging_location_id,
    petition_pages_count,
    ready_for_delivery_at,
    registration_forms_count,
    incomplete_vr_forms_count,
    incomplete_abr_forms_count,
    visual_qc_completed_by_user_id,
    ready_for_phone_verification_at,
    soft_count_cards_total_collected,
    absentee_ballot_request_forms_count,
    soft_count_cards_complete_collected,
    soft_count_cards_incomplete_collected,
    soft_count_cards_with_email_collected,
    soft_count_cards_with_phone_collected,
    phone_verification_completed_by_user_id,
    soft_count_pre_registration_cards_collected,
    soft_count_cards_with_incorrect_date_collected,
   {{ dbt_utils.surrogate_key([
     'id',
    'tags',
    'type',
    'notes',
    'extras',
    'status',
    'shift_type',
    'campaign_id',
    'location_id',
    'qc_external',
    'canvasser_id',
    'signatures_count',
    'custom_field_data',
    'locked_by_user_id',
    'created_by_user_id',
    'staging_location_id',
    'petition_pages_count',
    'registration_forms_count',
    'incomplete_vr_forms_count',
    'incomplete_abr_forms_count',
    'visual_qc_completed_by_user_id',
    'soft_count_cards_total_collected',
    'absentee_ballot_request_forms_count',
    'soft_count_cards_complete_collected',
    'soft_count_cards_incomplete_collected',
    'soft_count_cards_with_email_collected',
    'soft_count_cards_with_phone_collected',
    'phone_verification_completed_by_user_id',
    'soft_count_pre_registration_cards_collected',
    'soft_count_cards_with_incorrect_date_collected'
    ]) }} as _airbyte_shifts_hashid
from {{ source('cta', 'shifts') }}