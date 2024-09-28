{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'line_items') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    id,
    archived,
    createdAt,
    updatedAt,
    properties,
    properties_tax,
    properties_name,
    properties_price,
    properties_amount,
    properties_hs_acv,
    properties_hs_arr,
    properties_hs_mrr,
    properties_hs_sku,
    properties_hs_tcv,
    properties_hs_url,
    properties_discount,
    properties_quantity,
    properties_hs_images,
    properties_hs_margin,
    properties_createdate,
    properties_description,
    properties_hs_tax_rate,
    properties_hs_object_id,
    properties_hs_read_only,
    properties_hs_tax_label,
    properties_hs_createdate,
    properties_hs_margin_acv,
    properties_hs_margin_arr,
    properties_hs_margin_mrr,
    properties_hs_margin_tcv,
    properties_hs_product_id,
    properties_hs_variant_id,
    properties_hs_external_id,
    properties_hs_is_optional,
    properties_hs_sync_amount,
    properties_hs_all_team_ids,
    properties_hs_product_type,
    properties_hs_was_imported,
    properties_hubspot_team_id,
    properties_hs_all_owner_ids,
    properties_hs_object_source,
    properties_hubspot_owner_id,
    properties_hs_term_in_months,
    properties_hs_total_discount,
    properties_hs_post_tax_amount,
    properties_hs_shared_team_ids,
    properties_hs_shared_user_ids,
    properties_hs_lastmodifieddate,
    properties_hs_object_source_id,
    properties_hs_is_editable_price,
    properties_hs_merged_object_ids,
    properties_hs_position_on_quote,
    properties_hs_tax_rate_group_id,
    properties_hs_cost_of_goods_sold,
    properties_hs_created_by_user_id,
    properties_hs_updated_by_user_id,
    properties_hs_discount_percentage,
    properties_hs_object_source_label,
    properties_hs_pre_discount_amount,
    properties_hs_unique_creation_key,
    properties_hs_object_source_user_id,
    properties_hs_object_source_detail_1,
    properties_hs_object_source_detail_2,
    properties_hs_object_source_detail_3,
    properties_hs_user_ids_of_all_owners,
    properties_recurringbillingfrequency,
    properties_hs_all_accessible_team_ids,
    properties_hs_billing_period_end_date,
    properties_hs_line_item_currency_code,
    properties_hs_recurring_billing_terms,
    properties_hubspot_owner_assigneddate,
    properties_hs_billing_start_delay_days,
    properties_hs_billing_start_delay_type,
    properties_hs_recurring_billing_period,
    properties_hs_billing_period_start_date,
    properties_hs_billing_start_delay_months,
    properties_hs_recurring_billing_end_date,
    properties_hs_buyer_selected_quantity_max,
    properties_hs_buyer_selected_quantity_min,
    properties_hs_recurring_billing_start_date,
    properties_hs_allow_buyer_selected_quantity,
    properties_hs_all_assigned_business_unit_ids,
    properties_hs_recurring_billing_number_of_payments,
    properties_hs_user_ids_of_all_notification_followers,
    properties_hs_user_ids_of_all_notification_unfollowers,
   {{ dbt_utils.surrogate_key([
     'id',
    'archived',
    'createdAt',
    'updatedAt',
    'properties_name',
    'properties_hs_sku',
    'properties_hs_url',
    'properties_hs_images',
    'properties_createdate',
    'properties_description',
    'properties_hs_read_only',
    'properties_hs_tax_label',
    'properties_hs_createdate',
    'properties_hs_is_optional',
    'properties_hs_all_team_ids',
    'properties_hs_product_type',
    'properties_hs_was_imported',
    'properties_hubspot_team_id',
    'properties_hs_all_owner_ids',
    'properties_hs_object_source',
    'properties_hubspot_owner_id',
    'properties_hs_shared_team_ids',
    'properties_hs_shared_user_ids',
    'properties_hs_lastmodifieddate',
    'properties_hs_object_source_id',
    'properties_hs_is_editable_price',
    'properties_hs_merged_object_ids',
    'properties_hs_tax_rate_group_id',
    'properties_hs_object_source_label',
    'properties_hs_unique_creation_key',
    'properties_hs_object_source_detail_1',
    'properties_hs_object_source_detail_2',
    'properties_hs_object_source_detail_3',
    'properties_hs_user_ids_of_all_owners',
    'properties_recurringbillingfrequency',
    'properties_hs_all_accessible_team_ids',
    'properties_hs_billing_period_end_date',
    'properties_hs_line_item_currency_code',
    'properties_hs_recurring_billing_terms',
    'properties_hubspot_owner_assigneddate',
    'properties_hs_billing_start_delay_type',
    'properties_hs_recurring_billing_period',
    'properties_hs_billing_period_start_date',
    'properties_hs_recurring_billing_end_date',
    'properties_hs_recurring_billing_start_date',
    'properties_hs_allow_buyer_selected_quantity',
    'properties_hs_all_assigned_business_unit_ids',
    'properties_hs_user_ids_of_all_notification_followers',
    'properties_hs_user_ids_of_all_notification_unfollowers'
    ]) }} as _airbyte_line_items_hashid
from {{ source('cta', 'line_items') }}
