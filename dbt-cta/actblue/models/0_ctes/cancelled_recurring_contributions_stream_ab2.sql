{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('cancelled_recurring_contributions_stream_ab1') }}
select
    cast(Donor_ZIP as {{ dbt_utils.type_string() }}) as Donor_ZIP,
    cast(Donor_City as {{ dbt_utils.type_string() }}) as Donor_City,
    cast(Receipt_ID as {{ dbt_utils.type_string() }}) as Receipt_ID,
    cast(Donor_Email as {{ dbt_utils.type_string() }}) as Donor_Email,
    cast(Donor_Phone as {{ dbt_utils.type_string() }}) as Donor_Phone,
    cast(Donor_State as {{ dbt_utils.type_string() }}) as Donor_State,
    cast({{ empty_string_to_null('Cancelled_On') }} as {{ type_date() }}) as Cancelled_On,
    cast(Donor_Address as {{ dbt_utils.type_string() }}) as Donor_Address,
    cast(Donor_Country as {{ dbt_utils.type_string() }}) as Donor_Country,
    cast(Express_Donor as {{ dbt_utils.type_string() }}) as Express_Donor,
    cast(Donor_Employer as {{ dbt_utils.type_string() }}) as Donor_Employer,
    cast(Reference_Code as {{ dbt_utils.type_string() }}) as Reference_Code,
    cast(Donor_Last_Name as {{ dbt_utils.type_string() }}) as Donor_Last_Name,
    cast(Donor_First_Name as {{ dbt_utils.type_string() }}) as Donor_First_Name,
    cast(Donor_Occupation as {{ dbt_utils.type_string() }}) as Donor_Occupation,
    safe_cast(regexp_replace(Total_Amount, r'\$|,', '') as numeric) as Total_Amount,
    safe_cast(regexp_replace(Recurrence_Amount, r'\$|,', '') as numeric) as Recurrence_Amount,
    cast(Bump_Recurring_Seen as {{ dbt_utils.type_string() }}) as Bump_Recurring_Seen,
    cast(Recurrence_Frequency as {{ dbt_utils.type_string() }}) as Recurrence_Frequency,
    cast(Initial_Pledge_Length as {{ dbt_utils.type_string() }}) as Initial_Pledge_Length,
    cast(Bump_Recurring_Succeeded as {{ dbt_utils.type_string() }}) as Bump_Recurring_Succeeded,
    cast({{ empty_string_to_null('Initial_Contribution_Date') }} as {{ type_date() }}) as Initial_Contribution_Date,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('cancelled_recurring_contributions_stream_ab1') }}
-- cancelled_recurring_contributions_stream
where 1 = 1
