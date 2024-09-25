
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'deals_property_history') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   _airbyte_generation_id,
   value,
   dealId,
   archived,
   property,
   sourceId,
   timestamp,
   properties,
   sourceType,
   properties_pdf,
   properties_city,
   updatedByUserId,
   properties_email,
   properties_state,
   properties_add_on,
   properties_amount,
   properties_county,
   properties_hs_acv,
   properties_hs_arr,
   properties_hs_mrr,
   properties_hs_tcv,
   properties_program,
   properties_dealname,
   properties_dealtype,
   properties_inbox_id,
   properties_pipeline,
   properties_utm_term,
   properties_zcs_tier,
   properties_zip_code,
   properties_closedate,
   properties_dealstage,
   properties_num_notes,
   properties_vet_notes,
   properties_createdate,
   properties_hs_tag_ids,
   properties_test_score,
   properties_utm_medium,
   properties_utm_source,
   properties_deal_source,
   properties_description,
   properties_hiring_tier,
   properties_hs_campaign,
   properties_hs_priority,
   properties_link_clicks,
   properties_offer_ghost,
   properties_utm_content,
   properties_hou_zcs_tier,
   properties_hs_is_closed,
   properties_hs_next_step,
   properties_hs_object_id,
   properties_hs_read_only,
   properties_joined_rally,
   properties_ops_reviewer,
   properties_utm_campaign,
   properties_days_to_close,
   properties_district_type,
   properties_hou_zcs_score,
   properties_hs_createdate,
   properties_last_sent_sms,
   properties_review_status,
   properties_street_address,
   properties_total_sent_sms,
   properties_zcs___override,
   properties_current_client_,
   properties_hou_hiring_tier,
   properties_hs_all_team_ids,
   properties_hs_was_imported,
   properties_hubspot_team_id,
   properties_application_date,
   properties_exemption_status,
   properties_hs_all_owner_ids,
   properties_hs_closed_amount,
   properties_hs_exchange_rate,
   properties_hs_is_closed_won,
   properties_hs_is_open_count,
   properties_hs_object_source,
   properties_hubspot_owner_id,
   properties_onboarding_ghost,
   properties_sms_opt_out_date,
   properties_stance_on_choice,
   properties_street_address_2,
   properties_cell_phone_number,
   properties_closed_won_reason,
   properties_contract_end_date,
   properties_flagged_applicant,
   properties_last_received_sms,
   properties_application_source,
   properties_basically_anything,
   properties_closed_lost_reason,
   properties_contract_completed,
   properties_hs_closed_won_date,
   properties_hs_forecast_amount,
   properties_hs_is_closed_count,
   properties_notes_last_updated,
   properties_palooza_1_attended,
   properties_palooza_2_attended,
   properties_total_received_sms,
   properties_applicant_last_name,
   properties_date_offer_extended,
   properties_hs_analytics_source,
   properties_hs_closed_won_count,
   properties_hs_lastmodifieddate,
   properties_hs_object_source_id,
   properties_hs_predicted_amount,
   properties_hs_projected_amount,
   properties_hs_time_in_66768415,
   properties_hs_time_in_85599110,
   properties_hs_time_in_85599111,
   properties_hs_time_in_87374903,
   properties_hs_time_in_93117108,
   properties_hs_time_in_95207073,
   properties_hs_time_in_95207074,
   properties_introvert_extrovert,
   properties_num_contacted_notes,
   properties_onboarding_datetime,
   properties_applicant_first_name,
   properties_hs_days_to_close_raw,
   properties_hs_merged_object_ids,
   properties_hs_time_in_101107566,
   properties_hs_time_in_101141643,
   properties_hs_time_in_101141644,
   properties_hs_time_in_101141645,
   properties_hs_time_in_101141646,
   properties_hs_time_in_101141647,
   properties_hs_time_in_101141648,
   properties_hs_time_in_101141649,
   properties_hs_time_in_101188137,
   properties_hs_time_in_101188138,
   properties_hs_time_in_101188139,
   properties_hs_time_in_101188140,
   properties_hs_time_in_101188141,
   properties_hs_time_in_106321227,
   properties_hs_time_in_106321228,
   properties_hs_time_in_114835241,
   properties_hs_time_in_114835242,
   properties_hs_time_in_114835243,
   properties_hs_time_in_114835244,
   properties_hs_time_in_114835245,
   properties_hs_time_in_114835246,
   properties_hs_time_in_114835247,
   properties_hs_time_in_116479558,
   properties_hs_time_in_116479561,
   properties_hs_time_in_116479562,
   properties_hs_time_in_116479563,
   properties_hs_time_in_116661175,
   properties_hs_time_in_116661176,
   properties_hs_time_in_116661177,
   properties_hs_time_in_116661248,
   properties_hs_time_in_118108171,
   properties_hs_time_in_118132094,
   properties_hs_time_in_123939639,
   properties_hs_time_in_123939640,
   properties_hs_time_in_135040351,
   properties_hs_time_in_135565080,
   properties_hs_time_in_162198131,
   properties_hs_time_in_173911447,
   properties_hs_time_in_186169649,
   properties_hs_time_in_186178735,
   properties_hs_time_in_closedwon,
   properties_notes_last_contacted,
   properties_onboarding_scheduled,
   properties_social_media_handles,
   properties_zip_code_suitability,
   properties_deal_billing_schedule,
   properties_hs_created_by_user_id,
   properties_hs_time_in_closedlost,
   properties_hs_updated_by_user_id,
   properties_program___referred_by,
   properties_hs_likelihood_to_close,
   properties_hs_num_target_accounts,
   properties_hs_object_source_label,
   properties_hs_unique_creation_key,
   properties_photo_upload_complete_,
   properties_zcs_workflow_complete_,
   properties_amount_in_home_currency,
   properties_application_suitability,
   properties_contract_completed_date,
   properties_hs_date_exited_66768415,
   properties_hs_date_exited_85599110,
   properties_hs_date_exited_85599111,
   properties_hs_date_exited_87374903,
   properties_hs_date_exited_93117108,
   properties_hs_date_exited_95207073,
   properties_hs_date_exited_95207074,
   properties_hs_forecast_probability,
   properties_hs_next_step_updated_at,
   properties_hs_pinned_engagement_id,
   properties_hs_time_in_contractsent,
   properties_num_associated_contacts,
   properties_referred__phone_number_,
   properties_exemption_status___other,
   properties_hou___photo_not_required,
   properties_hs_date_entered_66768415,
   properties_hs_date_entered_85599110,
   properties_hs_date_entered_85599111,
   properties_hs_date_entered_87374903,
   properties_hs_date_entered_93117108,
   properties_hs_date_entered_95207073,
   properties_hs_date_entered_95207074,
   properties_hs_date_exited_101107566,
   properties_hs_date_exited_101141643,
   properties_hs_date_exited_101141644,
   properties_hs_date_exited_101141645,
   properties_hs_date_exited_101141646,
   properties_hs_date_exited_101141647,
   properties_hs_date_exited_101141648,
   properties_hs_date_exited_101141649,
   properties_hs_date_exited_101188137,
   properties_hs_date_exited_101188138,
   properties_hs_date_exited_101188139,
   properties_hs_date_exited_101188140,
   properties_hs_date_exited_101188141,
   properties_hs_date_exited_106321227,
   properties_hs_date_exited_106321228,
   properties_hs_date_exited_114835241,
   properties_hs_date_exited_114835242,
   properties_hs_date_exited_114835243,
   properties_hs_date_exited_114835244,
   properties_hs_date_exited_114835245,
   properties_hs_date_exited_114835246,
   properties_hs_date_exited_114835247,
   properties_hs_date_exited_116479558,
   properties_hs_date_exited_116479561,
   properties_hs_date_exited_116479562,
   properties_hs_date_exited_116479563,
   properties_hs_date_exited_116661175,
   properties_hs_date_exited_116661176,
   properties_hs_date_exited_116661177,
   properties_hs_date_exited_116661248,
   properties_hs_date_exited_118108171,
   properties_hs_date_exited_118132094,
   properties_hs_date_exited_123939639,
   properties_hs_date_exited_123939640,
   properties_hs_date_exited_135040351,
   properties_hs_date_exited_135565080,
   properties_hs_date_exited_162198131,
   properties_hs_date_exited_173911447,
   properties_hs_date_exited_186169649,
   properties_hs_date_exited_186178735,
   properties_hs_date_exited_closedwon,
   properties_hs_object_source_user_id,
   properties_hs_open_deal_create_date,
   properties_notes_next_activity_date,
   properties_palooza_1_scheduled_date,
   properties_palooza_1_scheduled_time,
   properties_palooza_2_scheduled_date,
   properties_palooza_2_scheduled_time,
   properties_state__multiple___sales_,
   properties_what_best_describes_you_,
   properties_hou___language_preference,
   properties_hou___uploaded_photo_link,
   properties_hs_closed_deal_close_date,
   properties_hs_date_entered_101107566,
   properties_hs_date_entered_101141643,
   properties_hs_date_entered_101141644,
   properties_hs_date_entered_101141645,
   properties_hs_date_entered_101141646,
   properties_hs_date_entered_101141647,
   properties_hs_date_entered_101141648,
   properties_hs_date_entered_101141649,
   properties_hs_date_entered_101188137,
   properties_hs_date_entered_101188138,
   properties_hs_date_entered_101188139,
   properties_hs_date_entered_101188140,
   properties_hs_date_entered_101188141,
   properties_hs_date_entered_106321227,
   properties_hs_date_entered_106321228,
   properties_hs_date_entered_114835241,
   properties_hs_date_entered_114835242,
   properties_hs_date_entered_114835243,
   properties_hs_date_entered_114835244,
   properties_hs_date_entered_114835245,
   properties_hs_date_entered_114835246,
   properties_hs_date_entered_114835247,
   properties_hs_date_entered_116479558,
   properties_hs_date_entered_116479561,
   properties_hs_date_entered_116479562,
   properties_hs_date_entered_116479563,
   properties_hs_date_entered_116661175,
   properties_hs_date_entered_116661176,
   properties_hs_date_entered_116661177,
   properties_hs_date_entered_116661248,
   properties_hs_date_entered_118108171,
   properties_hs_date_entered_118132094,
   properties_hs_date_entered_123939639,
   properties_hs_date_entered_123939640,
   properties_hs_date_entered_135040351,
   properties_hs_date_entered_135565080,
   properties_hs_date_entered_162198131,
   properties_hs_date_entered_173911447,
   properties_hs_date_entered_186169649,
   properties_hs_date_entered_186178735,
   properties_hs_date_entered_closedwon,
   properties_hs_date_exited_closedlost,
   properties_hs_deal_stage_probability,
   properties_hs_is_in_first_deal_stage,
   properties_hs_latest_approval_status,
   properties_hs_object_source_detail_1,
   properties_hs_object_source_detail_2,
   properties_hs_object_source_detail_3,
   properties_hs_time_in_qualifiedtobuy,
   properties_hs_user_ids_of_all_owners,
   properties_onboarding_scheduled_date,
   properties_onboarding_scheduled_time,
   properties_hs_all_accessible_team_ids,
   properties_hs_analytics_latest_source,
   properties_hs_analytics_source_data_1,
   properties_hs_analytics_source_data_2,
   properties_hs_closed_deal_create_date,
   properties_hs_date_entered_closedlost,
   properties_hs_latest_meeting_activity,
   properties_hs_v2_date_exited_66768415,
   properties_hs_v2_date_exited_85599110,
   properties_hs_v2_date_exited_85599111,
   properties_hs_v2_date_exited_87374903,
   properties_hs_v2_date_exited_93117108,
   properties_hs_v2_date_exited_95207073,
   properties_hs_v2_date_exited_95207074,
   properties_hubspot_owner_assigneddate,
   properties_hou_application_suitability,
   properties_hs_all_deal_split_owner_ids,
   properties_hs_date_exited_contractsent,
   properties_hs_manual_forecast_category,
   properties_hs_notes_next_activity_type,
   properties_hs_sales_email_last_replied,
   properties_hs_v2_date_entered_66768415,
   properties_hs_v2_date_entered_85599110,
   properties_hs_v2_date_entered_85599111,
   properties_hs_v2_date_entered_87374903,
   properties_hs_v2_date_entered_93117108,
   properties_hs_v2_date_entered_95207073,
   properties_hs_v2_date_entered_95207074,
   properties_hs_v2_date_exited_101107566,
   properties_hs_v2_date_exited_101141643,
   properties_hs_v2_date_exited_101141644,
   properties_hs_v2_date_exited_101141645,
   properties_hs_v2_date_exited_101141646,
   properties_hs_v2_date_exited_101141647,
   properties_hs_v2_date_exited_101141648,
   properties_hs_v2_date_exited_101141649,
   properties_hs_v2_date_exited_101188137,
   properties_hs_v2_date_exited_101188138,
   properties_hs_v2_date_exited_101188139,
   properties_hs_v2_date_exited_101188140,
   properties_hs_v2_date_exited_101188141,
   properties_hs_v2_date_exited_106321227,
   properties_hs_v2_date_exited_106321228,
   properties_hs_v2_date_exited_114835241,
   properties_hs_v2_date_exited_114835242,
   properties_hs_v2_date_exited_114835243,
   properties_hs_v2_date_exited_114835244,
   properties_hs_v2_date_exited_114835245,
   properties_hs_v2_date_exited_114835246,
   properties_hs_v2_date_exited_114835247,
   properties_hs_v2_date_exited_116479558,
   properties_hs_v2_date_exited_116479561,
   properties_hs_v2_date_exited_116479562,
   properties_hs_v2_date_exited_116479563,
   properties_hs_v2_date_exited_116661175,
   properties_hs_v2_date_exited_116661176,
   properties_hs_v2_date_exited_116661177,
   properties_hs_v2_date_exited_116661248,
   properties_hs_v2_date_exited_118108171,
   properties_hs_v2_date_exited_118132094,
   properties_hs_v2_date_exited_123939639,
   properties_hs_v2_date_exited_123939640,
   properties_hs_v2_date_exited_135040351,
   properties_hs_v2_date_exited_135565080,
   properties_hs_v2_date_exited_162198131,
   properties_hs_v2_date_exited_173911447,
   properties_hs_v2_date_exited_186169649,
   properties_hs_v2_date_exited_186178735,
   properties_hs_v2_date_exited_closedwon,
   properties_zcs___hispanic_population__,
   properties_hs_date_entered_contractsent,
   properties_hs_v2_date_entered_101107566,
   properties_hs_v2_date_entered_101141643,
   properties_hs_v2_date_entered_101141644,
   properties_hs_v2_date_entered_101141645,
   properties_hs_v2_date_entered_101141646,
   properties_hs_v2_date_entered_101141647,
   properties_hs_v2_date_entered_101141648,
   properties_hs_v2_date_entered_101141649,
   properties_hs_v2_date_entered_101188137,
   properties_hs_v2_date_entered_101188138,
   properties_hs_v2_date_entered_101188139,
   properties_hs_v2_date_entered_101188140,
   properties_hs_v2_date_entered_101188141,
   properties_hs_v2_date_entered_106321227,
   properties_hs_v2_date_entered_106321228,
   properties_hs_v2_date_entered_114835241,
   properties_hs_v2_date_entered_114835242,
   properties_hs_v2_date_entered_114835243,
   properties_hs_v2_date_entered_114835244,
   properties_hs_v2_date_entered_114835245,
   properties_hs_v2_date_entered_114835246,
   properties_hs_v2_date_entered_114835247,
   properties_hs_v2_date_entered_116479558,
   properties_hs_v2_date_entered_116479561,
   properties_hs_v2_date_entered_116479562,
   properties_hs_v2_date_entered_116479563,
   properties_hs_v2_date_entered_116661175,
   properties_hs_v2_date_entered_116661176,
   properties_hs_v2_date_entered_116661177,
   properties_hs_v2_date_entered_116661248,
   properties_hs_v2_date_entered_118108171,
   properties_hs_v2_date_entered_118132094,
   properties_hs_v2_date_entered_123939639,
   properties_hs_v2_date_entered_123939640,
   properties_hs_v2_date_entered_135040351,
   properties_hs_v2_date_entered_135565080,
   properties_hs_v2_date_entered_162198131,
   properties_hs_v2_date_entered_173911447,
   properties_hs_v2_date_entered_186169649,
   properties_hs_v2_date_entered_186178735,
   properties_hs_v2_date_entered_closedwon,
   properties_hs_v2_date_exited_closedlost,
   properties_onboarding_attendance_status,
   properties_opt_out_of_daisychain_texts_,
   properties_hs_all_collaborator_owner_ids,
   properties_hs_date_exited_qualifiedtobuy,
   properties_hs_v2_date_entered_closedlost,
   properties_hs_v2_latest_time_in_66768415,
   properties_hs_v2_latest_time_in_85599110,
   properties_hs_v2_latest_time_in_85599111,
   properties_hs_v2_latest_time_in_87374903,
   properties_hs_v2_latest_time_in_93117108,
   properties_hs_v2_latest_time_in_95207073,
   properties_hs_v2_latest_time_in_95207074,
   properties_last_message_received_content,
   properties_zcs___median_household_income,
   properties_hs_date_entered_qualifiedtobuy,
   properties_hs_v2_date_exited_contractsent,
   properties_hs_v2_latest_time_in_101107566,
   properties_hs_v2_latest_time_in_101141643,
   properties_hs_v2_latest_time_in_101141644,
   properties_hs_v2_latest_time_in_101141645,
   properties_hs_v2_latest_time_in_101141646,
   properties_hs_v2_latest_time_in_101141647,
   properties_hs_v2_latest_time_in_101141648,
   properties_hs_v2_latest_time_in_101141649,
   properties_hs_v2_latest_time_in_101188137,
   properties_hs_v2_latest_time_in_101188138,
   properties_hs_v2_latest_time_in_101188139,
   properties_hs_v2_latest_time_in_101188140,
   properties_hs_v2_latest_time_in_101188141,
   properties_hs_v2_latest_time_in_106321227,
   properties_hs_v2_latest_time_in_106321228,
   properties_hs_v2_latest_time_in_114835241,
   properties_hs_v2_latest_time_in_114835242,
   properties_hs_v2_latest_time_in_114835243,
   properties_hs_v2_latest_time_in_114835244,
   properties_hs_v2_latest_time_in_114835245,
   properties_hs_v2_latest_time_in_114835246,
   properties_hs_v2_latest_time_in_114835247,
   properties_hs_v2_latest_time_in_116479558,
   properties_hs_v2_latest_time_in_116479561,
   properties_hs_v2_latest_time_in_116479562,
   properties_hs_v2_latest_time_in_116479563,
   properties_hs_v2_latest_time_in_116661175,
   properties_hs_v2_latest_time_in_116661176,
   properties_hs_v2_latest_time_in_116661177,
   properties_hs_v2_latest_time_in_116661248,
   properties_hs_v2_latest_time_in_118108171,
   properties_hs_v2_latest_time_in_118132094,
   properties_hs_v2_latest_time_in_123939639,
   properties_hs_v2_latest_time_in_123939640,
   properties_hs_v2_latest_time_in_135040351,
   properties_hs_v2_latest_time_in_135565080,
   properties_hs_v2_latest_time_in_162198131,
   properties_hs_v2_latest_time_in_173911447,
   properties_hs_v2_latest_time_in_186169649,
   properties_hs_v2_latest_time_in_186178735,
   properties_hs_v2_latest_time_in_closedwon,
   properties_onboarding_scheduled_unix_time,
   properties_zcs___non_white_population_pct,
   properties_engagements_last_meeting_booked,
   properties_hs_num_of_associated_line_items,
   properties_hs_time_in_appointmentscheduled,
   properties_hs_v2_date_entered_contractsent,
   properties_hs_v2_latest_time_in_closedlost,
   properties_zcs___ballots_registered_voters,
   properties_hs_deal_stage_probability_shadow,
   properties_hs_time_in_decisionmakerboughtin,
   properties_hs_time_in_presentationscheduled,
   properties_hs_v2_date_exited_qualifiedtobuy,
   properties_state__for_website_inquiry_form_,
   properties_hs_analytics_latest_source_data_1,
   properties_hs_analytics_latest_source_data_2,
   properties_hs_closed_amount_in_home_currency,
   properties_hs_v2_cumulative_time_in_66768415,
   properties_hs_v2_cumulative_time_in_85599110,
   properties_hs_v2_cumulative_time_in_85599111,
   properties_hs_v2_cumulative_time_in_87374903,
   properties_hs_v2_cumulative_time_in_93117108,
   properties_hs_v2_cumulative_time_in_95207073,
   properties_hs_v2_cumulative_time_in_95207074,
   properties_hs_v2_date_entered_qualifiedtobuy,
   properties_hs_v2_latest_time_in_contractsent,
   properties_pandadoc_contract_document_status,
   properties_hs_analytics_latest_source_company,
   properties_hs_analytics_latest_source_contact,
   properties_hs_v2_cumulative_time_in_101107566,
   properties_hs_v2_cumulative_time_in_101141643,
   properties_hs_v2_cumulative_time_in_101141644,
   properties_hs_v2_cumulative_time_in_101141645,
   properties_hs_v2_cumulative_time_in_101141646,
   properties_hs_v2_cumulative_time_in_101141647,
   properties_hs_v2_cumulative_time_in_101141648,
   properties_hs_v2_cumulative_time_in_101141649,
   properties_hs_v2_cumulative_time_in_101188137,
   properties_hs_v2_cumulative_time_in_101188138,
   properties_hs_v2_cumulative_time_in_101188139,
   properties_hs_v2_cumulative_time_in_101188140,
   properties_hs_v2_cumulative_time_in_101188141,
   properties_hs_v2_cumulative_time_in_106321227,
   properties_hs_v2_cumulative_time_in_106321228,
   properties_hs_v2_cumulative_time_in_114835241,
   properties_hs_v2_cumulative_time_in_114835242,
   properties_hs_v2_cumulative_time_in_114835243,
   properties_hs_v2_cumulative_time_in_114835244,
   properties_hs_v2_cumulative_time_in_114835245,
   properties_hs_v2_cumulative_time_in_114835246,
   properties_hs_v2_cumulative_time_in_114835247,
   properties_hs_v2_cumulative_time_in_116479558,
   properties_hs_v2_cumulative_time_in_116479561,
   properties_hs_v2_cumulative_time_in_116479562,
   properties_hs_v2_cumulative_time_in_116479563,
   properties_hs_v2_cumulative_time_in_116661175,
   properties_hs_v2_cumulative_time_in_116661176,
   properties_hs_v2_cumulative_time_in_116661177,
   properties_hs_v2_cumulative_time_in_116661248,
   properties_hs_v2_cumulative_time_in_118108171,
   properties_hs_v2_cumulative_time_in_118132094,
   properties_hs_v2_cumulative_time_in_123939639,
   properties_hs_v2_cumulative_time_in_123939640,
   properties_hs_v2_cumulative_time_in_135040351,
   properties_hs_v2_cumulative_time_in_135565080,
   properties_hs_v2_cumulative_time_in_162198131,
   properties_hs_v2_cumulative_time_in_173911447,
   properties_hs_v2_cumulative_time_in_186169649,
   properties_hs_v2_cumulative_time_in_186178735,
   properties_hs_v2_cumulative_time_in_closedwon,
   properties_pandadoc_contract_participant_link,
   properties_hs_date_exited_appointmentscheduled,
   properties_hs_v2_cumulative_time_in_closedlost,
   properties_hs_v2_latest_time_in_qualifiedtobuy,
   properties_ms_application_suitability__cloned_,
   properties_hs_analytics_latest_source_timestamp,
   properties_hs_date_entered_appointmentscheduled,
   properties_hs_date_exited_decisionmakerboughtin,
   properties_hs_date_exited_presentationscheduled,
   properties_hs_predicted_amount_in_home_currency,
   properties_hs_projected_amount_in_home_currency,
   properties_hs_date_entered_decisionmakerboughtin,
   properties_hs_date_entered_presentationscheduled,
   properties_hs_deal_amount_calculation_preference,
   properties_hs_latest_approval_status_approval_id,
   properties_hs_v2_cumulative_time_in_contractsent,
   properties_engagements_last_meeting_booked_medium,
   properties_engagements_last_meeting_booked_source,
   properties_hs_v2_date_exited_appointmentscheduled,
   properties_hs_v2_cumulative_time_in_qualifiedtobuy,
   properties_hs_v2_date_entered_appointmentscheduled,
   properties_engagements_last_meeting_booked_campaign,
   properties_state___other__for_website_inquiry_form_,
   properties_hs_analytics_latest_source_data_1_company,
   properties_hs_analytics_latest_source_data_1_contact,
   properties_hs_analytics_latest_source_data_2_company,
   properties_hs_analytics_latest_source_data_2_contact,
   properties_hs_has_empty_conditional_stage_properties,
   properties_hs_user_ids_of_all_notification_followers,
   properties_hs_v2_latest_time_in_appointmentscheduled,
   properties_zcs___countywide_gov_race_dem_share__2019_,
   properties_hs_user_ids_of_all_notification_unfollowers,
   properties_hs_analytics_latest_source_timestamp_company,
   properties_hs_analytics_latest_source_timestamp_contact,
   properties_hs_v2_cumulative_time_in_appointmentscheduled,
   properties_zcs___countywide_gov_race_voter_turnout__2019_,
   properties_hs_line_item_global_term_hs_discount_percentage,
   properties_hs_line_item_global_term_recurringbillingfrequency,
   properties_hs_line_item_global_term_hs_recurring_billing_period,
   properties_hs_line_item_global_term_hs_discount_percentage_enabled,
   properties_hs_line_item_global_term_hs_recurring_billing_start_date,
   properties_hs_line_item_global_term_recurringbillingfrequency_enabled,
   properties_hs_line_item_global_term_hs_recurring_billing_period_enabled,
   properties_hs_line_item_global_term_hs_recurring_billing_start_date_enabled,
   properties_how_important_do_you_believe_protecting_the_environment_is___cloned_,
   properties_why_are_you_interested_in_being_part_of_presley_ambassadors___cloned_,
   properties_why_are_you_interested_in_being_part_of_the_capitanes_por_cambio_program_,
   {{ dbt_utils.surrogate_key([
    'dealId',
    'property',
    'timestamp',
    ]) }} as _airbyte_deals_property_history_hashid
from {{ source('cta', 'deals_property_history') }}