{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta','four_weekly_active_users') }} 
select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    date,
    active28DayUsers,
    property_id,
    {{ dbt_utils.surrogate_key([
    'date',
    'active28DayUsers',
    'property_id',
    ]) }} as _airbyte_four_weekly_active_users_hashid
from {{ source('cta','four_weekly_active_users') }}
-- page
where 1 = 1
