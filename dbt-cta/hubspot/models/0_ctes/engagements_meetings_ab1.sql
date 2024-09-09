
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'engagements_meetings') }}

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
   properties_hs_timezone,
   properties_hs_i_cal_uid,
   properties_hs_object_id,
   properties_hs_read_only,
   properties_hs_timestamp,
   properties_hs_unique_id,
   properties_hs_created_by,
   properties_hs_createdate,
   properties_hs_modified_by,
   properties_hs_all_team_ids,
   properties_hs_body_preview,
   properties_hs_gdpr_deleted,
   properties_hs_guest_emails,
   properties_hs_meeting_body,
   properties_hs_product_name,
   properties_hs_was_imported,
   properties_hubspot_team_id,
   properties_hs_activity_type,
   properties_hs_all_owner_ids,
   properties_hs_meeting_title,
   properties_hs_object_source,
   properties_hubspot_owner_id,
   properties_hs_attachment_ids,
   properties_hs_meeting_source,
   properties_hs_meeting_outcome,
   properties_hs_scheduled_tasks,
   properties_hs_shared_team_ids,
   properties_hs_shared_user_ids,
   properties_hs_follow_up_action,
   properties_hs_lastmodifieddate,
   properties_hs_meeting_end_time,
   properties_hs_meeting_location,
   properties_hs_object_source_id,
   properties_hs_body_preview_html,
   properties_hs_engagement_source,
   properties_hs_meeting_change_id,
   properties_hs_meeting_source_id,
   properties_hs_merged_object_ids,
   properties_hs_attendee_owner_ids,
   properties_hs_created_by_user_id,
   properties_hs_meeting_start_time,
   properties_hs_updated_by_user_id,
   properties_hs_object_source_label,
   properties_hs_unique_creation_key,
   properties_hs_engagement_source_id,
   properties_hs_meeting_external_url,
   properties_hs_queue_membership_ids,
   properties_hs_video_conference_url,
   properties_hs_meeting_location_type,
   properties_hs_object_source_user_id,
   properties_hs_outcome_no_show_count,
   properties_hs_at_mentioned_owner_ids,
   properties_hs_internal_meeting_notes,
   properties_hs_object_source_detail_1,
   properties_hs_object_source_detail_2,
   properties_hs_object_source_detail_3,
   properties_hs_outcome_canceled_count,
   properties_hs_user_ids_of_all_owners,
   properties_hs_all_accessible_team_ids,
   properties_hs_outcome_completed_count,
   properties_hs_outcome_scheduled_count,
   properties_hubspot_owner_assigneddate,
   properties_hs_meeting_ms_teams_payload,
   properties_hs_body_preview_is_truncated,
   properties_hs_follow_up_tasks_remaining,
   properties_hs_outcome_rescheduled_count,
   properties_hs_roster_object_coordinates,
   properties_hs_contact_first_outreach_date,
   properties_hs_meeting_calendar_event_hash,
   properties_hs_meeting_payments_session_id,
   properties_hs_meeting_created_from_link_id,
   properties_hs_all_assigned_business_unit_ids,
   properties_hs_include_description_in_reminder,
   properties_hs_meeting_web_conference_meeting_id,
   properties_hs_meeting_pre_meeting_prospect_reminders,
   properties_hs_user_ids_of_all_notification_followers,
   properties_hs_time_to_book_meeting_from_first_contact,
   properties_hs_user_ids_of_all_notification_unfollowers,
   {{ dbt_utils.surrogate_key([
     'id',
    'archived',
    'createdAt',
    'updatedAt',
    'properties_hs_timezone',
    'properties_hs_i_cal_uid',
    'properties_hs_read_only',
    'properties_hs_timestamp',
    'properties_hs_unique_id',
    'properties_hs_createdate',
    'properties_hs_all_team_ids',
    'properties_hs_body_preview',
    'properties_hs_gdpr_deleted',
    'properties_hs_guest_emails',
    'properties_hs_meeting_body',
    'properties_hs_product_name',
    'properties_hs_was_imported',
    'properties_hubspot_team_id',
    'properties_hs_activity_type',
    'properties_hs_all_owner_ids',
    'properties_hs_meeting_title',
    'properties_hs_object_source',
    'properties_hubspot_owner_id',
    'properties_hs_attachment_ids',
    'properties_hs_meeting_source',
    'properties_hs_meeting_outcome',
    'properties_hs_scheduled_tasks',
    'properties_hs_shared_team_ids',
    'properties_hs_shared_user_ids',
    'properties_hs_follow_up_action',
    'properties_hs_lastmodifieddate',
    'properties_hs_meeting_end_time',
    'properties_hs_meeting_location',
    'properties_hs_object_source_id',
    'properties_hs_body_preview_html',
    'properties_hs_engagement_source',
    'properties_hs_meeting_change_id',
    'properties_hs_meeting_source_id',
    'properties_hs_merged_object_ids',
    'properties_hs_attendee_owner_ids',
    'properties_hs_meeting_start_time',
    'properties_hs_object_source_label',
    'properties_hs_unique_creation_key',
    'properties_hs_engagement_source_id',
    'properties_hs_meeting_external_url',
    'properties_hs_queue_membership_ids',
    'properties_hs_video_conference_url',
    'properties_hs_meeting_location_type',
    'properties_hs_at_mentioned_owner_ids',
    'properties_hs_internal_meeting_notes',
    'properties_hs_object_source_detail_1',
    'properties_hs_object_source_detail_2',
    'properties_hs_object_source_detail_3',
    'properties_hs_user_ids_of_all_owners',
    'properties_hs_all_accessible_team_ids',
    'properties_hubspot_owner_assigneddate',
    'properties_hs_meeting_ms_teams_payload',
    'properties_hs_body_preview_is_truncated',
    'properties_hs_roster_object_coordinates',
    'properties_hs_contact_first_outreach_date',
    'properties_hs_meeting_calendar_event_hash',
    'properties_hs_meeting_payments_session_id',
    'properties_hs_meeting_created_from_link_id',
    'properties_hs_all_assigned_business_unit_ids',
    'properties_hs_include_description_in_reminder',
    'properties_hs_meeting_web_conference_meeting_id',
    'properties_hs_meeting_pre_meeting_prospect_reminders',
    'properties_hs_user_ids_of_all_notification_followers',
    'properties_hs_user_ids_of_all_notification_unfollowers'
    ]) }} as _airbyte_engagements_meetings_hashid
from {{ source('cta', 'engagements_meetings') }}