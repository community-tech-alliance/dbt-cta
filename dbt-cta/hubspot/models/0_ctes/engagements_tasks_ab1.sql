{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'engagements_tasks') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    id,
    deals,
    tickets,
    archived,
    contacts,
    companies,
    createdAt,
    updatedAt,
    properties,
    properties_hs_object_id,
    properties_hs_read_only,
    properties_hs_task_body,
    properties_hs_task_type,
    properties_hs_timestamp,
    properties_hs_unique_id,
    properties_hs_created_by,
    properties_hs_createdate,
    properties_hs_modified_by,
    properties_hs_task_family,
    properties_hs_task_status,
    properties_hs_all_team_ids,
    properties_hs_body_preview,
    properties_hs_gdpr_deleted,
    properties_hs_product_name,
    properties_hs_task_subject,
    properties_hs_was_imported,
    properties_hubspot_team_id,
    properties_hs_all_owner_ids,
    properties_hs_object_source,
    properties_hs_repeat_status,
    properties_hs_task_priority,
    properties_hubspot_owner_id,
    properties_hs_attachment_ids,
    properties_hs_task_reminders,
    properties_hs_scheduled_tasks,
    properties_hs_shared_team_ids,
    properties_hs_shared_user_ids,
    properties_hs_task_is_all_day,
    properties_hs_task_is_overdue,
    properties_hs_follow_up_action,
    properties_hs_lastmodifieddate,
    properties_hs_object_source_id,
    properties_hs_task_template_id,
    properties_hs_body_preview_html,
    properties_hs_calendar_event_id,
    properties_hs_engagement_source,
    properties_hs_merged_object_ids,
    properties_hs_task_is_completed,
    properties_hs_created_by_user_id,
    properties_hs_msteams_message_id,
    properties_hs_updated_by_user_id,
    properties_hs_object_source_label,
    properties_hs_unique_creation_key,
    properties_hs_engagement_source_id,
    properties_hs_num_associated_deals,
    properties_hs_queue_membership_ids,
    properties_hs_task_completion_date,
    properties_hs_task_for_object_type,
    properties_hs_task_missed_due_date,
    properties_hs_task_repeat_interval,
    properties_hs_object_source_user_id,
    properties_hs_task_completion_count,
    properties_hs_task_contact_timezone,
    properties_hs_task_is_past_due_date,
    properties_hs_task_ms_teams_payload,
    properties_hs_at_mentioned_owner_ids,
    properties_hs_num_associated_tickets,
    properties_hs_object_source_detail_1,
    properties_hs_object_source_detail_2,
    properties_hs_object_source_detail_3,
    properties_hs_task_is_completed_call,
    properties_hs_user_ids_of_all_owners,
    properties_hs_all_accessible_team_ids,
    properties_hs_num_associated_contacts,
    properties_hs_task_is_completed_email,
    properties_hs_task_relative_reminders,
    properties_hubspot_owner_assigneddate,
    properties_hs_num_associated_companies,
    properties_hs_task_sequence_step_order,
    properties_hs_body_preview_is_truncated,
    properties_hs_task_is_completed_sequence,
    properties_hs_task_last_contact_outreach,
    properties_hs_task_missed_due_date_count,
    properties_hs_task_send_default_reminder,
    properties_hs_task_is_completed_linked_in,
    properties_hs_num_associated_queue_objects,
    properties_hs_task_probability_to_complete,
    properties_hs_all_assigned_business_unit_ids,
    properties_hs_task_sequence_enrollment_active,
    properties_hs_task_sequence_step_enrollment_id,
    properties_hs_task_last_sales_activity_timestamp,
    properties_hs_user_ids_of_all_notification_followers,
    properties_hs_user_ids_of_all_notification_unfollowers,
    properties_hs_time_in_60b5c368_04c4_4d32_9b4a_457e159f49b7_13292096,
    properties_hs_time_in_61bafb31_e7fa_46ed_aaa9_1322438d6e67_1866552342,
    properties_hs_time_in_af0e6a5c_2ea3_4c72_b69f_7c6cb3fdb591_1652950531,
    properties_hs_time_in_dd5826e4_c976_4654_a527_b59ada542e52_2144133616,
    properties_hs_time_in_fc8148fb_3a2d_4b59_834e_69b7859347cb_1813133675,
    properties_hs_date_exited_60b5c368_04c4_4d32_9b4a_457e159f49b7_13292096,
    properties_hs_date_entered_60b5c368_04c4_4d32_9b4a_457e159f49b7_13292096,
    properties_hs_date_exited_61bafb31_e7fa_46ed_aaa9_1322438d6e67_1866552342,
    properties_hs_date_exited_af0e6a5c_2ea3_4c72_b69f_7c6cb3fdb591_1652950531,
    properties_hs_date_exited_dd5826e4_c976_4654_a527_b59ada542e52_2144133616,
    properties_hs_date_exited_fc8148fb_3a2d_4b59_834e_69b7859347cb_1813133675,
    properties_hs_date_entered_61bafb31_e7fa_46ed_aaa9_1322438d6e67_1866552342,
    properties_hs_date_entered_af0e6a5c_2ea3_4c72_b69f_7c6cb3fdb591_1652950531,
    properties_hs_date_entered_dd5826e4_c976_4654_a527_b59ada542e52_2144133616,
    properties_hs_date_entered_fc8148fb_3a2d_4b59_834e_69b7859347cb_1813133675,
   {{ dbt_utils.surrogate_key([
     'id',
    'archived',
    'createdAt',
    'updatedAt',
    'properties_hs_read_only',
    'properties_hs_task_body',
    'properties_hs_task_type',
    'properties_hs_timestamp',
    'properties_hs_unique_id',
    'properties_hs_createdate',
    'properties_hs_task_family',
    'properties_hs_task_status',
    'properties_hs_all_team_ids',
    'properties_hs_body_preview',
    'properties_hs_gdpr_deleted',
    'properties_hs_product_name',
    'properties_hs_task_subject',
    'properties_hs_was_imported',
    'properties_hubspot_team_id',
    'properties_hs_all_owner_ids',
    'properties_hs_object_source',
    'properties_hs_repeat_status',
    'properties_hs_task_priority',
    'properties_hubspot_owner_id',
    'properties_hs_attachment_ids',
    'properties_hs_task_reminders',
    'properties_hs_scheduled_tasks',
    'properties_hs_shared_team_ids',
    'properties_hs_shared_user_ids',
    'properties_hs_task_is_all_day',
    'properties_hs_task_is_overdue',
    'properties_hs_follow_up_action',
    'properties_hs_lastmodifieddate',
    'properties_hs_object_source_id',
    'properties_hs_body_preview_html',
    'properties_hs_calendar_event_id',
    'properties_hs_engagement_source',
    'properties_hs_merged_object_ids',
    'properties_hs_msteams_message_id',
    'properties_hs_object_source_label',
    'properties_hs_unique_creation_key',
    'properties_hs_engagement_source_id',
    'properties_hs_queue_membership_ids',
    'properties_hs_task_completion_date',
    'properties_hs_task_for_object_type',
    'properties_hs_task_missed_due_date',
    'properties_hs_task_repeat_interval',
    'properties_hs_task_contact_timezone',
    'properties_hs_task_is_past_due_date',
    'properties_hs_task_ms_teams_payload',
    'properties_hs_at_mentioned_owner_ids',
    'properties_hs_object_source_detail_1',
    'properties_hs_object_source_detail_2',
    'properties_hs_object_source_detail_3',
    'properties_hs_user_ids_of_all_owners',
    'properties_hs_all_accessible_team_ids',
    'properties_hs_task_relative_reminders',
    'properties_hubspot_owner_assigneddate',
    'properties_hs_body_preview_is_truncated',
    'properties_hs_task_last_contact_outreach',
    'properties_hs_task_send_default_reminder',
    'properties_hs_all_assigned_business_unit_ids',
    'properties_hs_task_sequence_enrollment_active',
    'properties_hs_task_sequence_step_enrollment_id',
    'properties_hs_task_last_sales_activity_timestamp',
    'properties_hs_user_ids_of_all_notification_followers',
    'properties_hs_user_ids_of_all_notification_unfollowers',
    'properties_hs_date_exited_60b5c368_04c4_4d32_9b4a_457e159f49b7_13292096',
    'properties_hs_date_entered_60b5c368_04c4_4d32_9b4a_457e159f49b7_13292096',
    'properties_hs_date_exited_61bafb31_e7fa_46ed_aaa9_1322438d6e67_1866552342',
    'properties_hs_date_exited_af0e6a5c_2ea3_4c72_b69f_7c6cb3fdb591_1652950531',
    'properties_hs_date_exited_dd5826e4_c976_4654_a527_b59ada542e52_2144133616',
    'properties_hs_date_exited_fc8148fb_3a2d_4b59_834e_69b7859347cb_1813133675',
    'properties_hs_date_entered_61bafb31_e7fa_46ed_aaa9_1322438d6e67_1866552342',
    'properties_hs_date_entered_af0e6a5c_2ea3_4c72_b69f_7c6cb3fdb591_1652950531',
    'properties_hs_date_entered_dd5826e4_c976_4654_a527_b59ada542e52_2144133616',
    'properties_hs_date_entered_fc8148fb_3a2d_4b59_834e_69b7859347cb_1813133675'
    ]) }} as _airbyte_engagements_tasks_hashid
from {{ source('cta', 'engagements_tasks') }}