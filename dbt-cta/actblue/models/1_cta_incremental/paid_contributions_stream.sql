{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'Lineitem_ID',
    materialized = "incremental",
    incremental_strategy = "merge",
    on_schema_change = "sync_all_columns",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('paid_contributions_stream_ab3') }}
select
    Fee,
    safe_cast(Date as timestamp) as Date,
    Amount,
    Mobile,
    Approved,
    Comments,
    Donor_ID,
    Apple_Pay,
    Donor_ZIP,
    Recipient,
    Refund_ID,
    safe_cast(Check_Date as date) as Check_Date,
    Donor_City,
    Partner_ID,
    Payment_ID,
    Receipt_ID,
    Donor_Addr1,
    Donor_Addr2,
    Donor_Email,
    Donor_Phone,
    Donor_State,
    Double_Down,
    Lineitem_ID,
    Merchant_ID,
    Recovery_ID,
    safe_cast(Refund_Date as timestamp) as Refund_Date,
    AB_Test_Name,
    AB_Variation,
    Check_Number,
    Employer_ZIP,
    safe_cast(Payment_Date as timestamp) as Payment_Date,
    Recipient_ID,
    Recur_Weekly,
    Shipping_Zip,
    Donor_Country,
    Employer_City,
    Fundraiser_ID,
    Gift_Declined,
    safe_cast(Recovery_Date as timestamp) as Recovery_Date,
    Shipping_City,
    Donor_Employer,
    Employer_Addr1,
    Employer_Addr2,
    Employer_State,
    Reference_Code,
    Shipping_Addr1,
    Shipping_State,
    Disbursement_ID,
    Donor_Last_Name,
    Gift_Identifier,
    Smart_Recurring,
    Donor_First_Name,
    Donor_Occupation,
    Employer_Country,
    Fundraising_Page,
    Reference_Code_2,
    Shipping_Country,
    safe_cast(Disbursement_Date as timestamp) as Disbursement_Date,
    Recurrence_Number,
    Smart_Boost_Shown,
    New_Express_Signup,
    Recipient_Election,
    Smart_Boost_Amount,
    Fundraising_Partner,
    Recipient_Committee,
    Text_Message_Opt_In,
    ActBlue_Express_Lane,
    Custom_Field_1_Label,
    Custom_Field_1_Value,
    ActBlue_Express_Donor,
    Partner_Contact_Email,
    Recurring_Total_Months,
    Recurring_Upsell_Shown,
    Fundraiser_Recipient_ID,
    Weekly_Recurring_Amount,
    Fundraiser_Contact_Email,
    Monthly_Recurring_Amount,
    Partner_Contact_Last_Name,
    Partner_Contact_First_Name,
    Recurring_Upsell_Succeeded,
    Fundraiser_Contact_Last_Name,
    Fundraiser_Contact_First_Name,
    Card_Replaced_by_Account_Updater,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_paid_contributions_stream_hashid
from {{ ref('paid_contributions_stream_ab3') }}
-- paid_contributions_stream from {{ source('cta', '_airbyte_raw_paid_contributions_stream') }}
where 1 = 1
