{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_cancelled_recurring_contributions_stream" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    {{ json_extract_scalar('_airbyte_data', ['Donor ZIP'], ['Donor ZIP']) }} as Donor_ZIP,
    {{ json_extract_scalar('_airbyte_data', ['Donor City'], ['Donor City']) }} as Donor_City,
    {{ json_extract_scalar('_airbyte_data', ['Receipt ID'], ['Receipt ID']) }} as Receipt_ID,
    {{ json_extract_scalar('_airbyte_data', ['Donor Email'], ['Donor Email']) }} as Donor_Email,
    {{ json_extract_scalar('_airbyte_data', ['Donor Phone'], ['Donor Phone']) }} as Donor_Phone,
    {{ json_extract_scalar('_airbyte_data', ['Donor State'], ['Donor State']) }} as Donor_State,
    {{ json_extract_scalar('_airbyte_data', ['Cancelled On'], ['Cancelled On']) }} as Cancelled_On,
    {{ json_extract_scalar('_airbyte_data', ['Total Amount'], ['Total Amount']) }} as Total_Amount,
    {{ json_extract_scalar('_airbyte_data', ['Donor Address'], ['Donor Address']) }} as Donor_Address,
    {{ json_extract_scalar('_airbyte_data', ['Donor Country'], ['Donor Country']) }} as Donor_Country,
    {{ json_extract_scalar('_airbyte_data', ['Express Donor'], ['Express Donor']) }} as Express_Donor,
    {{ json_extract_scalar('_airbyte_data', ['Donor Employer'], ['Donor Employer']) }} as Donor_Employer,
    {{ json_extract_scalar('_airbyte_data', ['Reference Code'], ['Reference Code']) }} as Reference_Code,
    {{ json_extract_scalar('_airbyte_data', ['Donor Last Name'], ['Donor Last Name']) }} as Donor_Last_Name,
    {{ json_extract_scalar('_airbyte_data', ['Donor First Name'], ['Donor First Name']) }} as Donor_First_Name,
    {{ json_extract_scalar('_airbyte_data', ['Donor Occupation'], ['Donor Occupation']) }} as Donor_Occupation,
    {{ json_extract_scalar('_airbyte_data', ['Recurrence Amount'], ['Recurrence Amount']) }} as Recurrence_Amount,
    {{ json_extract_scalar('_airbyte_data', ['Bump Recurring Seen'], ['Bump Recurring Seen']) }} as Bump_Recurring_Seen,
    {{ json_extract_scalar('_airbyte_data', ['Recurrence Frequency'], ['Recurrence Frequency']) }} as Recurrence_Frequency,
    {{ json_extract_scalar('_airbyte_data', ['Initial Pledge Length'], ['Initial Pledge Length']) }} as Initial_Pledge_Length,
    {{ json_extract_scalar('_airbyte_data', ['Bump Recurring Succeeded'], ['Bump Recurring Succeeded']) }} as Bump_Recurring_Succeeded,
    {{ json_extract_scalar('_airbyte_data', ['Initial Contribution Date'], ['Initial Contribution Date']) }} as Initial_Contribution_Date,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
-- cancelled_recurring_contributions_stream
where 1 = 1
