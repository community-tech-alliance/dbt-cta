{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to dedup incoming data on Receipt_ID field
-- depends_on: {{ ref('cancelled_recurring_contributions_stream_ab2') }}

select
    *,
{{ dbt_utils.surrogate_key([
    'Donor_ZIP',
    'Donor_City',
    'Receipt_ID',
    'Donor_Email',
    'Donor_Phone',
    'Donor_State',
    'Cancelled_On',
    'Donor_Address',
    'Donor_Country',
    'Express_Donor',
    'Donor_Employer',
    'Reference_Code',
    'Donor_Last_Name',
    'Donor_First_Name',
    'Donor_Occupation',
    'Total_Amount',
    'Recurrence_Amount',
    'Bump_Recurring_Seen',
    'Recurrence_Frequency',
    'Initial_Pledge_Length',
    'Bump_Recurring_Succeeded',
    'Initial_Contribution_Date'
]) }} as _airbyte_cancelled_recurring_contributions_stream_hashid
from {{ ref('cancelled_recurring_contributions_stream_ab2') }}

