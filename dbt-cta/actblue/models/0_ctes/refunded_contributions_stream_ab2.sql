{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('refunded_contributions_stream_ab1') }}
select
    cast(Fee as {{ dbt_utils.type_float() }}) as Fee,
    cast(Date as {{ dbt_utils.type_string() }}) as Date,
    cast(Amount as {{ dbt_utils.type_float() }}) as Amount,
    cast(Mobile as {{ dbt_utils.type_string() }}) as Mobile,
    cast(Approved as {{ dbt_utils.type_string() }}) as Approved,
    cast(Comments as {{ dbt_utils.type_string() }}) as Comments,
    cast(Donor_ID as {{ dbt_utils.type_string() }}) as Donor_ID,
    cast(Apple_Pay as {{ dbt_utils.type_string() }}) as Apple_Pay,
    cast(Donor_ZIP as {{ dbt_utils.type_string() }}) as Donor_ZIP,
    cast(Recipient as {{ dbt_utils.type_string() }}) as Recipient,
    cast(Refund_ID as {{ dbt_utils.type_bigint() }}) as Refund_ID,
    cast(Check_Date as {{ dbt_utils.type_string() }}) as Check_Date,
    cast(Donor_City as {{ dbt_utils.type_string() }}) as Donor_City,
    cast(Partner_ID as {{ dbt_utils.type_string() }}) as Partner_ID,
    cast(Payment_ID as {{ dbt_utils.type_bigint() }}) as Payment_ID,
    cast(Receipt_ID as {{ dbt_utils.type_string() }}) as Receipt_ID,
    cast(Donor_Addr1 as {{ dbt_utils.type_string() }}) as Donor_Addr1,
    cast(Donor_Addr2 as {{ dbt_utils.type_string() }}) as Donor_Addr2,
    cast(Donor_Email as {{ dbt_utils.type_string() }}) as Donor_Email,
    cast(Donor_Phone as {{ dbt_utils.type_string() }}) as Donor_Phone,
    cast(Donor_State as {{ dbt_utils.type_string() }}) as Donor_State,
    cast(Double_Down as {{ dbt_utils.type_string() }}) as Double_Down,
    cast(Lineitem_ID as {{ dbt_utils.type_bigint() }}) as Lineitem_ID,
    cast(Merchant_ID as {{ dbt_utils.type_float() }}) as Merchant_ID,
    cast(Recovery_ID as {{ dbt_utils.type_bigint() }}) as Recovery_ID,
    cast(Refund_Date as {{ dbt_utils.type_string() }}) as Refund_Date,
    cast(AB_Test_Name as {{ dbt_utils.type_string() }}) as AB_Test_Name,
    cast(AB_Variation as {{ dbt_utils.type_string() }}) as AB_Variation,
    cast(Check_Number as {{ dbt_utils.type_bigint() }}) as Check_Number,
    cast(Employer_ZIP as {{ dbt_utils.type_string() }}) as Employer_ZIP,
    cast(Payment_Date as {{ dbt_utils.type_string() }}) as Payment_Date,
    cast(Recipient_ID as {{ dbt_utils.type_bigint() }}) as Recipient_ID,
    cast(Recur_Weekly as {{ dbt_utils.type_string() }}) as Recur_Weekly,
    cast(Shipping_Zip as {{ dbt_utils.type_string() }}) as Shipping_Zip,
    cast(Donor_Country as {{ dbt_utils.type_string() }}) as Donor_Country,
    cast(Employer_City as {{ dbt_utils.type_string() }}) as Employer_City,
    cast(Fundraiser_ID as {{ dbt_utils.type_string() }}) as Fundraiser_ID,
    cast(Gift_Declined as {{ dbt_utils.type_string() }}) as Gift_Declined,
    cast(Recovery_Date as {{ dbt_utils.type_string() }}) as Recovery_Date,
    cast(Shipping_City as {{ dbt_utils.type_string() }}) as Shipping_City,
    cast(Donor_Employer as {{ dbt_utils.type_string() }}) as Donor_Employer,
    cast(Employer_Addr1 as {{ dbt_utils.type_string() }}) as Employer_Addr1,
    cast(Employer_Addr2 as {{ dbt_utils.type_string() }}) as Employer_Addr2,
    cast(Employer_State as {{ dbt_utils.type_string() }}) as Employer_State,
    cast(Reference_Code as {{ dbt_utils.type_string() }}) as Reference_Code,
    cast(Shipping_Addr1 as {{ dbt_utils.type_string() }}) as Shipping_Addr1,
    cast(Shipping_State as {{ dbt_utils.type_string() }}) as Shipping_State,
    cast(Disbursement_ID as {{ dbt_utils.type_bigint() }}) as Disbursement_ID,
    cast(Donor_Last_Name as {{ dbt_utils.type_string() }}) as Donor_Last_Name,
    cast(Gift_Identifier as {{ dbt_utils.type_string() }}) as Gift_Identifier,
    cast(Smart_Recurring as {{ dbt_utils.type_string() }}) as Smart_Recurring,
    cast(Donor_First_Name as {{ dbt_utils.type_string() }}) as Donor_First_Name,
    cast(Donor_Occupation as {{ dbt_utils.type_string() }}) as Donor_Occupation,
    cast(Employer_Country as {{ dbt_utils.type_string() }}) as Employer_Country,
    cast(Fundraising_Page as {{ dbt_utils.type_string() }}) as Fundraising_Page,
    cast(Reference_Code_2 as {{ dbt_utils.type_string() }}) as Reference_Code_2,
    cast(Shipping_Country as {{ dbt_utils.type_string() }}) as Shipping_Country,
    cast(Disbursement_Date as {{ dbt_utils.type_string() }}) as Disbursement_Date,
    cast(Recurrence_Number as {{ dbt_utils.type_bigint() }}) as Recurrence_Number,
    cast(Smart_Boost_Shown as {{ dbt_utils.type_string() }}) as Smart_Boost_Shown,
    cast(New_Express_Signup as {{ dbt_utils.type_string() }}) as New_Express_Signup,
    cast(Recipient_Election as {{ dbt_utils.type_string() }}) as Recipient_Election,
    cast(Smart_Boost_Amount as {{ dbt_utils.type_string() }}) as Smart_Boost_Amount,
    cast(Fundraising_Partner as {{ dbt_utils.type_string() }}) as Fundraising_Partner,
    cast(Recipient_Committee as {{ dbt_utils.type_string() }}) as Recipient_Committee,
    cast(Text_Message_Opt_In as {{ dbt_utils.type_string() }}) as Text_Message_Opt_In,
    cast(ActBlue_Express_Lane as {{ dbt_utils.type_string() }}) as ActBlue_Express_Lane,
    cast(Custom_Field_1_Label as {{ dbt_utils.type_string() }}) as Custom_Field_1_Label,
    cast(Custom_Field_1_Value as {{ dbt_utils.type_string() }}) as Custom_Field_1_Value,
    cast(ActBlue_Express_Donor as {{ dbt_utils.type_string() }}) as ActBlue_Express_Donor,
    cast(Partner_Contact_Email as {{ dbt_utils.type_string() }}) as Partner_Contact_Email,
    cast(Recurring_Total_Months as {{ dbt_utils.type_string() }}) as Recurring_Total_Months,
    cast(Recurring_Upsell_Shown as {{ dbt_utils.type_string() }}) as Recurring_Upsell_Shown,
    cast(Fundraiser_Recipient_ID as {{ dbt_utils.type_string() }}) as Fundraiser_Recipient_ID,
    cast(Weekly_Recurring_Amount as {{ dbt_utils.type_float() }}) as Weekly_Recurring_Amount,
    cast(Fundraiser_Contact_Email as {{ dbt_utils.type_string() }}) as Fundraiser_Contact_Email,
    cast(Monthly_Recurring_Amount as {{ dbt_utils.type_float() }}) as Monthly_Recurring_Amount,
    cast(Partner_Contact_Last_Name as {{ dbt_utils.type_string() }}) as Partner_Contact_Last_Name,
    cast(Partner_Contact_First_Name as {{ dbt_utils.type_string() }}) as Partner_Contact_First_Name,
    cast(Recurring_Upsell_Succeeded as {{ dbt_utils.type_string() }}) as Recurring_Upsell_Succeeded,
    cast(Fundraiser_Contact_Last_Name as {{ dbt_utils.type_string() }}) as Fundraiser_Contact_Last_Name,
    cast(Fundraiser_Contact_First_Name as {{ dbt_utils.type_string() }}) as Fundraiser_Contact_First_Name,
    cast(Card_Replaced_by_Account_Updater as {{ dbt_utils.type_string() }}) as Card_Replaced_by_Account_Updater,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('refunded_contributions_stream_ab1') }}
-- refunded_contributions_stream
where 1 = 1
