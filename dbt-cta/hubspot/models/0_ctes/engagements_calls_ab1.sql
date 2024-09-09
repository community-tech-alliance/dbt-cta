
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'engagements_calls') }}

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
   properties_inbox_id,
   properties_hs_call_body,
   properties_hs_object_id,
   properties_hs_read_only,
   properties_hs_timestamp,
   properties_hs_unique_id,
   properties_hs_call_title,
   properties_hs_created_by,
   properties_hs_createdate,
   properties_hs_call_app_id,
   properties_hs_call_source,
   properties_hs_call_status,
   properties_hs_modified_by,
   properties_hs_all_team_ids,
   properties_hs_body_preview,
   properties_hs_call_summary,
   properties_hs_gdpr_deleted,
   properties_hs_product_name,
   properties_hs_was_imported,
   properties_hubspot_team_id,
   properties_hs_activity_type,
   properties_hs_all_owner_ids,
   properties_hs_call_duration,
   properties_hs_object_source,
   properties_hubspot_owner_id,
   properties_hs_attachment_ids,
   properties_hs_call_direction,
   properties_hs_call_to_number,
   properties_hs_connected_count,
   properties_hs_shared_team_ids,
   properties_hs_shared_user_ids,
   properties_hs_voicemail_count,
   properties_hs_call_disposition,
   properties_hs_call_external_id,
   properties_hs_call_from_number,
   properties_hs_follow_up_action,
   properties_hs_lastmodifieddate,
   properties_hs_object_source_id,
   properties_hs_body_preview_html,
   properties_hs_call_primary_deal,
   properties_hs_engagement_source,
   properties_hs_merged_object_ids,
   properties_hs_call_has_voicemail,
   properties_hs_call_recording_url,
   properties_hs_created_by_user_id,
   properties_hs_updated_by_user_id,
   properties_hs_call_has_transcript,
   properties_hs_object_source_label,
   properties_hs_unique_creation_key,
   properties_hs_engagement_source_id,
   properties_hs_queue_membership_ids,
   properties_hs_call_callee_object_id,
   properties_hs_call_ms_teams_payload,
   properties_hs_call_transcription_id,
   properties_hs_calls_service_call_id,
   properties_hs_object_source_user_id,
   properties_hs_at_mentioned_owner_ids,
   properties_hs_call_zoom_meeting_uuid,
   properties_hs_object_source_detail_1,
   properties_hs_object_source_detail_2,
   properties_hs_object_source_detail_3,
   properties_hs_user_ids_of_all_owners,
   properties_hs_all_accessible_team_ids,
   properties_hs_call_callee_object_type,
   properties_hs_call_to_number_nickname,
   properties_hs_call_video_meeting_type,
   properties_hubspot_owner_assigneddate,
   properties_hs_call_authed_url_provider,
   properties_hs_call_external_account_id,
   properties_hs_call_video_recording_url,
   properties_hs_body_preview_is_truncated,
   properties_hs_call_from_number_nickname,
   properties_hs_call_summary_execution_id,
   properties_hs_call_deal_stage_during_call,
   properties_hs_unknown_visitor_conversation,
   properties_hs_call_transcript_tracked_terms,
   properties_hs_all_assigned_business_unit_ids,
   properties_hs_call_transcript_audio_num_channels,
   properties_hs_user_ids_of_all_notification_followers,
   properties_hs_user_ids_of_all_notification_unfollowers,
   {{ dbt_utils.surrogate_key([
     'id',
    'archived',
    'createdAt',
    'updatedAt',
    'properties_inbox_id',
    'properties_hs_call_body',
    'properties_hs_read_only',
    'properties_hs_timestamp',
    'properties_hs_unique_id',
    'properties_hs_call_title',
    'properties_hs_createdate',
    'properties_hs_call_source',
    'properties_hs_call_status',
    'properties_hs_all_team_ids',
    'properties_hs_body_preview',
    'properties_hs_call_summary',
    'properties_hs_gdpr_deleted',
    'properties_hs_product_name',
    'properties_hs_was_imported',
    'properties_hubspot_team_id',
    'properties_hs_activity_type',
    'properties_hs_all_owner_ids',
    'properties_hs_object_source',
    'properties_hubspot_owner_id',
    'properties_hs_attachment_ids',
    'properties_hs_call_direction',
    'properties_hs_call_to_number',
    'properties_hs_shared_team_ids',
    'properties_hs_shared_user_ids',
    'properties_hs_call_disposition',
    'properties_hs_call_external_id',
    'properties_hs_call_from_number',
    'properties_hs_follow_up_action',
    'properties_hs_lastmodifieddate',
    'properties_hs_object_source_id',
    'properties_hs_body_preview_html',
    'properties_hs_call_primary_deal',
    'properties_hs_engagement_source',
    'properties_hs_merged_object_ids',
    'properties_hs_call_has_voicemail',
    'properties_hs_call_recording_url',
    'properties_hs_call_has_transcript',
    'properties_hs_object_source_label',
    'properties_hs_unique_creation_key',
    'properties_hs_engagement_source_id',
    'properties_hs_queue_membership_ids',
    'properties_hs_call_ms_teams_payload',
    'properties_hs_at_mentioned_owner_ids',
    'properties_hs_call_zoom_meeting_uuid',
    'properties_hs_object_source_detail_1',
    'properties_hs_object_source_detail_2',
    'properties_hs_object_source_detail_3',
    'properties_hs_user_ids_of_all_owners',
    'properties_hs_all_accessible_team_ids',
    'properties_hs_call_callee_object_type',
    'properties_hs_call_to_number_nickname',
    'properties_hs_call_video_meeting_type',
    'properties_hubspot_owner_assigneddate',
    'properties_hs_call_authed_url_provider',
    'properties_hs_call_external_account_id',
    'properties_hs_call_video_recording_url',
    'properties_hs_body_preview_is_truncated',
    'properties_hs_call_from_number_nickname',
    'properties_hs_call_summary_execution_id',
    'properties_hs_call_deal_stage_during_call',
    'properties_hs_unknown_visitor_conversation',
    'properties_hs_call_transcript_tracked_terms',
    'properties_hs_all_assigned_business_unit_ids',
    'properties_hs_user_ids_of_all_notification_followers',
    'properties_hs_user_ids_of_all_notification_unfollowers'
    ]) }} as _airbyte_engagements_calls_hashid
from {{ source('cta', 'engagements_calls') }}