{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('contact_attempts_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'action_id',
        'entity_id',
        'created_at',
        'updated_at',
        'campaign_id',
        'disposition',
        'created_by_id',
        'contact_info_id',
        'action_entity_id',
        'contact_info_type',
    ]) }} as _airbyte_contact_attempts_hashid,
    tmp.*
from {{ ref('contact_attempts_ab2') }} as tmp
-- contact_attempts
where 1 = 1
