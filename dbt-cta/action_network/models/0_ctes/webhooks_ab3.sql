{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('webhooks_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'status',
        'group_id',
        'created_at',
        'target_url',
        'updated_at',
    ]) }} as _airbyte_webhooks_hashid,
    tmp.*
from {{ ref('webhooks_ab2') }} as tmp
-- webhooks
where 1 = 1
