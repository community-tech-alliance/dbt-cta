{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('landing_page_signups_ab3') }}
select
    mailing_county,
    state_api_submission_result,
    language,
    source,
    voting_state,
    finish_with_state,
    id,
    tracking_source,
    citizen,
    phone_type,
    mailing_street_address_two,
    built_via_api,
    organization_name,
    vr_app_status_datetime,
    opt_in_partner_sms,
    phone,
    started_registration_at,
    voting_city,
    voting_county,
    party,
    submitted_signature_to_state_api,
    status,
    has_state_license,
    mailing_street_address_one,
    date_of_birth,
    created_at,
    voting_street_address_two,
    voting_zipcode,
    mailing_zipcode,
    name_prefix,
    volunteer_for_rtv,
    updated_at,
    vr_app_status,
    vr_submission_mod,
    vr_submission_error,
    first_name,
    email,
    tracking_id,
    mailing_city,
    submitted_via_vendor_api,
    opt_in_sms,
    mailing_state,
    voting_street_address_one,
    race,
    name_suffix,
    has_ssn,
    opt_in_email,
    last_name,
    middle_name,
    ineligible_reason,
    volunteer_for_partner,
    source_id,
    vr_app_status_details,
    pre_registered,
    opt_in_partner_email,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_landing_page_signups_hashid
from {{ ref('landing_page_signups_ab3') }}
-- landing_page_signups from {{ source('cta', '_airbyte_raw_landing_page_signups') }}
