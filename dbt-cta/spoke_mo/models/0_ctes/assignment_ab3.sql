{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('assignment_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'max_contacts',
        'user_id',
        'created_at',
        'id',
        'campaign_id',
    ]) }} as _airbyte_assignment_hashid,
    tmp.*
from {{ ref('assignment_ab2') }} as tmp
-- assignment
where 1 = 1
