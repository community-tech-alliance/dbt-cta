{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}

-- SQL model to cast each column to its adequate SQL type converted from the JSON
-- schema type
-- depends_on: {{ ref("sms_opt_ins_ab1")}}

select
    cast(id as int64) as id,
    cast(user_id as int64) as user_id,
    cast(nullif(created_date, '') as timestamp) as created_date,
    cast(nullif(modified_date, '') as timestamp) as modified_date,
    cast(organization_id as int64) as organization_id,
    cast(sms_opt_in_status as string) as sms_opt_in_status,
    cast(user__phone_number as string) as user__phone_number,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    current_timestamp() as _airbyte_normalized_at
from {{ ref("sms_opt_ins_ab1")}}
-- sms_opt_ins
where 1 = 1
