{% raw %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}

{% endraw %}

-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta','{table}') }} 
select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    {columns},
    --{{ dbt_utils.surrogate_key([
    --'date',
    --'active1DayUsers',
    --'property_id',
    --]) }} as _airbyte_daily_active_users_hashid
from {{ source('cta','{table}') }}
where 1 = 1