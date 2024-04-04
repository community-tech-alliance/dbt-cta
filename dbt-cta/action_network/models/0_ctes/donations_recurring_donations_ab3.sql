{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('donations_recurring_donations_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'created_at',
        'updated_at',
        'donation_id',
        'recurring_donation_id',
    ]) }} as _airbyte_donations_recurring_donations_hashid,
    tmp.*
from {{ ref('donations_recurring_donations_ab2') }} as tmp
-- donations_recurring_donations
where 1 = 1
