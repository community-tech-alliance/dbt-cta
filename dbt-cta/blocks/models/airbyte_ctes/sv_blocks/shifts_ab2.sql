{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('shifts_ab1') }}
select
    cast(notes as {{ dbt_utils.type_string() }}) as notes,
    cast(signatures_count as {{ dbt_utils.type_bigint() }}) as signatures_count,
    cast(canvasser_id as {{ dbt_utils.type_bigint() }}) as canvasser_id,
    cast({{ empty_string_to_null('ready_for_delivery_at') }} as {{ type_timestamp_without_timezone() }}) as ready_for_delivery_at,
    cast(visual_qc_completed_by_user_id as {{ dbt_utils.type_bigint() }}) as visual_qc_completed_by_user_id,
    cast(incomplete_vr_forms_count as {{ dbt_utils.type_bigint() }}) as incomplete_vr_forms_count,
    cast(absentee_ballot_request_forms_count as {{ dbt_utils.type_bigint() }}) as absentee_ballot_request_forms_count,
    cast(extras as {{ dbt_utils.type_string() }}) as extras,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(soft_count_cards_total_collected as {{ dbt_utils.type_bigint() }}) as soft_count_cards_total_collected,
    cast(phone_verification_completed_by_user_id as {{ dbt_utils.type_bigint() }}) as phone_verification_completed_by_user_id,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast({{ empty_string_to_null('field_start') }} as {{ type_timestamp_without_timezone() }}) as field_start,
    cast(location_id as {{ dbt_utils.type_bigint() }}) as location_id,
    cast(shift_type as {{ dbt_utils.type_bigint() }}) as shift_type,
    cast(soft_count_pre_registration_cards_collected as {{ dbt_utils.type_bigint() }}) as soft_count_pre_registration_cards_collected,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast({{ empty_string_to_null('locked_at') }} as {{ type_timestamp_without_timezone() }}) as locked_at,
    cast(locked_by_user_id as {{ dbt_utils.type_bigint() }}) as locked_by_user_id,
    cast(soft_count_cards_complete_collected as {{ dbt_utils.type_bigint() }}) as soft_count_cards_complete_collected,
    cast(soft_count_cards_with_phone_collected as {{ dbt_utils.type_bigint() }}) as soft_count_cards_with_phone_collected,
    cast({{ empty_string_to_null('shift_end') }} as {{ type_timestamp_without_timezone() }}) as shift_end,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    {{ cast_to_boolean('digital') }} as digital,
    {{ cast_to_boolean('qc_external') }} as qc_external,
    cast({{ empty_string_to_null('ready_for_qc_at') }} as {{ type_timestamp_without_timezone() }}) as ready_for_qc_at,
    cast(soft_count_cards_with_incorrect_date_collected as {{ dbt_utils.type_bigint() }}) as soft_count_cards_with_incorrect_date_collected,
    cast(petition_pages_count as {{ dbt_utils.type_bigint() }}) as petition_pages_count,
    cast({{ empty_string_to_null('ready_for_phone_verification_at') }} as {{ type_timestamp_without_timezone() }}) as ready_for_phone_verification_at,
    cast(soft_count_cards_incomplete_collected as {{ dbt_utils.type_bigint() }}) as soft_count_cards_incomplete_collected,
    cast(created_by_user_id as {{ dbt_utils.type_bigint() }}) as created_by_user_id,
    cast(staging_location_id as {{ dbt_utils.type_bigint() }}) as staging_location_id,
    cast(tags as {{ dbt_utils.type_string() }}) as tags,
    cast({{ empty_string_to_null('shift_start') }} as {{ type_timestamp_without_timezone() }}) as shift_start,
    cast({{ empty_string_to_null('completed_at') }} as {{ type_timestamp_without_timezone() }}) as completed_at,
    cast(soft_count_cards_with_email_collected as {{ dbt_utils.type_bigint() }}) as soft_count_cards_with_email_collected,
    cast({{ empty_string_to_null('field_end') }} as {{ type_timestamp_without_timezone() }}) as field_end,
    cast(incomplete_abr_forms_count as {{ dbt_utils.type_bigint() }}) as incomplete_abr_forms_count,
    cast(registration_forms_count as {{ dbt_utils.type_bigint() }}) as registration_forms_count,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('shifts_ab1') }}
-- shifts
where 1 = 1

