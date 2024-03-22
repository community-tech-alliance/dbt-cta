{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('donations_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'city',
        'uuid',
        'email',
        'phone',
        'state',
        'amount',
        'address',
        'country',
        'user_id',
        'tag_list',
        'zip_code',
        'last_name',
        'recurring',
        'created_at',
        'first_name',
        'updated_at',
        'display_name',
        'total_amount',
        'custom_amount',
        'custom_fields',
        'salesforce_id',
        'fundraising_id',
        'recurring_period',
        'message_to_target',
        'originating_system',
        'updates_from_creator',
        'updates_from_sponsor',
    ]) }} as _airbyte_donations_hashid,
    tmp.*
from {{ ref('donations_ab2') }} as tmp
-- donations
where 1 = 1
