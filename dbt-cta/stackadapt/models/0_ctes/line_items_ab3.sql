{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('line_items_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'state',
        'budget',
        'end_date',
        'daily_cap',
        'start_date',
        boolean_to_string('pace_evenly'),
        'revenue_type',
        'advertiser_id',
        'revenue_value',
        array_to_string('all_campaign_ids'),
        'black_list_options',
        'purchase_order_number',
    ]) }} as _airbyte_line_items_hashid,
    tmp.*
from {{ ref('line_items_ab2') }} as tmp
-- line_items
where 1 = 1
