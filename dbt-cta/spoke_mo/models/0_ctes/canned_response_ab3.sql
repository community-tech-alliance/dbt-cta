{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('canned_response_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'answer_actions_data',
        'user_id',
        'created_at',
        'answer_actions',
        'id',
        'text',
        'title',
        'campaign_id',
    ]) }} as _airbyte_canned_response_hashid,
    tmp.*
from {{ ref('canned_response_ab2') }} as tmp
-- canned_response
where 1 = 1
