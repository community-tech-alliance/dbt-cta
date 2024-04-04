{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('group_growth_by_source_codes_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'end_at',
        'group_id',
        'start_at',
        'created_at',
        'updated_at',
        'source_code',
        'total_count',
        'new_users_count',
        'last_subscription_id',
    ]) }} as _airbyte_group_growth_by_source_codes_hashid,
    tmp.*
from {{ ref('group_growth_by_source_codes_ab2') }} as tmp
-- group_growth_by_source_codes
where 1 = 1
