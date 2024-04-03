{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'Receipt_ID',
    materialized = "incremental",
    incremental_strategy = "merge",
    on_schema_change = "sync_all_columns",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('cancelled_recurring_contributions_stream_ab4') }}
select
    Donor_ZIP,
    Donor_City,
    Receipt_ID,
    Donor_Email,
    Donor_Phone,
    Donor_State,
    Cancelled_On,
    Total_Amount,
    Donor_Address,
    Donor_Country,
    Express_Donor,
    Donor_Employer,
    Reference_Code,
    Donor_Last_Name,
    Donor_First_Name,
    Donor_Occupation,
    Recurrence_Amount,
    Bump_Recurring_Seen,
    Recurrence_Frequency,
    Initial_Pledge_Length,
    Bump_Recurring_Succeeded,
    Initial_Contribution_Date,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_cancelled_recurring_contributions_stream_hashid
from {{ ref('cancelled_recurring_contributions_stream_ab4') }}
where 1 = 1
