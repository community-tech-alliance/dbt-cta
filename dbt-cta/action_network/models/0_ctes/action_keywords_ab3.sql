{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('action_keywords_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'text',
        'group_id',
        'action_id',
        'created_at',
        'updated_at',
        'action_type',
    ]) }} as _airbyte_action_keywords_hashid,
    tmp.*
from {{ ref('action_keywords_ab2') }} as tmp
-- action_keywords
where 1 = 1
