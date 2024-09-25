{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'companies_property_history') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    value,
    archived,
    property,
    sourceId,
    companyId,
    timestamp,
    properties,
    sourceType,
    properties_zip,
    properties_city,
    properties_name,
    properties_type,
    updatedByUserId,
    properties_phone,
    properties_state,
    properties_domain,
    properties_address,
    properties_country,
    properties_website,
    properties_about_us,
    properties_address2,
    properties_inbox_id,
    properties_industry,
    properties_timezone,
    properties_closedate,
    properties_is_public,
    properties_num_notes,
    properties_createdate,
    properties_twitterbio,
    properties_description,
    properties_hs_logo_url,
    properties_hs_pipeline,
    properties_linkedinbio,
    properties_facebookfans,
    properties_founded_year,
    properties_hs_object_id,
    properties_hs_read_only,
    properties_hubspotscore,
    properties_annualrevenue,
    properties_days_to_close,
    properties_hs_createdate,
    properties_total_revenue,
    properties_twitterhandle,
    properties_hs_lead_status,
    properties_lifecyclestage,
    properties_googleplus_page,
    properties_hs_all_team_ids,
    properties_hs_country_code,
    properties_hs_num_blockers,
    properties_hs_time_in_lead,
    properties_hs_was_imported,
    properties_hubspot_team_id,
    properties_hs_all_owner_ids,
    properties_hs_csm_sentiment,
    properties_hs_object_source,
    properties_hs_time_in_other,
    properties_hubspot_owner_id,
    properties_twitterfollowers,
    properties_web_technologies,
    properties_contract_end_date,
    properties_hs_num_open_deals,
    properties_hs_target_account,
    properties_numberofemployees,
    properties_organization_type,
    properties_notes_last_updated,
    properties_recent_deal_amount,
    properties_total_money_raised,
    properties_hs_analytics_source,
    properties_hs_date_exited_lead,
    properties_hs_lastmodifieddate,
    properties_hs_object_source_id,
    properties_hs_time_in_customer,
    properties_hs_total_deal_value,
    properties_num_contacted_notes,
    properties_hs_date_entered_lead,
    properties_hs_date_exited_other,
    properties_hs_is_target_account,
    properties_hs_merged_object_ids,
    properties_hs_parent_company_id,
    properties_notes_last_contacted,
    properties_num_associated_deals,
    properties_facebook_company_page,
    properties_first_conversion_date,
    properties_hs_additional_domains,
    properties_hs_created_by_user_id,
    properties_hs_date_entered_other,
    properties_hs_time_in_evangelist,
    properties_hs_time_in_subscriber,
    properties_hs_updated_by_user_id,
    properties_linkedin_company_page,
    properties_num_conversion_events,
    properties_hs_last_open_task_date,
    properties_hs_num_child_companies,
    properties_hs_num_decision_makers,
    properties_hs_object_source_label,
    properties_hs_time_in_opportunity,
    properties_hs_unique_creation_key,
    properties_recent_conversion_date,
    properties_recent_deal_close_date,
    properties_first_deal_created_date,
    properties_hs_analytics_num_visits,
    properties_hs_date_exited_customer,
    properties_hs_pinned_engagement_id,
    properties_num_associated_contacts,
    properties_first_contact_createdate,
    properties_hs_date_entered_customer,
    properties_hs_last_logged_call_date,
    properties_hs_object_source_user_id,
    properties_notes_next_activity_date,
    properties_hs_avatar_filemanager_key,
    properties_hs_date_exited_evangelist,
    properties_hs_date_exited_subscriber,
    properties_hs_ideal_customer_profile,
    properties_hs_object_source_detail_1,
    properties_hs_object_source_detail_2,
    properties_hs_object_source_detail_3,
    properties_hs_user_ids_of_all_owners,
    properties_hs_all_accessible_team_ids,
    properties_hs_analytics_latest_source,
    properties_hs_analytics_source_data_1,
    properties_hs_analytics_source_data_2,
    properties_hs_date_entered_evangelist,
    properties_hs_date_entered_subscriber,
    properties_hs_date_exited_opportunity,
    properties_hs_latest_meeting_activity,
    properties_hubspot_owner_assigneddate,
    properties_first_conversion_event_name,
    properties_hs_analytics_last_timestamp,
    properties_hs_analytics_num_page_views,
    properties_hs_date_entered_opportunity,
    properties_hs_last_booked_meeting_date,
    properties_hs_last_sales_activity_date,
    properties_hs_last_sales_activity_type,
    properties_hs_notes_next_activity_type,
    properties_hs_sales_email_last_replied,
    properties_hs_analytics_first_timestamp,
    properties_recent_conversion_event_name,
    properties_hs_target_account_probability,
    properties_hs_time_in_salesqualifiedlead,
    properties_engagements_last_meeting_booked,
    properties_hs_annual_revenue_currency_code,
    properties_hs_last_sales_activity_timestamp,
    properties_hs_analytics_last_visit_timestamp,
    properties_hs_analytics_latest_source_data_1,
    properties_hs_analytics_latest_source_data_2,
    properties_hs_date_exited_salesqualifiedlead,
    properties_hs_num_contacts_with_buying_roles,
    properties_hs_time_in_marketingqualifiedlead,
    properties_hs_analytics_first_visit_timestamp,
    properties_hs_date_entered_salesqualifiedlead,
    properties_hs_analytics_latest_source_timestamp,
    properties_hs_customer_success_ticket_sentiment,
    properties_hs_date_exited_marketingqualifiedlead,
    properties_engagements_last_meeting_booked_medium,
    properties_engagements_last_meeting_booked_source,
    properties_hs_date_entered_marketingqualifiedlead,
    properties_hs_target_account_recommendation_state,
    properties_engagements_last_meeting_booked_campaign,
    properties_hs_user_ids_of_all_notification_followers,
    properties_closedate_timestamp_earliest_value_a2a17e6e,
    properties_hs_analytics_last_touch_converting_campaign,
    properties_hs_user_ids_of_all_notification_unfollowers,
    properties_hs_analytics_first_touch_converting_campaign,
    properties_hs_latest_createdate_of_active_subscriptions,
    properties_hs_target_account_recommendation_snooze_time,
    properties_num_conversion_events_cardinality_sum_d095f14b,
    properties_hs_analytics_num_visits_cardinality_sum_53d952a6,
    properties_hs_predictivecontactscore_v2_next_max_max_d4e58c1e,
    properties_hs_analytics_num_page_views_cardinality_sum_e46e85b0,
    properties_hs_analytics_source_timestamp_earliest_value_25a3a52c,
    properties_recent_conversion_date_timestamp_latest_value_72856da1,
    properties_first_conversion_date_timestamp_earliest_value_61f58f2c,
    properties_first_contact_createdate_timestamp_earliest_value_78b50eea,
    properties_hs_analytics_last_timestamp_timestamp_latest_value_4e16365a,
    properties_hs_analytics_source_data_1_timestamp_earliest_value_9b2f1fa1,
    properties_hs_analytics_source_data_2_timestamp_earliest_value_9b2f9400,
    properties_recent_conversion_event_name_timestamp_latest_value_66c820bf,
    properties_first_conversion_event_name_timestamp_earliest_value_68ddae0a,
    properties_hs_analytics_first_timestamp_timestamp_earliest_value_11e3a63a,
    properties_hs_analytics_last_visit_timestamp_timestamp_latest_value_999a0fce,
    properties_hs_analytics_first_visit_timestamp_timestamp_earliest_value_accc17ae,
    properties_hs_analytics_last_touch_converting_campaign_timestamp_latest_value_81a64e30,
    properties_hs_analytics_first_touch_converting_campaign_timestamp_earliest_value_4757fe10,
   {{ dbt_utils.surrogate_key([
    'property',
    'companyId',
    'timestamp',
    ]) }} as _airbyte_companies_property_history_hashid
from {{ source('cta', 'companies_property_history') }}