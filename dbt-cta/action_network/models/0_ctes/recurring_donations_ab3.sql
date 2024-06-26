{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('recurring_donations_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'status',
        'values',
        'user_id',
        'created_at',
        'updated_at',
        'next_payment',
        'failure_count',
        'fundraising_id',
        'recurring_period',
    ]) }} as _airbyte_recurring_donations_hashid,
    tmp.*
from {{ ref('recurring_donations_ab2') }} as tmp
-- recurring_donations
where 1 = 1
